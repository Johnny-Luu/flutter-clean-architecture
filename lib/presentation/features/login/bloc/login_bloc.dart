import 'package:fimber/fimber.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/application/repositories/account_repository.dart';
import 'package:flutter_clean_architecture/domain/bloc/base_bloc.dart';
import 'package:flutter_clean_architecture/domain/bloc/event.dart';
import 'package:flutter_clean_architecture/domain/bloc/state.dart';

import 'login_event.dart';

class LoginBloc extends BaseBloc {
  final AccountRepository _accountRepository;
  String userName = "";
  String password = "";

  LoginBloc(this._accountRepository) : super(const InitialState());

  @override
  Future<void> handleEvent(BaseEvent event, Emitter<BaseState> emit) async {
    if (event is LoginUsernameChanged) {
      userName = event.username;
    } else if (event is LoginPasswordChanged) {
      password = event.password;
    } else if (event is LoginSubmitted) {
      await safeDataCall(
        emit,
        callToHost: _accountRepository.loginAccount("0987654321", "123456"),
        success: (Emitter<BaseState> emit, bool? data) {
          Fimber.e("login success data - $data");
          hideDialogState();
          if (data == true) {
            // navigationService.pushAndRemoveUntil(
            //   const HomeScreenRoute(),
            //   predicate: (route) => false,
            // );
            emit(const SuccessState(true));
          }
        },
      );
    }
  }
}
