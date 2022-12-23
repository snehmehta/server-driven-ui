import 'package:flutter/material.dart';

import 'cards.dart';

class SpacerCard extends BaseCardData {
  SpacerCard.fromJson(Map<String, dynamic> json) : super(json);

  @override
  Widget widget() => Container();
}
