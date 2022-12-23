import '../../error_tracker/error_tracker.dart';
import '../exceptions.dart';

typedef LegoParser<T> = T Function(Map<String, dynamic> json);

LegoParser<T?> tryParser<T>(LegoParser<T> parser) {
  return (Map<String, dynamic> json) {
    try {
      return parser(json);
    } catch (e, s) {
      if (e is! LegoException) {
        errorTracker.captureError(e, s);
      }
      return null;
    }
  };
}
