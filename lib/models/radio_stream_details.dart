class RadioStreamDetails {
  final String url;
  final String? id;
  final String? title;
  final String? artist;

  const RadioStreamDetails({
    required this.url,
    this.id,
    this.title,
    this.artist,
  });

  RadioStreamDetails.fromJson(Map<String, dynamic> json)
      : url = json['url'],
        id = json['id'],
        title = json['title'],
        artist = json['artist'];

  Map<String, dynamic> toJson() => {
        'url': url,
        if (id != null) 'id': id,
        'title': title,
        'artist': artist,
      };
}
