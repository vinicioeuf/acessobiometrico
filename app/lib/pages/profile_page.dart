import 'package:app/pages/perfilAcessosPage.dart';
import 'package:app/pages/perfilPessoaisPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isAccessButtonSelected = false;
  int selectedIndexPerfil = 0;
  late PageController pcPerfil;
  

  @override
  void initState() {
    super.initState();
    pcPerfil = PageController(initialPage: selectedIndexPerfil);
    Firebase.initializeApp();
  }

  @override
  void dispose() {
    pcPerfil.dispose();
    super.dispose();
  }

  void setPaginaAtualPerfil(int index) {
    setState(() {
      selectedIndexPerfil = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            PageView(
              controller: pcPerfil,
              onPageChanged: setPaginaAtualPerfil,
              children: [
                PessoaisPage(),
                AcessosPage(),
              ],
            ),
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.green[700],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(200),
                  bottomRight: Radius.circular(200),
                ),
              ),
            ),
            
            Align(
              alignment: Alignment.center,
              child: Transform.translate(
                offset: Offset(0, -25),
                child: Container(
                  width: 150,
                  height: 150,
                  // decoration: BoxDecoration(
                  //   shape: BoxShape.circle,
                  //   border: Border.all(
                  //     color: Colors.white,
                  //     width: 2,
                  //   ),
                  // ),
                  child: FutureBuilder<User?>(
                    future: FirebaseAuth.instance.authStateChanges().first,
                    builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else {
                        if (snapshot.hasData) {
                          User? user = snapshot.data;
                          return Align(
                            alignment: Alignment.center,
                            child: Transform.translate(
                              offset: Offset(0, -200),
                              child: Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(user!.photoURL ?? ''),
                                  radius: 75,
                                ),
                              ),
                            ),
                          );
                            // Text('Email: ${user!.email}'),
                            // Text('Foto: ${user.photoURL}'),
                        } else {
                          return Text('Usuário não autenticado');
                        }
                      }
                    },
                  ),
                  // child: ClipOval(

                  //   child: Image.asset(
                  //     'assets/imagens/vicCarlos.jpg',
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                ),
              ),
            ),
            // SizedBox(height: 150),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 410),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      width: 120,
                      height: 40,
                      decoration: BoxDecoration(
                        color: selectedIndexPerfil == 0 ? Colors.green : Colors.grey,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            selectedIndexPerfil = 0;
                            pcPerfil.animateToPage(
                              selectedIndexPerfil,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          });
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.person,
                              color: selectedIndexPerfil == 0 ? Colors.white : Colors.black,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Pessoais',
                              style: TextStyle(
                                color: selectedIndexPerfil == 0 ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      width: 120,
                      height: 40,
                      decoration: BoxDecoration(
                        color: selectedIndexPerfil == 1 ? Colors.green : Colors.grey,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            selectedIndexPerfil = 1;
                            pcPerfil.animateToPage(
                              selectedIndexPerfil,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          });
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.fingerprint,
                              color: selectedIndexPerfil == 1 ? Colors.white : Colors.black,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Acessos',
                              style: TextStyle(
                                color: selectedIndexPerfil == 1 ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: FutureBuilder<User?>(
                future: FirebaseAuth.instance.authStateChanges().first,
                builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else {
                    if (snapshot.hasData) {
                      User? user = snapshot.data;
                      return Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 495),
                          child: Text(
                            '${user!.displayName}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                        // Text('Email: ${user!.email}'),
                        // Text('Foto: ${user.photoURL}'),
                    } else {
                      return Text('Usuário não autenticado');
                    }
                  }
                },
              ),
              
            ),
          ],
        ),
      ),
    );
  }
}
