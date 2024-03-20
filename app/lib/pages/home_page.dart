import 'package:app/pages/access_page.dart';
import 'package:app/pages/dog.dart';
import 'package:app/pages/profile_page.dart';
import 'package:app/pages/testeNotific.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:showcaseview/showcaseview.dart';
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
  int? credencial;
  @override
  void initState() {
    super.initState();
    // enviaNotificacao();
    pc = PageController(initialPage: paginaAtual);
  }
  
  // Future<void> enviaNotificacao() async {
  //   User? userCredencial = await FirebaseAuth.instance.authStateChanges().first;
  //   if (userCredencial != null) {
  //     String uid2 = userCredencial.uid;

  //     DatabaseReference puxaCredencial =
  //         FirebaseDatabase.instance.ref('users/$uid2/credencial');
  //     puxaCredencial.onValue.listen((DatabaseEvent event) {
  //       final dadin = event.snapshot.value;
  //       credencial = dadin as int?;
  //       print("A credencial é: $credencial");
  //       if (credencial == 1) {
  //         FirebaseFirestore.instance
  //             .collection("validações")
  //             .snapshots()
  //             .listen((QuerySnapshot snapshot) {
  //           snapshot.docChanges.forEach((change) {
  //             if (change.type == DocumentChangeType.added) {
  //               sendNotification();
  //             }
  //           });
  //         });
  //       } else {
  //         print("Veja se agora vai.");
  //       }
  //     });
  //   }
  // }

  // void sendNotification() {
  //   AwesomeNotifications().createNotification(
  //     content: NotificationContent(
  //       id: 5,
  //       channelKey: 'basic_channel',
  //       title: "Labmaker",
  //       body: "Alguém fez uma solicitação de acesso, vem conferir!",
  //     ),
  //   );
  // }

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
                ShowCaseWidget(
                  builder: Builder(
                    builder: (context) => AccessPage(),
                  ),
                ),
                ShowCaseWidget(
                  builder: Builder(
                    builder: (context) => testeNotifc(),
                  ),
                ),
                // AccessPage(),
                ShowCaseWidget(
                  builder: Builder(
                    builder: (context) => ProfilePage(),
                  ),
                ),
                // ProfilePage(),
                ShowCaseWidget(
                  builder: Builder(
                    builder: (context) => AboutPage(),
                  ),
                ),
                // AboutPage(),
                
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
