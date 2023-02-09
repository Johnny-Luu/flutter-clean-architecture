import 'package:flutter_clean_architecture/application/repositories/account_repository.dart';
import 'package:flutter_clean_architecture/data/datasources/account/account_local_data_source.dart';
import 'package:flutter_clean_architecture/data/datasources/account/account_remote_data_source.dart';
import 'package:flutter_clean_architecture/data/repository/base_repository.dart';
import 'package:flutter_clean_architecture/domain/core/network_info.dart';
import 'package:flutter_clean_architecture/domain/core/result.dart';
import 'package:flutter_clean_architecture/domain/exceptions/error_type.dart';

class AccountRepositoryImpl extends BaseRepository
    implements AccountRepository {
  final AccountRemoteDataSource remoteDataSource;
  final AccountLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AccountRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Result<bool>>? loginAccount(
    String userName,
    String password,
  ) async {
    final doLoginResult = await remoteDataSource.loginAccount(userName,password)
    final result = handleResponse<Response<Token>>(doLoginResult)
    switch result {
      case .success:
      
      case .failure:
    }

    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.loginAccount(userName, password);
        final response = handleResponse<Token,Error>(result)
      final new  = token
        if (result != null) {
          await localDataSource.saveToken(result);
          // return const Right(true);
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