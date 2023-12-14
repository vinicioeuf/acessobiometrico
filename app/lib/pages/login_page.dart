

import 'package:app/pages/home_page.dart';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:app/pages/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true; // Adicionado para controlar a visibilidade da senha

  

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
                      text: 'Login',
                      style: GoogleFonts.oswald(
                        textStyle: TextStyle(
                          color: Colors.green[800],
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
                      color: Colors.green[800],
                      fontWeight: FontWeight.bold,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                TextField(
                  obscureText: _obscurePassword, // Define a visibilidade da senha
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    filled: true,
                    fillColor: Color.fromARGB(255, 238, 244, 236),
                    labelStyle: TextStyle(
                      color: Colors.green[800],
                      fontWeight: FontWeight.bold,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility : Icons.visibility_off,
                      color: Colors.green[800],),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                        Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                      },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[800],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: Size(double.infinity, 60),
                  ),
                  child: Text(
                          "Entrar",
                          style: GoogleFonts.oswald(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
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
        children: [
          TextSpan(
            text: 'Ainda não possui cadastro? ',
            style: GoogleFonts.oswald(
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          TextSpan(
            text: 'Cadastre-se!',
            style: GoogleFonts.oswald(
              textStyle: TextStyle(
                color: Colors.green[800],
                fontSize: 17,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline
              ),
            ),
          ),
        ],
      ),
    ),
  ),
),

                SizedBox(height: 40),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
