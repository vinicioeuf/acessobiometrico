// ignore_for_file: unused_import

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/pages/home_page.dart';
import 'package:app/pages/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
            Column(
              children: [
                Center(
                  child: RichText(
                    text: TextSpan(
                      // ignore: prefer_const_constructors
                      text: 'Login',
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
                SizedBox(height: 50),
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
                  ),
                ),
                SizedBox(height: 75),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 0, 127, 54),
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
                    Icon(Icons.facebook, color: const Color.fromARGB(255, 0, 63, 114), size: 40,),
                    SizedBox(width: 20),
                    Icon(Icons.email, color: Colors.red, size: 40,),
                    SizedBox(width: 20),
                    Icon(Icons.apple, color: Colors.blueGrey, size: 40),
                  ],
                ),
                SizedBox(height: 40),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        text: 'Ainda não possui uma conta? Cadastre-se!',
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
          ],
        ),
      ),
    );
  }
}

