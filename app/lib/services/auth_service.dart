import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthService extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? usuario;
  bool isLoading = true;

  AuthService() {
    _authCheck();
  }

  _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      usuario = user;
      isLoading = false;
      notifyListeners();
    });
  }

  _getUser() {
    usuario = _auth.currentUser;
    notifyListeners();
  }

  Future<void> registrar(String email, String senha) async {
    // Validar o formato do e-mail usando expressão regular
    final emailRegex = RegExp(
        r"^[a-zA-Z0-9_.+-]+@(gmail\.com|hotmail\.com|aluno\.ifsertao-pe\.edu\.br|ifsertao-pe\.edu\.br)$");

    if (!emailRegex.hasMatch(email)) {
      throw AuthException('E-mail inválido. Utilize um e-mail permitido.');
    }

    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: senha);
      _getUser();
    } catch (e) {
      throw AuthException('Erro no registro. Tente novamente.');
    }
  }

  Future<void> login(String email, String senha) async {
    // Validar o formato do e-mail usando expressão regular
    final emailRegex = RegExp(
        r"^[a-zA-Z0-9_.+-]+@(gmail\.com|hotmail\.com|aluno\.ifsertao-pe\.edu\.br|ifsertao-pe\.edu\.br)$");

    if (!emailRegex.hasMatch(email)) {
      throw AuthException('E-mail inválido. Utilize um e-mail permitido.');
    }

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
      _getUser();
    } catch (e) {
      throw AuthException('Erro no login. Verifique suas credenciais.');
    }
  }
  Future<void> logout() async {
    try {
      await _auth.signOut();
      _getUser();
    } catch (e) {
      throw AuthException('Erro no logout. Tente novamente.');
    }
  }
}