final eventTracker = _EventTracker();

class _EventTracker {
  void log(String name, [Map<String, dynamic>? params]) {
    // Copy params, since we might receive a `const` map which we can't modify.
    // params ??= {};
    // _firebaseAnalytics.logEvent(
    //   name: name,
    //   parameters: Map<String, Object?>.from(params),
    // );
    // _facebookAppEvents.logEvent(name: name, parameters: params);
    // WebEngagePlugin.trackEvent(name, params);
    // smartlook.trackEvent(name, params);
    // Event.add(name, params);
  }

  void screen(String screenName, [Map<String, dynamic>? params]) {
    // _firebaseAnalytics.setCurrentScreen(screenName: screenName);
    // WebEngagePlugin.trackScreen(screenName, params);
    // Event.add('screen', {'name': screenName});
  }
}
