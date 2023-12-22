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
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: senha);
      _getUser();
    } catch (e) {
      print('Erro no registro: $e');
      throw AuthException('Erro no registro. Tente novamente.');
    }
  }

  Future<void> login(String email, String senha) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
      _getUser();
    } catch (e) {
      print('Erro no login: $e');
      throw AuthException('Erro no login. Verifique suas credenciais.');
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      _getUser();
    } catch (e) {
      print('Erro no logout: $e');
      throw AuthException('Erro no logout. Tente novamente.');
    }
  }
}