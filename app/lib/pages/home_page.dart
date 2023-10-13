import 'package:app/pages/explorarPage.dart';
import 'package:app/pages/login_page.dart';
import 'package:app/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'about_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  int paginaAtual = 0;
  late PageController pc;

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

  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: paginaAtual);
  }

  setPaginaAtual(pagina) {
    setState(() {
      paginaAtual = pagina;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: PageView(
          controller: pc,
          children: [
            ExplorarPage(),
            LoginPage(),
            RegisterPage(),
            AboutPage(),
          ],
          onPageChanged: setPaginaAtual,
        ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: paginaAtual,
        selectedItemColor: Colors.green[700], // Define a cor dos itens selecionados
        unselectedItemColor: Colors.grey, // Define a cor dos itens não selecionados
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.explore,
            ),
            label: 'Explorar',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.lock,
            ),
            label: 'Login',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: 'Cadastro',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.help_outline,
            ),
            label: 'Sobre',
          ),
        ],
        onTap: (pagina) {
          pc.animateToPage(pagina,
              duration: Duration(milliseconds: 400), curve: Curves.ease);
        },
      ),

      ),
    );
  }
}
