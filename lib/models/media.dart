class Media {
  final String? id;
  final String url;
  final String? shareText;
  final String filename;
  final String? _mimeType;
  final bool download;
  final bool share;
  final MediaType mediaType;
  bool isYoutube;

  Media({
    this.id,
    this.shareText,
    required this.filename,
    required this.download,
    required this.share,
    required this.mediaType,
    required this.url,
    String? mimeType,
  })  : _mimeType = mimeType,
        isYoutube = url.startsWith('https://www.youtube.com/');

  Media.video(this.id, this.url,
      {this.download = false,
      this.share = false,
      this.isYoutube = false,
      this.filename = '',
      this.shareText})
      : mediaType = MediaType.video,
        _mimeType = 'video/*';

  static String _getFileName(url) =>
      url.substring(url.lastIndexOf('/') + 1).split('?').first;

  String get mimeType {
    if (_mimeType != null) return _mimeType!;
    if (mediaType == MediaType.image) {
      if (filename.contains('.jpg')) return 'image/jpg';
      if (filename.contains('.png')) return 'image/png';
      return 'image/*';
    }
    return 'video/*';
  }

  Media.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        url = json['url'],
        filename = json['filename'] ?? _getFileName(json['url']),
        _mimeType = json['mime_type'],
        shareText = json['text'],
        download = json['download'] ?? false,
        share = json['share'] ?? true,
        mediaType = MediaType.values
            .firstWhere((value) => (json['type'] ?? 'image') == value.name),
        isYoutube = false;
}

enum MediaType { image, video, animatedGif }
