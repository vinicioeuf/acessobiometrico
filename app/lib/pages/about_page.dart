import 'package:app/pages/home_page.dart';
import 'package:app/pages/team_dev.dart';
import 'package:flutter/material.dart';



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
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
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
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/imagens/leoCampello.jpg'), // Passo 7
                          radius: 50,
                        ),
                        SizedBox(height: 15),
                        Text('Leonardo Campello'),
                      ],
                    ),
                    SizedBox(width: 30), // Aumente a largura do SizedBox conforme necessário
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/imagens/viniEufrazio.jpg'), // Passo 7
                          radius: 50,
                        ),
                        SizedBox(height: 15),
                        Text('Vinicio Eufrazio'),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/imagens/vicCarlos.jpg'), // Passo 7
                          radius: 50,
                        ),
                        SizedBox(height: 15),
                        Text('Victor Carlos'),
                      ],
                    ),
                    SizedBox(width: 50), // Aumente a largura do SizedBox conforme necessário
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/imagens/PLemos.jpg'), // Passo 7
                          radius: 50,
                        ),
                        SizedBox(height: 15),
                        Text('Pedro Lemos'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } else if (index == 1) {
            // Defina a rota para a página de perfil
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AboutPage()),
            );
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explorar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help_outline),
            label: 'Sobre',
          ),
        ],
        selectedItemColor: Color.fromARGB(255, 87, 85, 85), // Define a cor dos ícones selecionados
      ),
    );
  }
  
  void setState(Null Function() param0) {}
}