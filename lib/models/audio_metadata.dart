class AudioMetaData {
  final String url;
  final String? id;
  final String? analyticsKey;
  final String? title;
  final String? image;
  final bool isRadio;
  final String? artist;
  final bool isLiveUrl;
  final String? timetable;

  AudioMetaData(this.url,
      {this.id,
      this.analyticsKey,
      this.title,
      this.image,
      this.isRadio = false,
      this.artist,
      this.isLiveUrl = true,
      this.timetable});

  AudioMetaData.empty()
      : url = '',
        analyticsKey = null,
        title = 'रेडियो रॉकेट',
        image = null,
        id = null,
        artist = null,
        isRadio = false,
        isLiveUrl = true,
        timetable = null;

  AudioMetaData.fromJson(Map<String, dynamic> json)
      : url = (json['url'] is String) ? json['url'].trim() : '',
        id = json['id'],
        analyticsKey = json['analytics_key'],
        title = json['title'],
        image = json['image'],
        isRadio = json['is_radio'] ?? false,
        artist = json['artist'],
        isLiveUrl = json['is_live_url'] ?? true,
        timetable = json['timetable'];
}
