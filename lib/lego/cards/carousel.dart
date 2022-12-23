import 'dart:async';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';

import 'package:server_driven_ui/lego/cards/cards.dart';
import 'package:server_driven_ui/lego/filters/helpers.dart';

@immutable
class CarouselCardData extends BaseCardData {
  static const type = 'carousel';

  final List<BaseCardData> cards;
  final bool autoPlay;

  /// After how many seconds should the cards be auto-scrolled
  final int autoPlayDuration;

  CarouselCardData.fromJson(Map<String, dynamic> json)
      : cards = ((json['cards'] ?? []) as List<dynamic>)
            .whereType<Map<String, dynamic>>()
            .map(tryParser((c) => BaseCardData.fromJson(c)))
            .whereType<BaseCardData>()
            .toList(),
        autoPlay = json['auto_play'] ?? false,
        autoPlayDuration = json['auto_play_duration'] ?? 5,
        super(json);

  @override
  Widget widget() => CarouselCards(
        cards: cards
            .where((card) => !card.hidden)
            .map((card) => card.widget())
            .toList(),
        autoPlay: autoPlay,
        autoPlayDuration: autoPlayDuration,
      );
}

class CarouselCards extends StatefulWidget {
  final List<Widget> cards;
  final bool autoPlay;
  final int autoPlayDuration;

  const CarouselCards({
    Key? key,
    required this.cards,
    required this.autoPlay,
    required this.autoPlayDuration,
  }) : super(key: key);

  @override
  State<CarouselCards> createState() => _CarouselCardsState();
}

class _CarouselCardsState extends State<CarouselCards> {
  late final PageController _pageController;
  int _currentCarouselPage = 0;
  Timer? _timer;

  _CarouselCardsState();

  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.8);
    _resetTimer();
    super.initState();
  }

  @override
  void didUpdateWidget(CarouselCards oldWidget) {
    if (_currentCarouselPage >= widget.cards.length) {
      _currentCarouselPage = widget.cards.length - 1;
      if (!_pageController.hasClients) return;
      _pageController.jumpToPage(_currentCarouselPage);
    }
    super.didUpdateWidget(oldWidget);
  }

  void _resetTimer() {
    if (!widget.autoPlay) return;

    _timer?.cancel();

    _timer = Timer(Duration(seconds: widget.autoPlayDuration), () {
      if (!_pageController.hasClients) return;
      _currentCarouselPage = (_currentCarouselPage + 1) % widget.cards.length;
      _pageController.animateToPage(
        _currentCarouselPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeIn,
      );
    });
  }

  _onPageChanged(int page) {
    // Reset timer so that the page doesn't auto-scroll immediately after the
    // user scrolls to a particular card.
    _resetTimer();
    setState(() => _currentCarouselPage = page);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.cards.isEmpty) return Container();
    if (widget.cards.length == 1) return widget.cards[0];

    return Stack(
      children: [
        ExpandablePageView.builder(
          controller: _pageController,
          animationDuration: const Duration(milliseconds: 500),
          animationCurve: Curves.decelerate,
          pageSnapping: true,
          padEnds: false,
          onPageChanged: _onPageChanged,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: widget.cards[index]);
          },
          itemCount: widget.cards.length,
        ),
        Positioned(
          bottom: 5,
          right: 0,
          left: 0,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: DotsIndicator(
              dotsCount: widget.cards.length,
              position: _currentCarouselPage.toDouble(),
              decorator: const DotsDecorator(
                  activeColor: Colors.white,
                  color: Colors.transparent,
                  shape: CircleBorder(
                      side: BorderSide(color: Colors.yellow, width: 1.5)),
                  activeShape: CircleBorder(
                      side: BorderSide(color: Colors.transparent))),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
