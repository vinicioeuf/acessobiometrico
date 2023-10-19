import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/pages/login_page.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref('users');
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true; 
  final FirebaseStorage storage = FirebaseStorage.instance;
  Future<void> _registerUser(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passController.text,
      );
      User? user = userCredential.user;
      if (user != null) {
        await user.updateDisplayName(nameController.text);
        String? imagePath = await pickAndUploadImage();
        if (imagePath != null) {
          await user.updatePhotoURL(imagePath);
        }
        DatabaseReference newUserRef = ref.push(); // Cria uma nova referência com uma chave única
        await newUserRef.set({
          "nome": nameController.text,
          "email": emailController.text,
          "senha": passController.text,
          "foto": imagePath,
          "biometria": 0,
          "credencial": 0,
        });
      }
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Conta criada! Faça o login.'),
            actions: <Widget>[
              TextButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                },
              ),
            ],
          );
        },
      );
      
      // _showAlertDialog(context);
      
    } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Erro no cadastro'),
                content: Text('A senha deve ter no mínimo 6 caracteres.'),
                actions: <Widget>[
                  TextButton(
                    child: Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
          // print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Erro no cadastro'),
                content: Text('Essa conta já está vínculada a um E-mail.'),
                actions: <Widget>[
                  TextButton(
                    child: Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
    }
    catch (e) {
      print('Error: $e');
    }
    setState(() {
      _isLoading = false;
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Image.asset("assets/imagens/labmaker-navbar2.jpg"),
            ),
            Divider(
              height: 1,
              color: Colors.grey,
            ),
            Center(
              child: RichText(
                text: TextSpan(
                  text: 'Cadastre-se!',
                  style: GoogleFonts.oswald(
                    textStyle: TextStyle(
                      color: Color.fromARGB(255, 61, 96, 47),
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            // ElevatedButton.icon(onPressed: pickAndUploadImage, icon: Icon(Icons.upload), label: Text('Enviar imagem')),
            SizedBox(height: 50),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Nome',
                filled: true,
                fillColor: Color.fromARGB(255, 238, 244, 236),
                labelStyle: TextStyle(
                  color: Color.fromARGB(255, 61, 96, 47),
                  fontWeight: FontWeight.bold,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 30),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'E-mail',
                filled: true,
                fillColor: Color.fromARGB(255, 238, 244, 236),
                labelStyle: TextStyle(
                  color: Color.fromARGB(255, 61, 96, 47),
                  fontWeight: FontWeight.bold,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 30),
            TextField(
              controller: passController,
              decoration: InputDecoration(
                labelText: 'Senha',
                filled: true,
                fillColor: Color.fromARGB(255, 238, 244, 236),
                labelStyle: TextStyle(
                  color: Color.fromARGB(255, 61, 96, 47),
                  fontWeight: FontWeight.bold,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility : Icons.visibility_off,
                      color: Colors.green[700],),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
              ),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: _isLoading ? null : () => _registerUser(context),
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 0, 127, 54),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                minimumSize: Size(double.infinity, 60),
              ),
              child: _isLoading ? SpinKitCircle(
                    color: Colors.white,
                    size: 26,
                  )
                : Text(
                    "Enviar",
                    style: GoogleFonts.oswald(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                      color: Colors.white,
                    ),
                  ),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.facebook,
                    color: const Color.fromARGB(255, 0, 63, 114), size: 40),
                SizedBox(width: 20),
                Icon(Icons.email, color: Colors.red, size: 40),
                SizedBox(width: 20),
                Icon(Icons.apple, color: Colors.blueGrey, size: 40),
              ],
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Já possui uma conta? Entrar',
                    style: GoogleFonts.oswald(
                      textStyle: TextStyle(
                        color: Color.fromARGB(255, 61, 96, 47),
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    
  }
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