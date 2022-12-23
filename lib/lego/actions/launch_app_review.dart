import 'package:in_app_review/in_app_review.dart';

import '../../event_tracker/event_tracker.dart';

class LaunchAppReview {
  static const type = 'app_review';

  Future<void> launchReviewDialog({Map<String, dynamic>? aParams}) async {
    eventTracker.log('app_review', aParams);
    final InAppReview inAppReview = InAppReview.instance;
    if (await inAppReview.isAvailable()) inAppReview.requestReview();
  }
}
