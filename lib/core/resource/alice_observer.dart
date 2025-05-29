import 'package:alice/alice.dart';
import 'package:dio/dio.dart';

class AliceObserver {
  final Alice alice;

  AliceObserver({required navigatorKey})
      : alice = Alice(
          showNotification: true,
          showInspectorOnShake: true,
          navigatorKey: navigatorKey,
          showShareButton: true,
        ) {
    _setupInterceptor();
  }

  void _setupInterceptor() {
    final dio = Dio();
    dio.interceptors.add(alice.getDioInterceptor());
  }

  Alice get instance => alice;
}
