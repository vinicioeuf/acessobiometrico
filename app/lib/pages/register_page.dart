import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

  bool _obscurePassword = true; 
  
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
              obscureText: _obscurePassword,
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
              onPressed: (){

              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 0, 127, 54),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                minimumSize: Size(double.infinity, 60),
              ),
              child: Text(
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
  
  }
