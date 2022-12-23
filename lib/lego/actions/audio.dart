class Audio {
  static const type = 'audio';

  final String url;
  final String? title;
  final String? artist;
  final bool isLive;
  final bool isRadio;

  Audio.fromJson(Map<String, dynamic> json)
      : url = json['url'],
        title = json['title'] ?? 'Server-Driven-UI',
        artist = json['artist'],
        isLive = json['live'] ?? true,
        isRadio = json['is_radio'] ?? false;
}
