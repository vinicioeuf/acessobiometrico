import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int botaoSelecionado = 0;
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.green[700],
                  borderRadius: const BorderRadius.only(
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
                  offset: Offset(0, -80),
                  child: FutureBuilder<User?>(
                    future: FirebaseAuth.instance.authStateChanges().first,
                    builder:
                        (BuildContext context, AsyncSnapshot<User?> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else {
                        if (snapshot.hasData) {
                          User? user = snapshot.data;
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
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
                                  backgroundImage:
                                      NetworkImage(user!.photoURL ?? ''),
                                  radius: 75,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${user.displayName}',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Text('Usuário não autenticado');
                        }
                      }
                    },
                  ),
                ),
              ),
              Align(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          botaoSelecionado = 0;
                        });
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        width: 110,
                        height: 40,
                        decoration: BoxDecoration(
                          color: botaoSelecionado == 0
                              ? Colors.green[700]
                              : const Color.fromARGB(255, 190, 190, 190),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: botaoSelecionado == 0
                                  ? Colors.green.withOpacity(0.3)
                                  : Color.fromARGB(255, 149, 149, 149).withOpacity(0.3),
                              spreadRadius: 3,
                              blurRadius: 4,
                              offset: Offset(0, 1.5),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person,
                              color: botaoSelecionado == 0 ? Colors.white : Colors.black,
                              size: 25,
                            ),
                            SizedBox(width: 5),
                            Text(
                              "Pessoais",
                              style: TextStyle(
                                color: botaoSelecionado == 0 ? Colors.white : Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          botaoSelecionado = 1;
                        });
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        width: 110,
                        height: 40,
                        decoration: BoxDecoration(
                          color: botaoSelecionado == 1
                              ? Colors.green[700]
                              : const Color.fromARGB(255, 190, 190, 190),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: botaoSelecionado == 1
                                  ? Colors.green.withOpacity(0.3)
                                  : Color.fromARGB(255, 158, 158, 158).withOpacity(0.3),
                              spreadRadius: 3,
                              blurRadius: 4,
                              offset: Offset(0, 1.5),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.fingerprint,
                              color: botaoSelecionado == 1 ? Colors.white : Colors.black,
                              size: 25,
                            ),
                            SizedBox(width: 5),
                            Text(
                              "Acessos",
                              style: TextStyle(
                                color: botaoSelecionado == 1 ? Colors.white : Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
