import 'package:dio/dio.dart';
import 'http_client.dart';

class DioClient implements IHttpClient {
  final Dio _dio;

  DioClient({String? baseUrl}) : _dio = Dio() {
    _dio.options.baseUrl = baseUrl ?? 'https://api.example.com';
    _dio.options.connectTimeout = const Duration(seconds: 5);
    _dio.options.receiveTimeout = const Duration(seconds: 3);
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  @override
  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.get(path, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<Response> post(String path,
      {dynamic data, Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.post(path,
          data: data, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<Response> put(String path,
      {dynamic data, Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.put(path, data: data, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<Response> delete(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.delete(path, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutException('Tempo de conexão excedido');
      case DioExceptionType.badResponse:
        return HttpException(
          error.response?.statusCode ?? 500,
          error.response?.data['message'] ?? 'Erro na requisição',
        );
      case DioExceptionType.cancel:
        return RequestCancelledException('Requisição cancelada');
      default:
        return HttpException(500, 'Erro interno do servidor');
    }
  }
}

class TimeoutException implements Exception {
  final String message;
  TimeoutException(this.message);
}

class HttpException implements Exception {
  final int statusCode;
  final String message;
  HttpException(this.statusCode, this.message);
}

class RequestCancelledException implements Exception {
  final String message;
  RequestCancelledException(this.message);
}
