import 'package:dio/dio.dart';

class DioErrorHandler {
  static String handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.cancel:
        return 'Запрос к API-серверу был отменен';
      case DioExceptionType.connectionTimeout:
        return 'Сервер не отвечает';
      case DioExceptionType.unknown:
        return 'Не удалось подключиться к API-серверу из-за подключения к Интернету';
      case DioExceptionType.badResponse:
        if (error.response?.statusCode == 400) {
          return 'Город не найден';
        }
        break;
      default:
        return 'Что-то пошло не так';
    }
    return 'Неизвестная ошибка';
  }
}
