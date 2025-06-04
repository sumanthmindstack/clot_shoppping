import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:maxwealth_distributor_app/core/utils/token_service.dart';

import '../entities/custom_exception.dart';
import '../utils/logger.dart';

const String _h = 'api_client';

@lazySingleton
class ApiClient {
  final Dio _dio;
  final TokenService _tokenService;

  ApiClient(this._dio, this._tokenService);

  dynamic get(
    String path, {
    Map<String, dynamic>? queryParameters,
    bool requiresToken = true,
  }) async {
    logInfo(_h, 'GET : PATH:$path  QUERY PARAMS:$queryParameters');

    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            'Authorization':
                requiresToken ? 'Bearer ${await _tokenService.getToken()}' : '',
            "tenant_id": "torusmfa"
          },
        ),
      );
      logInfo(_h, 'Status Code : ${response.statusCode}');
      debugPrint("\n\n\nClientResponse :${response.data}", wrapWidth: 2000);
      return response.data;
    } on DioException catch (e) {
      _handleDioException(e);
    }
  }

  dynamic post(
    String path, {
    dynamic params,
    Map<String, dynamic>? queryParams,
    bool requiresToken = false,
    bool isFormData = false,
    FormData? formData,
  }) async {
    logInfo(_h, 'POST : PATH:$path  PARAMS:$params queryParams:$queryParams');
    try {
      if (formData != null) {
        logInfo(_h, 'PATH:$path  FORMDATA:${formData.fields.toString()}');
      }

      final response = await _dio.post(
        path,
        data: isFormData ? formData! : params,
        queryParameters: queryParams,
        options: Options(
          contentType: isFormData ? Headers.formUrlEncodedContentType : null,
          headers: {
            'Authorization':
                requiresToken ? 'Bearer ${await _tokenService.getToken()}' : '',
            "tenant_id": "torusmfa"
          },
        ),
      );
      logInfo(_h, 'Status Code : ${response.statusCode}');
      logInfo(_h, 'Response: ${response.data}');
      return response.data;
    } on DioException catch (e) {
      _handleDioException(e);
    }
  }

  dynamic patch(
    String path, {
    dynamic params,
    Map<String, dynamic>? queryParams,
    bool requiresToken = true,
    bool isFormData = false,
    FormData? formData,
  }) async {
    logInfo(_h, 'PATCH : PATH:$path  PARAMS:$params queryParams:$queryParams');
    try {
      if (formData != null) {
        logInfo(_h, 'PATH:$path  FORMDATA:${formData.fields.toString()}');
      }

      final response = await _dio.patch(
        path,
        data: isFormData ? formData! : params,
        queryParameters: queryParams,
        options: Options(
          contentType: isFormData ? Headers.formUrlEncodedContentType : null,
          headers: {
            'Authorization':
                requiresToken ? 'Bearer ${await _tokenService.getToken()}' : '',
            "tenant_id": "torusmfa"
          },
        ),
      );
      logInfo(_h, 'Status Code : ${response.statusCode}');
      logInfo(_h, 'Response: ${response.data}');
      return response.data;
    } on DioException catch (e) {
      _handleDioException(e);
    }
  }

  dynamic delete(
    String path, {
    dynamic params,
    Map<String, dynamic>? queryParams,
    bool requiresToken = true,
    bool isFormData = false,
    FormData? formData,
  }) async {
    logInfo(_h, 'DELETE : PATH:$path  PARAMS:$params queryParams:$queryParams');
    try {
      if (formData != null) {
        logInfo(_h, 'PATH:$path  FORMDATA:${formData.fields.toString()}');
      }

      final response = await _dio.delete(
        path,
        data: isFormData ? formData! : params,
        queryParameters: queryParams,
        options: Options(
          contentType: isFormData ? Headers.formUrlEncodedContentType : null,
          headers: {
            'Authorization':
                requiresToken ? 'Bearer ${await _tokenService.getToken()}' : '',
            "tenant_id": "torusmfa"
          },
        ),
      );
      logInfo(_h, 'Status Code : ${response.statusCode}');
      logInfo(_h, 'Response: ${response.data}');
      return response.data;
    } on DioException catch (e) {
      _handleDioException(e);
    }
  }

  dynamic options(
    String path, {
    Map<String, dynamic>? params,
    Map<String, dynamic>? queryParams,
    bool requiresToken = true,
  }) async {
    logInfo(_h, 'OPTIONS : PATH:$path  queryParams:$queryParams');
    try {
      final response = await _dio.request(
        path,
        options: Options(
          method: 'OPTIONS',
          headers: {
            'Authorization':
                requiresToken ? 'Bearer ${await _tokenService.getToken()}' : '',
            "tenant_id": "torusmfa",
            if (params != null) ...params,
          },
        ),
        queryParameters: queryParams,
      );
      logInfo(_h, 'Status Code : ${response.statusCode}');
      logInfo(_h, 'Response Headers: ${response.headers}');
      return response.headers;
    } on DioException catch (e) {
      _handleDioException(e);
    }
  }

  Never _handleDioException(DioException e) {
    logError(_h, 'Dio Error: ${e.response?.data}');
    logErrorObject(_h, e, e.message ?? "");

    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      throw TimeoutException(e.message);
    }

    if (e.type == DioExceptionType.unknown &&
        e.error.toString().contains('SocketException')) {
      throw const SocketException('');
    }

    if (e.response != null) {
      final statusCode = e.response?.statusCode;
      final data = e.response?.data;

      if ([102, 400, 401, 406, 422, 502].contains(statusCode)) {
        throw CustomException(
          errorCode: statusCode,
          errorMessage:
              data['message'] ?? data['error'] ?? e.response?.statusMessage,
        );
      }

      if (data is Map<String, dynamic>) {
        throw CustomException(
          errorCode: statusCode,
          errorMessage:
              data['message'] ?? data['error'] ?? e.response?.statusMessage,
        );
      }
    }

    throw CustomException(
      errorCode: e.response?.statusCode,
      errorMessage: e.response?.data['message'] ??
          e.response?.data['error'] ??
          e.response?.statusMessage,
    );
  }
}
