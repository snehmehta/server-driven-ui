import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../actions/actions.dart';
import '../actions/click_action.dart';
import '../actions/launch_url.dart';
import '../filters/helpers.dart';
import 'cards.dart';

class ImageCardData extends BaseCardData {
  static const type = 'image';

  String? caption;
  String image;
  List<CaptionAction> captionActions = [];
  ClickAction? clickAction;

  ImageCardData.fromJson(Map<String, dynamic> json)
      : caption = json['caption'] ?? '',
        image = json['image'],
        captionActions = ((json['caption_actions'] ?? []) as List<dynamic>)
            .whereType<Map<String, dynamic>>()
            .map(tryParser((c) => CaptionAction.fromJson(c)))
            .whereType<CaptionAction>()
            .toList(),
        super(json) {
    clickAction = ClickAction(actionType, type, json['action'] ?? {});
  }

  Future<void> _onTap(BuildContext context) async {
    final aParams = <String, dynamic>{
      'id': id,
      'source': 'image_card_click',
      if (analyticsKey != null) 'key': analyticsKey,
    };
    clickAction?.onTap(context, aParams);
  }

  @override
  Widget widget() => ImageCard(
        image: image,
        caption: caption,
        captionActions: captionActions,
        onTap: _onTap,
      );
}

class CaptionAction {
  String? icon;
  String? text;
  String? backgroundColor;
  String? textColor;
  LaunchUrl? launchUrl;
  String? analyticsKey;

  LegoActionType actionType;
  ClickAction? action;

  CaptionAction.fromJson(Map<String, dynamic> json)
      : icon = json['icon'],
        text = json['text'],
        textColor = json['text_color'],
        backgroundColor = json['background_color'],
        actionType = getActionType(json['action']) {
    action = ClickAction(actionType, ImageCardData.type, json['action']);
  }

  Future<void> onTap(BuildContext context) async {
    final aParams = <String, dynamic>{
      'source': 'image_caption_click',
      if (analyticsKey != null) 'key': analyticsKey,
    };
    action?.onTap(context, aParams);
  }
}

class ImageCard extends StatelessWidget {
  final String image;
  final String caption;
  final List<CaptionAction> captionActions;
  final Function(BuildContext) onTap;

  ImageCard({
    Key? key,
    required this.onTap,
    required this.image,
    String? caption,
    List<CaptionAction>? captionActions,
  })  : caption = caption ?? '',
        captionActions = captionActions ?? [],
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(context),
      child: (caption.isNotEmpty || captionActions.isNotEmpty)
          ? _ImageCardWithText(
              image: image,
              caption: caption,
              captionActions: captionActions,
            )
          : _ImageCard(image: image),
    );
  }
}

class _ImageCardWithText extends StatelessWidget {
  final String image;
  final String caption;
  final List<CaptionAction> captionActions;

  const _ImageCardWithText({
    Key? key,
    required this.image,
    required this.caption,
    required this.captionActions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: width,
      decoration: BoxDecoration(
          color: const Color(0xff090919),
          border: Border.all(color: Colors.white24, width: 0.5),
          borderRadius: const BorderRadius.all(Radius.circular(15))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(15)),
              child: CachedNetworkImage(
                  imageUrl: image, fit: BoxFit.fill, width: double.infinity)),
          const SizedBox(height: 7),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(caption,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600)),
                ),
                if (captionActions.isNotEmpty) ...[
                  IntrinsicHeight(
                    child: Wrap(
                      spacing: 5,
                      crossAxisAlignment: WrapCrossAlignment.end,
                      //  direction: Axis.vertical,
                      alignment: WrapAlignment.end,
                      runAlignment: WrapAlignment.end,
                      runSpacing: 10,
                      children: captionActions
                          .map((c) => _CaptionActionButton(captionAction: c))
                          .toList(),
                    ),
                  )
                ]
              ],
            ),
          ),
          const SizedBox(height: 7),
        ],
      ),
    );
  }
}

class _ImageCard extends StatefulWidget {
  final String image;

  const _ImageCard({Key? key, required this.image}) : super(key: key);

  @override
  State<_ImageCard> createState() => _ImageCardState();
}

class _ImageCardState extends State<_ImageCard> {
  Widget? _oldWidget;

  @override
  void didUpdateWidget(covariant _ImageCard oldWidget) {
    _oldWidget = oldWidget;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        child: CachedNetworkImage(
          imageUrl: widget.image,
          placeholder: (_, __) => _oldWidget ?? const SizedBox(),
          fit: BoxFit.fill,
        ));
  }
}

class _CaptionActionButton extends StatelessWidget {
  final CaptionAction captionAction;

  const _CaptionActionButton({Key? key, required this.captionAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => captionAction.onTap(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            color: captionAction.backgroundColor == null
                ? Theme.of(context).primaryColorLight
                : HexColor.fromHex(captionAction.backgroundColor!),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (captionAction.icon != null &&
                captionAction.icon!.isNotEmpty) ...[
              CachedNetworkImage(
                  imageUrl: captionAction.icon!, height: 15, width: 15),
              const SizedBox(width: 5)
            ],
            Text(
              captionAction.text ?? '',
              style: TextStyle(
                  fontSize: 12,
                  color: captionAction.textColor == null
                      ? Colors.white
                      : HexColor.fromHex(captionAction.textColor!.trim())),
            )
          ],
        ),
      ),
    );
  }
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
