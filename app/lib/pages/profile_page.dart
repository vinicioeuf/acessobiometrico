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
                offset: Offset(0, -90),
                child: Container(
                  width: 150,
                  height: 150,
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
                              offset: Offset(0, -130),
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
                        } else {
                          return Text('Usuário não autenticado');
                        }
                      }
                    },
                  ),
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
                          padding: const EdgeInsets.only(bottom: 470),
                          child: Text(
                            '${user!.displayName}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
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

