import 'package:flutter/material.dart';

import '../../event_tracker/event_tracker.dart';

import '../../models/media.dart';
import '../filters/helpers.dart';

class LaunchMedia {
  static const type = 'media';

  final List<Media> media;

  LaunchMedia.fromJson(Map<String, dynamic> json)
      : media = ((json['media'] ?? []) as List<dynamic>)
            .whereType<Map<String, dynamic>>()
            .map(tryParser((media) => Media.fromJson(media)))
            .whereType<Media>()
            // Only images are supported in this version of the app
            .where((media) => media.mediaType == MediaType.image)
            .toList();

  Future<void> launchMediaPreview(
      BuildContext context, Map<String, dynamic> aParams) async {
    eventTracker.log('open_media_page', aParams);
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Scaffold()));
  }
}
