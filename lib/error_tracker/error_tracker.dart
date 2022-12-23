import 'package:flutter/foundation.dart';

import 'breadcrumbs.dart';

final errorTracker = _ErrorTracker();

class _ErrorTracker {
  _init(String station) async {
    await Future.wait([
      // _initSentry(station),
      // FirebaseCrashlytics.instance.setCustomKey('station', station),
    ]);
  }

  void onFlutterError(FlutterErrorDetails e, {bool fatal = false}) {
    captureError(e, e.stack, fatal: fatal);
    if (kDebugMode) FlutterError.dumpErrorToConsole(e);
  }

  Future<void> captureError(
    dynamic error,
    StackTrace? stackTrace, {
    dynamic hint,
    bool fatal = false,
  }) async {
    await Future.wait([
      //   Sentry.captureException(error, stackTrace: stackTrace, hint: hint),
      //   if (error is FlutterErrorDetails)
      //     FirebaseCrashlytics.instance.recordFlutterError(error, fatal: fatal)
      //   else
      //     FirebaseCrashlytics.instance
      //         .recordError(error, stackTrace, fatal: fatal),
    ]);
  }

  Future<void> addBreadCrumb(
    String message, {

    /// A dictionary whose contents depend on the breadcrumb type. Additional
    /// parameters that are unsupported by the type are rendered as a key/value
    /// table.
    Map<String, dynamic>? data,

    /// A dotted string indicating what the crumb is or from where it comes.
    /// Typically it is a module name or a descriptive string. For instance,
    /// ui.click could be used to indicate that a click happened in the UI or
    /// flask could be used to indicate the event originated in that framework.
    String? category,
    BreadCrumbType type = BreadCrumbType.default_,
  }) async {
    // Sentry.addBreadcrumb(Breadcrumb(
    //   message: message,
    //   data: data,
    //   category: category,
    //   type: type.value(),
    //   timestamp: DateTime.now(),
    // ));
    // FirebaseCrashlytics.instance.log(message + (data != null ? ': $data' : ''));
  }

  Future<void> log(String message) async {
    await Future.wait([
      // Sentry.captureMessage(message),
      // FirebaseCrashlytics.instance.log(message),
    ]);
  }
}

Future<void> initErrorTracker(String station) async {
  await errorTracker._init(station);
}

// Future<void> _initSentry(String station) async {
  // await SentryFlutter.init(
  //   (options) {
  //     options.environment = sentryEnvironment;
  //     options.dsn = sentryDSN;
  //     options.tracesSampleRate = 0.1;
  //     options.sendDefaultPii = true;
  //     if (!kDebugMode) {
  //       options.debug = true;
  //     }
  //   },
  // );
  // Sentry.configureScope((scope) => scope.setTag('station', station));
// }
