import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture/application/repositories/account_repository.dart';
import 'package:flutter_clean_architecture/domain/core/result.dart';
import 'package:flutter_clean_architecture/domain/core/usecase.dart';

class LoginAccountUseCase implements UseCase<bool, ParamLogin> {
  final AccountRepository repository;

  LoginAccountUseCase(this.repository);

  @override
  Future<Result<bool>> call(ParamLogin params) async {
    return await repository.loginAccount(params.userName, params.password);
  }
}

class ParamLogin extends Equatable {
  final String userName;
  final String password;

  const ParamLogin({required this.userName, required this.password});

  @override
  List<Object> get props => [userName, password];
}
