import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class Failure {
  final String errorMessage;
  Failure(this.errorMessage);
}

class AuthFailure extends Failure {
  AuthFailure(super.errorMessage);

  /// Newer Firebase projects have email-enumeration protection on, which
  /// collapses `user-not-found` and `wrong-password` into `invalid-credential`.
  /// Both spellings are handled so the message stays correct either way.
  factory AuthFailure.fromFirebaseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return AuthFailure('That email address is not valid.');

      case 'user-disabled':
        return AuthFailure('This account has been disabled.');

      case 'user-not-found':
        return AuthFailure('No account found for that email.');

      case 'wrong-password':
        return AuthFailure('Incorrect password, please try again.');

      case 'invalid-credential':
      case 'INVALID_LOGIN_CREDENTIALS':
        return AuthFailure('Incorrect email or password.');

      case 'email-already-in-use':
        return AuthFailure('An account already exists for that email.');

      case 'weak-password':
        return AuthFailure('That password is too weak.');

      case 'operation-not-allowed':
        return AuthFailure(
          'Email/password sign-in is not enabled for this project.',
        );

      case 'too-many-requests':
        return AuthFailure('Too many attempts. Please try again later.');

      case 'network-request-failed':
        return AuthFailure(
          'No internet connection, please check your network.',
        );

      default:
        return AuthFailure(
          e.message ?? 'Something went wrong, please try again.',
        );
    }
  }
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