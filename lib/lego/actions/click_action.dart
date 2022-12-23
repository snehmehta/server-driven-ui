import 'package:flutter/widgets.dart';

import '../exceptions.dart';
import 'actions.dart';
import 'launch_app_review.dart';
import 'launch_media.dart';
import 'launch_share.dart';
import 'launch_url.dart';
// import 'navigation.dart';

class ClickAction {
  LegoActionType actionType;
  String cardType;

  LaunchAppReview? launchAppReview;
  LaunchMedia? launchMedia;
  LaunchShare? share;
  LaunchUrl? launchUrl;
  // Navigation? navigation;

  ClickAction(this.actionType, this.cardType, Map<String, dynamic>? json) {
    if (actionType == LegoActionType.noOp) return;
    if (json == null) {
      throw UnsupportedLegoActionException(cardType, actionType);
    }
    switch (actionType) {
      case LegoActionType.inAppReview:
        launchAppReview = LaunchAppReview();
        return;
      case LegoActionType.media:
        launchMedia = LaunchMedia.fromJson(json);
        return;
      case LegoActionType.launchUrl:
        launchUrl = LaunchUrl.fromJson(json);
        return;
      case LegoActionType.share:
        share = LaunchShare.fromJson(json);
        return;
      // case LegoActionType.navigate:
      //   navigation = Navigation.fromJson(json);
      //   return;
      default:
        throw UnsupportedLegoActionException(cardType, actionType);
    }
  }

  Future<void> onTap(BuildContext context, Map<String, dynamic> aParams) async {
    switch (actionType) {
      case LegoActionType.noOp:
        return;

      case LegoActionType.inAppReview:
        return launchAppReview!.launchReviewDialog(aParams: aParams);
      case LegoActionType.launchUrl:
        return launchUrl!.launchUrl(aParams: aParams);
      case LegoActionType.media:
        return launchMedia!.launchMediaPreview(context, aParams);
      // case LegoActionType.navigate:
      //   return navigation!.navigate(context, aParams);
      case LegoActionType.share:
        return share!.share(aParams: aParams);
      default:
        throw UnsupportedLegoActionException(cardType, actionType);
    }
  }
}
