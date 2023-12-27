import 'package:app/pages/access_page.dart';
import 'package:app/pages/profile_page.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
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

 

  @override
  void initState() {
    // AwesomeNotifications().isNotificationAllowed().then((value) => {
    //   if(!value){
    //     AwesomeNotifications().requestPermissionToSendNotifications(),
    //   }
    // });
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
            AccessPage(),
            ProfilePage(),
            AboutPage(),
          ],
          onPageChanged: setPaginaAtual,
        ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: paginaAtual,
        selectedItemColor: Colors.green[800], // Define a cor dos itens selecionados
        unselectedItemColor: Colors.grey, // Define a cor dos itens não selecionados
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.fingerprint,
            ),
            label: 'Acessos',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: 'Perfil',
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
