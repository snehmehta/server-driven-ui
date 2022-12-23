import 'package:flutter/material.dart';

import '../../models/audio_metadata.dart';

import '../actions/audio.dart';
import '../filters/helpers.dart';
import 'cards.dart';
import 'image.dart';

class AudioCardData extends BaseCardData {
  static const type = 'audio';

  final String image;
  final String thumbnail;
  final Audio audio;
  final String? timetable;
  final String? caption;
  final List<CaptionAction> captionActions;

  AudioCardData.fromJson(Map<String, dynamic> json)
      : image = json['image'],
        thumbnail = json['thumbnail'] ?? json['image'],
        audio = Audio.fromJson(json['action']),
        timetable = json['timetable'],
        caption = json['caption'],
        captionActions = ((json['caption_actions'] ?? []) as List<dynamic>)
            .whereType<Map<String, dynamic>>()
            .map(tryParser((c) => CaptionAction.fromJson(c)))
            .whereType<CaptionAction>()
            .toList(),
        super(json);

  @override
  Widget widget() => AudioCardWidget(this);
}

class AudioCardWidget extends StatelessWidget {
  final AudioCardData audioCardData;
  final AudioMetaData audioMetaData;

  AudioCardWidget(this.audioCardData, {Key? key})
      : audioMetaData = AudioMetaData(
          audioCardData.audio.url,
          id: audioCardData.id,
          image: audioCardData.image,
          analyticsKey: audioCardData.analyticsKey,
          title: audioCardData.audio.title,
          isLiveUrl: audioCardData.audio.isLive,
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ImageCard(
          image: audioCardData.image,
          caption: audioCardData.caption,
          captionActions: audioCardData.captionActions,
          onTap: (_) {},
        ),
        const Positioned(right: 10, top: 10, child: CircleAvatar()),
      ],
    );
  }
}
