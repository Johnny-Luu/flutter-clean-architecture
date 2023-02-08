import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home screen'),
          leading: const SizedBox(),
        ),
        body: const Center(
          child: Text('My home screen'),
        ),
      ),
    );
  }
}
