import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'package:share_plus/share_plus.dart';

class LaunchShare {
  static const type = 'share';

  final String? text;
  final List<String> media;
  final String id;

  LaunchShare.fromJson(Map<String, dynamic> json)
      : text = json['text'] ?? '',
        id = json['id'],
        media = json['media'] == null ? [] : json['media'].cast<String>();

  Future<void> share({required Map<String, dynamic> aParams}) async {
    List<String> files = [];
    for (var url in media) {
      var file = await DefaultCacheManager().getSingleFile(url);
      files.add(file.path);
    }

    files.isEmpty
        ? await Share.share(text ?? '')
        : await Share.shareFiles(files, text: text);
  }
}
