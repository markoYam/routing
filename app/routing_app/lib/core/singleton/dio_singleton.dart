import 'package:dio/dio.dart';

class DioSingleton {
  factory DioSingleton() {
    _instance ??= DioSingleton._();
    return _instance!;
  }

  DioSingleton._();

  static DioSingleton? _instance;

  static late final Dio dio;

  static bool initSingletonbool = true;

  //static late final Dio dioSecure;

  static String _baseUrl = 'https://192.168.1.100/routing/api/';
  static void createDio() {
    if (initSingletonbool) {
      dio = Dio(
        BaseOptions(
          baseUrl: _baseUrl,
          receiveTimeout: Duration(seconds: 15), // 15 seconds
          connectTimeout: Duration(seconds: 15),
          sendTimeout: Duration(seconds: 15),
          contentType: 'application/json',
        ),
      );
      //dioInterceptor();

      initSingletonbool = false;
    }
  }
}
