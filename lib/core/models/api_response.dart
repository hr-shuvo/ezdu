import 'package:equatable/equatable.dart';

class ApiResponse<T> extends Equatable {
  final bool success;
  final T? data;
  final String? message;
  final int? statusCode;

  const ApiResponse({
    required this.success,
    this.data,
    this.message,
    this.statusCode,
  });

  factory ApiResponse.success(T data, {int? statusCode}) {
    return ApiResponse(
      success: true,
      data: data,
      statusCode: statusCode ?? 200,
    );
  }

  factory ApiResponse.error(String message, {int? statusCode}) {
    return ApiResponse(
      success: false,
      message: message,
      statusCode: statusCode ?? 500,
    );
  }

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    return ApiResponse(
      success: json['success'] ?? false,
      data: json['data'] != null ? fromJson(json['data']) : null,
      message: json['message'],
      statusCode: json['statusCode'],
    );
  }

  @override
  List<Object?> get props => [success, data, message, statusCode];
}
