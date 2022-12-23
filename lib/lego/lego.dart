import 'package:flutter/material.dart';

import '../error_tracker/error_tracker.dart';

import 'cards/cards.dart';
import 'filters/helpers.dart';

class Lego {
  final List<LegoRow> rows;

  static Future<Lego> fromJson(Map<String, dynamic> json) async {
    // final src = json['src'];
    if (json['src'] == null) return Lego._fromJson(json);
    try {
      // final res = await Dio().get(src);
      // if (res.statusCode == 200) {
      //   return Lego._fromJson(res.data);
      // }
    } catch (e, s) {
      errorTracker.captureError(e, s);
    }
    return Lego._fromJson(json);
  }

  Lego._fromJson(Map<String, dynamic> json)
      : rows = ((json['rows'] ?? []) as List<dynamic>)
            .whereType<Map<String, dynamic>>()
            .map(tryParser((row) => LegoRow.fromJson(row)))
            .whereType<LegoRow>()
            .toList();

  Widget widget() => _LegoWidget(rows);
}

class _LegoWidget extends StatelessWidget {
  final List<LegoRow> rows;

  const _LegoWidget(this.rows, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (rows.isEmpty) return Container();
    return _ScreenWidget(rows: rows);
  }
}

class _ScreenWidget extends StatelessWidget {
  final List<LegoRow> rows;

  const _ScreenWidget({required this.rows, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: rows.map((row) => row.widget()).toList(),
    );
  }
}

class LegoRow {
  final List<BaseCardData> cards;
  final bool wrap;

  LegoRow.fromJson(Map<String, dynamic> json)
      : wrap = json['wrap'] ?? false,
        cards = ((json['cards'] ?? []) as List<dynamic>)
            .whereType<Map<String, dynamic>>()
            .map(tryParser((card) => BaseCardData.fromJson(card)))
            .whereType<BaseCardData>()
            .where((card) => card.isValid())
            .toList();

  Widget widget() => _LegoRowWidget(cards: cards, wrap: wrap);
}

class _LegoRowWidget extends StatelessWidget {
  final List<BaseCardData> cards;
  final bool wrap;

  _LegoRowWidget({
    this.wrap = false,
    required List<BaseCardData> cards,
    Key? key,
  })  : cards = cards.where((card) => !card.hidden).toList(growable: false),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (cards.isEmpty) return Container();
    if (wrap) {
      return Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 12,
          runSpacing: 15,
          children: cards.map((card) => card.widget()).toList());
    }
    return Row(
        children: cards
            .map((card) => Flexible(
                  key: ValueKey(card.id),
                  flex: card.flex,
                  child: Padding(
                      padding: const EdgeInsets.all(5), child: card.widget()),
                ))
            .toList());
  }
}
