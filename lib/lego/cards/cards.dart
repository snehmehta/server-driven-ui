import 'package:flutter/material.dart';
import 'package:server_driven_ui/lego/cards/text.dart';

import '../actions/actions.dart';
import '../exceptions.dart';
import '../filters/filters.dart';
import 'audio.dart';
import 'carousel.dart';
import 'image.dart';

import 'spacer.dart';

abstract class BaseCardData {
  final String id;
  final int flex;
  final LegoActionType actionType;
  final LegoFilter? filter;
  final String? analyticsKey;

  /// Card won't be shown in the UI, but would remain as part of the Lego
  /// config. This can be helpful if the card is required for any other purpose/
  /// side-effects, like including the Audio Card, which doesn't need to be
  /// explicitly displayed in the UI, but will be part of the playlist.
  final bool hidden;

  BaseCardData(Map<String, dynamic> json)
      : id = json['id'],
        flex = json['flex'] ?? 1,
        actionType = getActionType(json['action']),
        filter = json['filters'] != null
            ? LegoFilter.fromDynamic(json['filters'])
            : null,
        analyticsKey = json['analytics_key'],
        hidden = json['hidden'] ?? false;

  bool isValid() => filter?.display() ?? true;

  factory BaseCardData.fromJson(Map<String, dynamic> json) {
    try {
      return BaseCardData._fromJson(json);
    } catch (e) {
      if (json['fallback'] != null) {
        return BaseCardData.fromJson(json['fallback']);
      }
      rethrow;
    }
  }

  factory BaseCardData._fromJson(Map<String, dynamic> json) {
    switch (json['type']) {
      case ImageCardData.type:
        return ImageCardData.fromJson(json);
      case AudioCardData.type:
        return AudioCardData.fromJson(json);

      case TextCardData.type:
        return TextCardData.fromJson(json);
      case CarouselCardData.type:
        return CarouselCardData.fromJson(json);
      case 'spacer':
        return SpacerCard.fromJson(json);
      default:
        throw InvalidLegoCardTypeException(json['type'] ?? 'null');
    }
  }

  Widget widget();
}
