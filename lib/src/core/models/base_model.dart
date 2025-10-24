class BaseModel<T> {
  final String status;
  final String? message;
  final T? data;
  final Exception? exception;

  const BaseModel({
    required this.status,
    this.message,
    this.data,
    this.exception,
  });

  factory BaseModel.defaultError() {
    return const BaseModel(
      status: 'ERROR',
      message: '알 수 없는 오류가 발생했습니다.',
    );
  }

  factory BaseModel.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    return BaseModel(
      status: json['status'] as String,
      message: json['message'] as String?,
      data: json['data'] != null ? fromJsonT(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) {
    return {
      'status': status,
      'message': message,
      'data': data != null ? toJsonT(data as T) : null,
    };
  }

  bool isSuccess() {
    return status == 'OK';
  }

  factory BaseModel.error({
    String? message,
    Exception? exception,
  }) {
    return BaseModel(
      status: 'ERROR',
      message: message ?? '오류가 발생했습니다.',
      exception: exception,
    );
  }
}
