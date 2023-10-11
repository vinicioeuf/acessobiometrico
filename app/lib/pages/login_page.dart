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
              padding: EdgeInsets.symmetric(vertical: 15), // Aumentando o espaçamento vertical
              child: Image.asset("assets/imagens/labmaker-navbar2.jpg"),
            ),

            Column(
              children: [
                Center(
                  child: RichText(
                    text: TextSpan(
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
                    filled: true, // Habilitando o preenchimento do campo
                    fillColor: Color.fromARGB(255,238,244,236),
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 61, 96, 47),
                      fontWeight: FontWeight.bold,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none // Definindo a borda arredondada com raio de 10
                    ),
                  ),
                  
                ),
                SizedBox(height: 30), 

                TextField(
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    filled: true, // Habilitando o preenchimento do campo
                    fillColor: Color.fromARGB(255,238,244,236),
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 61, 96, 47),
                      fontWeight: FontWeight.bold,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none // Definindo a borda arredondada com raio de 10
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
                    ),
                  ),
                ),
                SizedBox(height: 100), 
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
          ],
        ),
      ),
    );
  }
}
