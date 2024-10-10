import 'dart:io';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_management/app/di/injection.dart';
import 'package:logger/logger.dart';

part 'api_exception.freezed.dart';
part 'api_exception.g.dart';

@freezed
abstract class ApiException with _$ApiException {
  const factory ApiException.requestCancelled() = RequestCancelled;

  const factory ApiException.unauthorisedRequest() = UnauthorisedRequest;

  const factory ApiException.badRequest() = BadRequest;

  const factory ApiException.notFound(String reason) = NotFound;

  const factory ApiException.methodNotAllowed() = MethodNotAllowed;

  const factory ApiException.notAcceptable() = NotAcceptable;

  const factory ApiException.requestTimeout() = RequestTimeout;

  const factory ApiException.sendTimeout() = SendTimeout;

  const factory ApiException.conflict() = Conflict;

  const factory ApiException.internalServerError() = InternalServerError;

  const factory ApiException.notImplemented() = NotImplemented;

  const factory ApiException.serviceUnavailable() = ServiceUnavailable;

  const factory ApiException.noInternetConnection() = NoInternetConnection;

  const factory ApiException.formatException() = FormatException;

  const factory ApiException.unableToProcess() = UnableToProcess;

  const factory ApiException.defaultError(String error) = DefaultError;

  const factory ApiException.unexpectedError() = UnexpectedError;
  const factory ApiException.badCertificate() = BadCertificate;

  static ApiException getDioException(error) {
    if (error is Exception) {
      try {
        ApiException apiException;
        if (error is DioException) {
          switch (error.type) {
            case DioExceptionType.cancel:
              apiException = const ApiException.requestCancelled();
              break;
            case DioExceptionType.connectionTimeout:
              apiException = const ApiException.requestTimeout();
              break;
            case DioExceptionType.unknown:
              apiException = const ApiException.unexpectedError();
              break;
            case DioExceptionType.connectionError:
              apiException = const ApiException.noInternetConnection();
              break;
            case DioExceptionType.receiveTimeout:
              apiException = const ApiException.sendTimeout();
              break;
            case DioExceptionType.badCertificate:
              apiException = const ApiException.badCertificate();
              break;
            case DioExceptionType.badResponse:
              switch (error.response?.statusCode) {
                case 400:
                  apiException = const ApiException.unauthorisedRequest();
                  break;
                case 401:
                  apiException = const ApiException.unauthorisedRequest();
                  break;
                case 403:
                  apiException = const ApiException.unauthorisedRequest();
                  break;
                case 404:
                  apiException = const ApiException.notFound("Not found");
                  break;
                case 409:
                  apiException = const ApiException.conflict();
                  break;
                case 408:
                  apiException = const ApiException.requestTimeout();
                  break;
                case 500:
                  apiException = const ApiException.internalServerError();
                  break;
                case 503:
                  apiException = const ApiException.serviceUnavailable();
                  break;
                default:
                  var responseCode = error.response?.statusCode;
                  apiException = ApiException.defaultError(
                    "Received invalid status code: $responseCode",
                  );
              }
              break;
            case DioExceptionType.sendTimeout:
              apiException = const ApiException.sendTimeout();
              break;
          }
        } else if (error is SocketException) {
          apiException = const ApiException.noInternetConnection();
        } else {
          apiException = const ApiException.unexpectedError();
        }
        return apiException;
      } on FormatException catch (e) {
        getIt<Logger>().e(e);
        return const ApiException.formatException();
      } catch (_) {
        return const ApiException.unexpectedError();
      }
    } else {
      if (error.toString().contains("is not a subtype of")) {
        return const ApiException.unableToProcess();
      } else {
        return const ApiException.unexpectedError();
      }
    }
  }

  static String getErrorMessage(ApiException apiException) {
    var errorMessage = "";
    apiException.when(
        notImplemented: () {
          errorMessage = "Not Implemented";
        },
        requestCancelled: () {
          errorMessage = "Request Cancelled";
        },
        internalServerError: () {
          errorMessage = "Internal Server Error";
        },
        notFound: (String reason) {
          errorMessage = reason;
        },
        serviceUnavailable: () {
          errorMessage = "Service unavailable";
        },
        methodNotAllowed: () {
          errorMessage = "Method Allowed";
        },
        badRequest: () {
          errorMessage = "Bad request";
        },
        unauthorisedRequest: () {
          errorMessage = "Unauthorised request";
        },
        unexpectedError: () {
          errorMessage = "Unexpected error occurred";
        },
        requestTimeout: () {
          errorMessage = "Connection request timeout";
        },
        noInternetConnection: () {
          errorMessage = "No internet connection";
        },
        conflict: () {
          errorMessage = "Error due to a conflict";
        },
        sendTimeout: () {
          errorMessage = "Send timeout in connection with API server";
        },
        unableToProcess: () {
          errorMessage = "Unable to process the data";
        },
        defaultError: (String error) {
          errorMessage = error;
        },
        formatException: () {
          errorMessage = "Unexpected error occurred";
        },
        notAcceptable: () {
          errorMessage = "Not acceptable";
        },
        badCertificate: () => errorMessage = "Bad Certificate");
    return errorMessage;
  }

  factory ApiException.fromJson(Map<String, dynamic> json) => _$ApiExceptionFromJson(json);

}
