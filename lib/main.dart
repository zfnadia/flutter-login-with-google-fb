import 'package:flutter/material.dart';
import 'package:sign_in_flutter/loginPage.dart';
import 'package:sign_in_flutter/src/bloc/blocProvider.dart';
import 'package:sign_in_flutter/src/bloc/mainBloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: MainBloc(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginPage(),
      ),
    );
  }
}
