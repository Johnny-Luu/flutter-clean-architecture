import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/application/usecases/account/login_account.dart';
import 'package:flutter_clean_architecture/domain/bloc/base_bloc.dart';
import 'package:flutter_clean_architecture/domain/bloc/event.dart';
import 'package:flutter_clean_architecture/domain/bloc/state.dart';

import 'login_event.dart';

class LoginBloc extends BaseBloc {
  final LoginAccountUseCase loginAccountUseCase;

  LoginBloc({required this.loginAccountUseCase}) : super(const InitialState());

  String userName = "";
  String password = "";

  @override
  Future<void> handleEvent(BaseEvent event, Emitter<BaseState> emit) async {
    if (event is LoginUsernameChanged) {
      userName = event.username;
    } else if (event is LoginPasswordChanged) {
      password = event.password;
    } else if (event is LoginSubmitted) {
      await safeDataCall(
        emit,
        callToHost: loginAccountUseCase.call(
          ParamLogin(
            userName: userName,
            password: password,
          ),
        ),
        success: (Emitter<BaseState> emit, bool? data) {
          Fimber.e("login success data - $data");
          hideDialogState(emit);
          if (data == true) {
            // navigationService.pushAndRemoveUntil(
            //   const HomeScreenRoute(),
            //   predicate: (route) => false,
            // );
            emit(const SuccessState(true));
          }
        },
        error: (Emitter<BaseState> emit, String message) {
          debugPrint('Login failed');
          hideDialogState(emit);
          emit(ErrorDialogState(message: 'Login failed!'));
        },
      );
    }
  }
}
