import 'actions/actions.dart';

class LegoException implements Exception {}

class LegoCardFormatException implements LegoException {
  final String message;

  LegoCardFormatException(this.message);

  @override
  String toString() => 'LegoCardFormatException: $message';
}

class InvalidLegoCardTypeException implements LegoException {
  final String type;

  InvalidLegoCardTypeException(this.type);

  @override
  String toString() => 'InvalidLegoCardTypeException: $type';
}

class LegoActionFormatException implements LegoException {
  final String message;

  LegoActionFormatException(this.message);

  @override
  String toString() => 'LegoActionFormatException: $message';
}

class InvalidLegoActionTypeException implements LegoException {
  final String type;

  InvalidLegoActionTypeException(this.type);

  @override
  String toString() => 'InvalidLegoActionTypeException: $type';
}

class UnsupportedLegoActionException implements LegoException {
  final LegoActionType actionType;
  final String cardType;

  UnsupportedLegoActionException(this.cardType, this.actionType);

  @override
  String toString() =>
      "UnsupportedLegoActionException: `$cardType` doesn't support action `$actionType` ";
}

class InvalidLegoFilterException {
  final String type;

  InvalidLegoFilterException(this.type);

  @override
  String toString() => 'InvalidLegoFilterException: $type';
}
