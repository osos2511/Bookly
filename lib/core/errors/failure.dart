import 'package:dio/dio.dart';

abstract class Failure{
  final String errorMessage;
  Failure(this.errorMessage);

}

class ServerFailure extends Failure{
  ServerFailure(super.errorMessage);
  factory ServerFailure.fromDioError(DioException dioException){
    switch(dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection Timeout with ApiServer');

      case DioExceptionType.sendTimeout:
        return ServerFailure('Send Timeout with ApiServer');

      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive Timeout with ApiServer');

      case DioExceptionType.badCertificate:
        return ServerFailure('bad Certificate');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(dioException.response!.statusCode, dioException.response!.data);
      case DioExceptionType.cancel:
      return ServerFailure('Request to ApiServer was Canceled');
      case DioExceptionType.connectionError:
        return ServerFailure('check internet connection');
      case DioExceptionType.unknown:
        if(dioException.message!.contains('SocketException')){
          return ServerFailure('unknown error');
        }
        return ServerFailure('error');
      default:
        return ServerFailure('There was an error');
    }
  }
factory ServerFailure.fromResponse(int? statusCode,dynamic response){
    if(statusCode==400||statusCode==401||statusCode==403){
      return ServerFailure(response['error']['message']);
    }else if(statusCode==404){
      return ServerFailure('Your request Not found, please try later!');
    }else if(statusCode==500){
      return ServerFailure('Internal server error, please try later!');
    }else{
      return ServerFailure('There was an error, please try later!');
    }
}

}