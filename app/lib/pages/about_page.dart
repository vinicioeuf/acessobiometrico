
import 'package:app/pages/team_dev.dart';
import 'package:app/pages/team_maker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



// ignore: must_be_immutable
class AboutPage extends StatelessWidget {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/imagens/labmaker-navbar2.jpg'), // Passo 1
            Container(
              height: 1,
              color: Colors.grey, // Passo 2
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Sobre o Lab Maker', // Passo 3
                style: GoogleFonts.oswald(
                        textStyle: TextStyle(
                          color: Color.fromARGB(255, 61, 96, 47),
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  
              ),
            ),
            Image.asset('assets/imagens/labMaker.jpg'), // Passo 4
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Descrição sobre o Lab Maker', // Passo 5
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 20),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 400,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TeamMakerPage()),
                    );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green[800],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Text(
                        'Equipe Maker',
                        style: GoogleFonts.oswald(
                          textStyle: TextStyle(
                            fontSize: 20.0, // Tamanho de fonte aumentado
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0), // Espaçamento entre os botões
                  Container(
                    width: 400, // Largura desejada
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TeamDevPage()),
                    );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green[800],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Text(
                        'Equipe de Desenvolvimento',
                        style: GoogleFonts.oswald(
                          textStyle: TextStyle(
                            fontSize: 20.0, // Tamanho de fonte aumentado
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0), // Espaçamento entre os botões
                ],
              ),
          ],
        ),
      ),
    );
  }
}