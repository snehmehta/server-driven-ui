import 'filters.dart';

class MinVersion extends LegoFilter {
  static const type = 'min_version';

  final int minVersion;

  MinVersion.fromJson(Map<String, dynamic> json) : minVersion = json['version'];

  @override
  bool display() => 1 >= minVersion;
}

class MaxVersion extends LegoFilter {
  static const type = 'max_version';

  final int maxVersion;

  MaxVersion.fromJson(Map<String, dynamic> json) : maxVersion = json['version'];

  @override
  bool display() => 93 <= maxVersion;
}
