import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_management/app/di/injection.dart';
import 'package:logger/logger.dart';
part 'api_exception.freezed.dart';
part 'api_exception.g.dart';

@freezed
abstract class ApiException with _$ApiException {
  factory ApiException._(String reason) => ApiException._(reason);
  const factory ApiException.requestCancelled(String reason) = RequestCancelled;
  const factory ApiException.unauthorisedRequest(String reason) =
      UnauthorisedRequest;

  const factory ApiException.badRequest(String reason) = BadRequest;

  const factory ApiException.notFound(String reason) = NotFound;

  const factory ApiException.methodNotAllowed(String reason) = MethodNotAllowed;

  const factory ApiException.notAcceptable(String reason) = NotAcceptable;

  const factory ApiException.requestTimeout(String reason) = RequestTimeout;

  const factory ApiException.sendTimeout(String reason) = SendTimeout;

  const factory ApiException.conflict(String reason) = Conflict;

  const factory ApiException.internalServerError(String reason) =
      InternalServerError;

  const factory ApiException.notImplemented(String reason) = NotImplemented;

  const factory ApiException.serviceUnavailable(String reason) =
      ServiceUnavailable;

  const factory ApiException.noInternetConnection(String reason) =
      NoInternetConnection;

  const factory ApiException.formatException(String reason) = FormatException;

  const factory ApiException.unableToProcess(String reason) = UnableToProcess;

  const factory ApiException.defaultError(String error) = DefaultError;

  const factory ApiException.unexpectedError(String reason) = UnexpectedError;
  const factory ApiException.badCertificate(String reason) = BadCertificate;

  static ApiException getDioException(error) {
    if (error is Exception) {
      try {
        ApiException apiException;
        if (error is DioException) {
          String? message;
          try {
            if (error.response?.data != null && (error.response?.data is Map)) {
              message = error.response?.data['message'];
            } else if (error.response?.data != null &&
                (error.response?.data is String)) {
              message = error.response?.data;
            }
          }catch (e) {
            message = null;
          }
          switch (error.type) {
            case DioExceptionType.cancel:
              apiException =
                  ApiException.requestCancelled(message ?? "Not Implemented");
              break;
            case DioExceptionType.connectionTimeout:
              apiException =
                  ApiException.requestTimeout(message ?? "Request Timeout");
              break;
            case DioExceptionType.unknown:
              apiException =
                  ApiException.unexpectedError(message ?? "Unexpected Error");
              break;
            case DioExceptionType.connectionError:
              apiException = ApiException.noInternetConnection(
                  message ?? "No Internet Connection");
              break;
            case DioExceptionType.receiveTimeout:
              apiException =
                  ApiException.sendTimeout(message ?? "Send Timeout");
              break;
            case DioExceptionType.badCertificate:
              apiException =
                  ApiException.badCertificate(message ?? "Bad Certificate");
              break;
            case DioExceptionType.badResponse:
              switch (error.response?.statusCode) {
                case 400:
                  apiException = ApiException.unauthorisedRequest(
                      message ?? "Unauthorised Request");
                  break;
                case 401:
                  apiException = ApiException.unauthorisedRequest(
                      message ?? "Unauthorised Request");
                  break;
                case 403:
                  apiException = ApiException.unauthorisedRequest(
                      message ?? "Unauthorised Request");
                  break;
                case 404:
                  apiException = const ApiException.notFound("Not found");
                  break;
                case 409:
                  apiException = ApiException.conflict(
                      message ?? "Error due to a conflict");
                  break;
                case 408:
                  apiException =
                      ApiException.requestTimeout(message ?? "Request Timeout");
                  break;
                case 500:
                  apiException = ApiException.internalServerError(
                      message ?? "Internal Server Error");
                  break;
                case 503:
                  apiException = ApiException.serviceUnavailable(
                      message ?? "Service Unavailable");
                  break;
                default:
                  var responseCode = error.response?.statusCode;
                  apiException = ApiException.defaultError(
                    "Received invalid status code: $responseCode",
                  );
              }
              break;
            case DioExceptionType.sendTimeout:
              apiException =
                  ApiException.sendTimeout(message ?? "Send Timeout");
              break;
          }
        } else if (error is SocketException) {
          apiException =
              const ApiException.noInternetConnection("No Internet Connection");
        } else {
          apiException = const ApiException.unexpectedError("Unexpected Error");
        }
        return apiException;
      } on FormatException catch (e) {
        getIt<Logger>().e(e);
        return const ApiException.formatException("Format Exception");
      } catch (_) {
        return const ApiException.unexpectedError("Unexpected Error");
      }
    } else {
      if (error.toString().contains("is not a subtype of")) {
        return const ApiException.unableToProcess("Unable to Process");
      } else {
        return const ApiException.unexpectedError("Unexpected Error");
      }
    }
  }

  static String getErrorMessage(ApiException apiException) {
    String errorMessage = "";
    apiException.when(notImplemented: (String reason) {
      errorMessage = reason;
    }, requestCancelled: (String reason) {
      errorMessage = reason;
    }, internalServerError: (String reason) {
      errorMessage = reason;
    }, notFound: (String reason) {
      errorMessage = reason;
    }, serviceUnavailable: (String reason) {
      errorMessage = reason;
    }, methodNotAllowed: (String reason) {
      errorMessage = reason;
    }, badRequest: (String reason) {
      errorMessage = reason;
    }, unauthorisedRequest: (String reason) {
      errorMessage = reason;
    }, unexpectedError: (String reason) {
      errorMessage = reason;
    }, requestTimeout: (String reason) {
      errorMessage = reason;
    }, noInternetConnection: (String reason) {
      errorMessage = reason;
    }, conflict: (String reason) {
      errorMessage = reason;
    }, sendTimeout: (String reason) {
      errorMessage = reason;
    }, unableToProcess: (String reason) {
      errorMessage = reason;
    }, defaultError: (String error) {
      errorMessage = error;
    }, formatException: (String reason) {
      errorMessage = reason;
    }, notAcceptable: (String reason) {
      errorMessage = reason;
    }, badCertificate: (String reason) {
      errorMessage = reason;
    });
    return errorMessage;
  }

  factory ApiException.fromJson(Map<String, dynamic> json) =>
      _$ApiExceptionFromJson(json);
}
