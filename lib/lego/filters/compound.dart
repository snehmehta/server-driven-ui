import 'filters.dart';
import 'helpers.dart';

class All extends LegoFilter {
  static const type = 'all';
  final List<LegoFilter> filters;

  All.fromList(List<Map<String, dynamic>> filters)
      : filters = filters
            .map(tryParser((filter) => LegoFilter.fromJson(filter)))
            .whereType<LegoFilter>()
            .toList();

  factory All.fromJson(Map<String, dynamic> json) =>
      All.fromList(json['filters'] as List<Map<String, dynamic>>);

  @override
  bool display() => filters.every((filter) => filter.display());
}

class Any extends LegoFilter {
  static const type = 'any';
  final List<LegoFilter> filters;

  Any.fromJson(Map<String, dynamic> json)
      : filters = (json['filters'] as List<Map<String, dynamic>>)
            .map(tryParser((filter) => LegoFilter.fromJson(filter)))
            .whereType<LegoFilter>()
            .toList();

  @override
  bool display() => filters.any((filter) => filter.display());
}

class Not extends LegoFilter {
  static const type = 'not';
  final LegoFilter filter;

  Not(this.filter);

  Not.fromJson(Map<String, dynamic> json)
      : filter =
            tryParser((value) => LegoFilter.fromJson(value))(json['filter']) ??
                Never();

  @override
  bool display() => !filter.display();
}
