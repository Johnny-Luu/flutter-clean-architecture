import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/domain/bloc/state.dart';
import 'package:flutter_clean_architecture/domain/widget/base_widget.dart';
import 'package:flutter_clean_architecture/injection_container.dart';
import 'package:flutter_clean_architecture/presentation/features/home/home_screen.dart';
import 'package:flutter_clean_architecture/presentation/features/login/bloc/login_bloc.dart';
import 'package:flutter_clean_architecture/presentation/features/login/bloc/login_event.dart';

class LoginScreen extends BaseView<LoginBloc> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget buildView(BuildContext context, BaseState state) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login screen"),
      ),
      body: _buildBody(context, state),
    );
  }

  Widget _buildBody(BuildContext context, BaseState state) {
    if (state is SuccessState) {
      Future.delayed(Duration.zero, () async {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const HomeScreen(),
          ),
        );
      });

      return const SizedBox();
    } else {
      final bloc = BlocProvider.of<LoginBloc>(context);

      return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextField(
                onChanged: (text) {
                  bloc.add(LoginUsernameChanged(text));
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Username",
                )),
            const SizedBox(height: 20),
            TextField(
                onChanged: (text) {
                  bloc.add(LoginPasswordChanged(text));
                },
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Password",
                )),
            const SizedBox(height: 20),
            ElevatedButton(
                child: const Text("Login"),
                onPressed: () {
                  final bloc = BlocProvider.of<LoginBloc>(context);
                  bloc.add(LoginSubmitted());
                })
          ]));
    }
  }

  @override
  LoginBloc createBloc() {
    return sl<LoginBloc>();
  }
}
