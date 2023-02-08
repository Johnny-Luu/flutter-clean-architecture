import 'package:flutter_clean_architecture/domain/constants/constant.dart';
import 'package:flutter_clean_architecture/domain/entities/token.dart';
import 'package:flutter_clean_architecture/domain/exceptions/exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AccountLocalDataSource {
  Future<void>? saveToken(Token token);
  Future<String>? getAcessToken();
  Future<String>? getRefreshToken();
}

class AccountLocalDataSourceImpl implements AccountLocalDataSource {
  final SharedPreferences sharedPreferences;

  AccountLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void>? saveToken(Token token) async {
    await sharedPreferences.setString(cachedAccessToken, token.accessToken);
    await sharedPreferences.setString(cachedRefreshToken, token.refreshToken);
  }

  @override
  Future<String>? getAcessToken() async {
    final accessToken = sharedPreferences.getString(cachedAccessToken);
    if (accessToken != null) {
      return accessToken;
    } else {
      throw CacheException();
    }
  }

  @override
  Future<String>? getRefreshToken() async {
    final accessToken = sharedPreferences.getString(cachedRefreshToken);
    if (accessToken != null) {
      return accessToken;
    } else {
      throw CacheException();
    }
  }
}
