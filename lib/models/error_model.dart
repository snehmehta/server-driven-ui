class BaseResponseModel {
  final int code;
  final String message;

  bool get isSuccess => code >= 200 && code < 300;

  BaseResponseModel(this.code, this.message);
}
