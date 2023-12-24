import 'package:app/pages/show_data.dart';
import 'package:app/pages/validation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
                              Padding(padding: EdgeInsets.all(8),
                              child: Stack(
                                alignment:Alignment.center,
                                children:[
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
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 0),
                                child:
                                CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(user!.photoURL ?? ''),
                                  radius: 75,
                                ),
                              )
                                ],
                              ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${user.displayName}',
                                style: GoogleFonts.oswald(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(padding: EdgeInsets.all(8),
                              child: Stack(
                                alignment:Alignment.center,
                                children:[
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
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 0),
                                child:
                                CircleAvatar(
                                  radius: 75,
                                ),
                              )
                                ],
                              ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          );
                        }
                      }
                    },
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                    width: 300,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Validation()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green[800],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Text(
                        'Solicitar Acesso',
                        style: GoogleFonts.oswald(
                          textStyle: TextStyle(
                            fontSize: 20.0, // Tamanho de fonte aumentado
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: 300,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ValidacoesScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green[800],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Text(
                        'Solicitações',
                        style: GoogleFonts.oswald(
                          textStyle: TextStyle(
                            fontSize: 20.0, // Tamanho de fonte aumentado
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            // Adicione a ação desejada aqui
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green[800],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          child: Text(
                            'ID:',
                            style: GoogleFonts.oswald(
                              textStyle: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 0), // Espaçamento entre os botões
                      Padding(
                        padding: EdgeInsets.only(
                            left:
                                10), // Ajuste o valor do recuo à esquerda conforme necessário
                        child: Container(
                          width: 200,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: Color.fromARGB(100, 225, 244, 203),
                          ),
                          child: Center(
                            child: Text(
                              '123456',
                              style: GoogleFonts.oswald(
                                textStyle: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
