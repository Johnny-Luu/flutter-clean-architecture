import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/config/api_config.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: '')
abstract class ApiClient {
  factory ApiClient() {
    return _ApiClient(restClient, baseUrl: ApiConfig.baseURL);
  }

  static Dio restClient = Dio()
    ..options = BaseOptions(
      receiveTimeout: ApiConfig.timeOut,
      connectTimeout: ApiConfig.timeOut,
    );
}
