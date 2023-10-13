import 'package:flutter/material.dart';
import 'package:app/pages/agendamento_page.dart';
import 'package:app/pages/access_page.dart';
import 'about_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  Widget buildBox(IconData icon, String text, int index) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.green[700],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 50,
          ),
          SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  final List<Widget> pages = [
    HomePage(),
    // Adicione outras páginas aqui
    AboutPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView(
          children: [
            Image.asset("assets/imagens/labmaker-navbar2.jpg"),
            Divider(
              height: 1,
              color: Colors.grey,
            ),
            SizedBox(height: 10),
            Column(
              children: [
                buildBox(Icons.rocket_launch, 'PROJETOS', 0),
                SizedBox(height: 20),
                buildBox(Icons.report, 'AVISOS', 1),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AgendamentoPage()),
                    );
                  },
                  child: buildBox(Icons.date_range, 'AGENDAMENTO', 2),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AccessPage()),
                    );
                  },
                  child: buildBox(Icons.fingerprint, 'ACESSOS', 3),
                ),
              ],
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
            if (index == 0) {
              index = 0;
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
      ),
    );
  }
}

