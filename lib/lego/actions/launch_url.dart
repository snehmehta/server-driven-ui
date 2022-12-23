import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'package:url_launcher/url_launcher_string.dart';

import '../../error_tracker/error_tracker.dart';
import '../../event_tracker/event_tracker.dart';

class LaunchUrl {
  static const type = 'url';

  final String url;
  final bool webview;

  LaunchUrl(this.url, {this.webview = false});

  LaunchUrl.fromJson(Map<String, dynamic> json)
      : url = json['url'],
        webview = json['webview'] ?? false;

  Future<void> launchUrl({Map<String, dynamic>? aParams}) async {
    eventTracker.log('launch_url', aParams);
    final Uri uri;
    try {
      uri = Uri.parse(url);
    } on FormatException catch (e, s) {
      errorTracker.captureError('Invalid url: $url', s);
      return;
    }
    var canLaunchLink = await url_launcher.canLaunchUrl(uri);
    if (canLaunchLink) {
      await url_launcher.launchUrl(uri,
          mode: webview
              ? LaunchMode.inAppWebView
              : LaunchMode.externalApplication);
    } else {
      errorTracker.captureError("Can't launch url: $url", null);
    }
  }
}
