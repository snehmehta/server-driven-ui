import '../exceptions.dart';
import 'app_version.dart';
import 'auth.dart';
import 'compound.dart';
import 'helpers.dart';

abstract class LegoFilter {
  bool display();

  LegoFilter();

  factory LegoFilter.fromJson(Map<String, dynamic> json) {
    switch (json['type']) {
      case All.type:
        return All.fromJson(json);
      case Any.type:
        return Any.fromJson(json);
      case Not.type:
        return Not.fromJson(json);
      case Authentication.type:
        return Authentication.fromJson(json);
      case MinVersion.type:
        return MinVersion.fromJson(json);
      case MaxVersion.type:
        return MaxVersion.fromJson(json);
    }
    throw InvalidLegoFilterException(json['type'] ?? 'null');
  }

  factory LegoFilter.fromDynamic(dynamic value) => value is List
      ? All.fromList(List<Map<String, dynamic>>.from(value))
      : tryParser((v) => LegoFilter.fromJson(v))(value) ?? Always();
}

class Always extends LegoFilter {
  @override
  bool display() => true;
}

class Never extends LegoFilter {
  @override
  bool display() => false;
}
