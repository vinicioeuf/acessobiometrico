import 'package:app/pages/home_page.dart';
import 'package:app/pages/login_page.dart';
import 'package:app/services/auth_service.dart';
import 'package:flutter/material.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {

  final AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    if (auth.isLoading)
      return loading();
    else if (auth.usuario == null)
      return LoginPage();
    else
      return HomePage();
  }

  loading() {
    return Scaffold(
        body: Center(
      child: CircularProgressIndicator(),
    ));
  }
}
