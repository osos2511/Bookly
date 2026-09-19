import 'package:dio/dio.dart';

abstract class Failure {
  final String errorMessage;
  Failure(this.errorMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errorMessage);

  factory ServerFailure.fromDioError(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection Timeout with ApiServer');

      case DioExceptionType.sendTimeout:
        return ServerFailure('Send Timeout with ApiServer');

      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive Timeout with ApiServer');

      case DioExceptionType.badCertificate:
        return ServerFailure('Bad Certificate');

      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioException.response?.statusCode,
          dioException.response?.data,
        );

      case DioExceptionType.cancel:
        return ServerFailure('Request to ApiServer was Canceled');

      case DioExceptionType.connectionError:
        return ServerFailure('No Internet Connection, please check your network');

      case DioExceptionType.unknown:
        if (dioException.message != null &&
            dioException.message!.contains('SocketException')) {
          return ServerFailure('No Internet Connection');
        }
        return ServerFailure('Unexpected error, Please try again!');

      default:
        return ServerFailure('Opps There was an Error, Please try again');
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    print('================ API ERROR LOG ================');
    print('Status Code: $statusCode');
    print('Response Data: $response');
    print('===============================================');

    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      try {
        return ServerFailure(response['error']['message']);
      } catch (_) {
        return ServerFailure('Authentication or bad request error');
      }
    } else if (statusCode == 404) {
      return ServerFailure('Your request was not found, please try later!');
    } else if (statusCode == 500) {
      return ServerFailure('Internal server error, please try later!');
    } else {
      return ServerFailure('Opps There was an Error, Please try again');
    }
  }}