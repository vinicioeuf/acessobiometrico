import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app/services/prefs_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

  Future<void> registrar(String nome, String email, String senha, String foto) async {
  // Validar o formato do e-mail usando expressão regular
    final emailRegex = RegExp(
        r"^[a-zA-Z0-9_.+-]+@(gmail\.com|hotmail\.com|aluno\.ifsertao-pe\.edu\.br|ifsertao-pe\.edu\.br)$");

    if (!emailRegex.hasMatch(email)) {
      throw AuthException('E-mail inválido. Utilize um e-mail permitido.');
    }

    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: senha);
      User? user = _auth.currentUser;
      if (user != null) {
        await user.updateDisplayName(nome); // Define o nome do usuário
        String? foto = await pickAndUploadImage();
        if (foto != null) {
          await user.updatePhotoURL(foto);
        }
        // ignore: unnecessary_null_comparison
        if (user != null) {
          String uid = user.uid; // Obter o UID do usuário
          DatabaseReference newUserRef = ref.child(uid); // Usar o UID como nome da referência
          await newUserRef.set({
            "nome": nome,
            "email": email,
            "foto": foto,
            "biometria": null,
            "credencial": 0,
            "solicitou": false,
            "aprovado": false,
            "negado": false,
            "matricula": null,
            "vinculo": null,
            "curso": null,
            "tempo": null,
            "tipoCurso": null,
            "idBiometria": null,

          });
          Map<String, dynamic> userData = {
            "nome": nome,
            "email": email,
            "idMatricula": 0, // Você pode ajustar isso conforme necessário
          };
          await _enviarDadosParaAPI(userData);
        }
      }

      _getUser();
    } catch (e) {
      throw AuthException('Erro no registro. Tente novamente.');
    }
  }
  Future<void> _enviarDadosParaAPI(Map<String, dynamic> userData) async {
    try {
      final response = await http.post(
        Uri.parse('http://api-labmaker-db7c20aa74d8.herokuapp.com/addusuario'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(userData),
      );

      if (response.statusCode == 200) {
        print('Dados enviados para a API com sucesso');
      } else {
        print('Falha ao enviar dados para a API. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao enviar dados para a API: $e');
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
      PrefsService.save(email);
      _getUser();
    } catch (e) {
      throw AuthException('Erro no login. Verifique suas credenciais.');
    }
  }
  Future<void> logout() async {
    try {
      await _auth.signOut();
      // PrefsService.logout();
      // Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => true);
      _getUser();
    } catch (e) {
      throw AuthException('Erro no logout. Tente novamente.');
    }
  }
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref('users');
  final FirebaseStorage storage = FirebaseStorage.instance;
  Future<XFile?> getImage() async{
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  }
  Future<void> upload(String path) async{
    File file = File(path);
    try{
      String ref = 'image/img-${DateTime.now().toString()}.jpg';
      await storage.ref(ref).putFile(file);
    } on FirebaseException catch(e){
      throw Exception("Erro no upload: ${e.code}");
    }
  }
  Future<String?> pickAndUploadImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      Reference storageReference = FirebaseStorage.instance.ref().child('images/${DateTime.now().millisecondsSinceEpoch}');
      UploadTask uploadTask = storageReference.putFile(File(image.path));
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      String imageUrl = await taskSnapshot.ref.getDownloadURL();
      return imageUrl;
    }
    return null;
  }
}