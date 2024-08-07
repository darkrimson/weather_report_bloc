import 'package:dio/dio.dart';

class DioClient {
  static Dio createDio() {
    Dio dio = Dio(BaseOptions(
      baseUrl: 'http://api.weatherapi.com/v1/',
      queryParameters: {
        'key': 'a3d7069fc3c4407f912120532231012',
      },
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 5000),
    ));
    return dio;
  }
}
