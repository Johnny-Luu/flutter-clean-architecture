import 'package:fimber/fimber.dart';
import 'package:flutter_clean_architecture/data/models/model_base_response.dart';
import 'package:flutter_clean_architecture/domain/core/result.dart';
import 'package:flutter_clean_architecture/domain/exceptions/error_type.dart';

typedef EntityToModelMapper<Entity, Data> = Data? Function(Entity? entity);
typedef SaveResult<Data> = Future Function(Data? data);

Future<Result<T>> handleResponse<T>(http.Response response) {
  if (response.statusCode >= 200 && response.statusCode < 300) {
    try {
      final T data = json.decode(response.body);
      return Future.value(Result<T>(data: data));
    } catch (e) {
      return Future.value(Result<T>(errorCode: 0, errorMessage: 'Failed to parse response body: $e'));
    }
  } else if (response.statusCode == 401) {
    return Future.value(Result<T>(errorCode: 401, errorMessage: 'Unauthorized'));
  } else if (response.statusCode == 404) {
    return Future.value(Result<T>(errorCode: 404, errorMessage: 'Not found'));
  } else if (response.statusCode == 500) {
    return Future.value(Result<T>(errorCode: 500, errorMessage: 'Internal server error'));
  } else {
    return Future.value(Result<T>(errorCode: response.statusCode, errorMessage: 'Failed with status code: ${response.statusCode}'));
  }
}


abstract class BaseRepository {
  Future<Result<Data>> safeDbCall<Entity, Data>(Future<Entity?> callDb,
      {required EntityToModelMapper<Entity, Data> mapperDb}) async {
    try {
      final response = await callDb;
      if (response != null) {
        Fimber.d("DB success message -> $response");
        return Success(mapperDb.call(response)!);
      } else {
        Fimber.d("DB response is null");
        return Error(ErrorType.GENERIC, "DB response is null!");
      }
    } catch (exception) {
      Fimber.d("DB failure message -> $exception");
      return Error(ErrorType.GENERIC, "Unknown DB error");
    }
  }

  Future<Result<Data>> safeApiCall<Data>(
    Future<ModelBaseResponse<Data>> call, {
    SaveResult<Data>? saveResult,
  }) async {
    Fimber.d("safeApiCall");
    try {
      var response = await call;
      if (response.isSuccess()) {
        await saveResult?.call(response.data);
        return Success(response.data);
      } else if (response.isTokenExprired()) {
        return Error(
            ErrorType.TOKEN_EXPIRED, response.message ?? "Unknown Error");
      } else {
        Fimber.e("response.message -> ${response.message}");
        return Error(ErrorType.GENERIC, response.message ?? "Unknown Error");
      }
    } on Exception catch (exception) {
      Fimber.e("Api error message -> ${exception.toString()}");
      return Error(ErrorType.GENERIC, "Unknown API error");
    }
  }
}

