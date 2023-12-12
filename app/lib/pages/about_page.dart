
import 'package:app/pages/team_dev.dart';
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TeamDevPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[700], // Passo 6
                  ),
                  child: Text(
                    'Time de Devs',
                    style: TextStyle(
                      color: Colors.white, // Altera a cor do texto para branco
                    ),
                  ),
                ),
                SizedBox(width: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TeamDevPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[700], // Passo 6
                  ),
                  child: Text(
                    'Time Lab Maker',
                    style: TextStyle(
                      color: Colors.white, // Altera a cor do texto para branco
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 120.0, // Largura desejada
                    child: ElevatedButton(
                      onPressed: () {
                        // Ação para 24h
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green[800],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Text(
                        '24h',
                        style: GoogleFonts.oswald(
                          textStyle: TextStyle(
                            fontSize: 20.0, // Tamanho de fonte aumentado
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0), // Espaçamento entre os botões
                  Container(
                    width: 120.0, // Largura desejada
                    child: ElevatedButton(
                      onPressed: () {
                        // Ação para 7 dias
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green[800],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Text(
                        '7 dias',
                        style: GoogleFonts.oswald(
                          textStyle: TextStyle(
                            fontSize: 20.0, // Tamanho de fonte aumentado
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0), // Espaçamento entre os botões
                  Container(
                    width: 120.0, // Largura desejada
                    child: ElevatedButton(
                      onPressed: () {
                        // Ação para 30 dias
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green[800]!,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Text(
                        '30 dias',
                        style: GoogleFonts.oswald(
                          textStyle: TextStyle(
                            fontSize: 20.0, // Tamanho de fonte aumentado
                            color: Colors.white,
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