import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/data/models/token_model.dart';
import 'package:flutter_clean_architecture/domain/entities/token.dart';
import 'package:flutter_clean_architecture/domain/exceptions/exception.dart';

abstract class AccountRemoteDataSource {
  Future<Token?> loginAccount(String userName, String password);
}

class AccountRemoteDataSourceImpl implements AccountRemoteDataSource {
  AccountRemoteDataSourceImpl();

  @override
  Future<Token?> loginAccount(String userName, String password) async {
    try {
      // call api here

      return TokenModel.fromJson({
        'accessToken': 'accessToken',
        'refreshToken': 'refreshToken',
      });
    } on Exception catch (e) {
      debugPrint(e.toString());
      throw UnAuthorizedException();
    }
  }
}
