import '../exceptions.dart';
import 'audio.dart';
import 'launch_app_review.dart';
import 'launch_media.dart';
import 'launch_share.dart';
import 'launch_url.dart';
// import 'navigation.dart';

enum LegoActionType {
  noOp,
  launchUrl,
  inAppReview,
  media,
  navigate,
  share,
  audio,
  carousel
}

LegoActionType getActionType(Map<String, dynamic>? action) {
  action ??= {};
  final type = (action['type'] ?? '') as String;
  switch (type) {
    case '':
      return LegoActionType.noOp;
    case 'noop':
      return LegoActionType.noOp;

    case Audio.type:
      return LegoActionType.audio;
    case LaunchAppReview.type:
      return LegoActionType.inAppReview;
    case LaunchUrl.type:
      return LegoActionType.launchUrl;
    case LaunchMedia.type:
      return LegoActionType.media;
    // case Navigation.type:
    //   return LegoActionType.navigate;
    case LaunchShare.type:
      return LegoActionType.share;
    default:
      throw InvalidLegoActionTypeException(type);
  }
}
