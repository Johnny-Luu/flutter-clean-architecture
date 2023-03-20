import 'package:flutter_clean_architecture/application/repositories/account_repository.dart';
import 'package:flutter_clean_architecture/data/datasources/account/account_local_data_source.dart';
import 'package:flutter_clean_architecture/data/datasources/account/account_remote_data_source.dart';
import 'package:flutter_clean_architecture/domain/core/network_info.dart';
import 'package:flutter_clean_architecture/domain/core/result.dart';
import 'package:flutter_clean_architecture/domain/exceptions/error_type.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountRemoteDataSource remoteDataSource;
  final AccountLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AccountRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Result<bool>> loginAccount(
    String userName,
    String password,
  ) async {
    // simulate delayed time when call api
    await Future.delayed(const Duration(seconds: 3));

    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.loginAccount(userName, password);

        if (result != null) {
          await localDataSource.saveToken(result);
          return Success(true);
        }

        return Error(ErrorType.GENERIC, '');
      } on Exception {
        return Error(ErrorType.GENERIC, '');
      }
    } else {
      return Error(ErrorType.GENERIC, '');
    }
  }
}
