import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'api_constants.dart';

@module
abstract class InjectionModule {
  @Named('baseUrl')
  String get baseUrl => ApiConstants.baseUrl;

  @lazySingleton
  Dio dio(@Named('baseUrl') String baseUrl) => Dio(
        BaseOptions(
          baseUrl: baseUrl,
          contentType: Headers.jsonContentType,
          connectTimeout: const Duration(milliseconds: 60 * 1000),
          receiveTimeout: const Duration(milliseconds: 60 * 1000),
          sendTimeout: const Duration(milliseconds: 30 * 1000),
        ),
      );

  @lazySingleton
  Connectivity connectivity() => Connectivity();
}
