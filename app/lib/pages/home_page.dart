import 'package:app/pages/access_page.dart';
import 'package:app/pages/dog.dart';
import 'package:app/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
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
  bool showTutorial = true; // Adiciona um estado para controlar a exibição do tutorial

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
        body: Stack( // Usa um Stack para sobrepor o tutorial sobre a página
          children: [
            
            PageView(
              controller: pc,
              children: [
                AccessPage(),
                ProfilePage(),
                AboutPage(),
                
              ],
              onPageChanged: setPaginaAtual,
            ),
            // if (showTutorial)
            //   TweenAnimationBuilder<double>(
            //     tween: Tween<double>(begin: MediaQuery.of(context).size.width, end: 0),
            //     duration: Duration(milliseconds: 1200),
            //     builder: (context, value, child) {
            //       return Transform.translate(
            //         offset: Offset(value, 0),
            //         child: child,
            //       );
            //     },
            //     child: Container(
            //       // color: Colors.black.withOpacity(0.3),
            //       child: Center(
            //         child: Icon(
            //           Icons.swipe_left,
            //           color: Colors.green[600],
            //           size: 50.0,
            //         ),
            //       ),
            //     ),
            //   ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: paginaAtual,
          selectedItemColor: Colors.green[800],
          unselectedItemColor: Colors.grey,
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
            setState(() {
              showTutorial = false;
            });
            pc.animateToPage(pagina,
                duration: Duration(milliseconds: 400), curve: Curves.ease);
          },
        ),
      ),
    );
  }
}
