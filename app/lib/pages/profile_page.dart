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
              SizedBox(height: 5),
              Container(
                width: 0.9 * double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.green[700],
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(100),
                    bottomRight: Radius.circular(100),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Transform.translate(
                  offset: Offset(0, -80),
                  child: FutureBuilder<User?>(
                    future: FirebaseAuth.instance.authStateChanges().first,
                    builder:
                        (BuildContext context, AsyncSnapshot<User?> snapshot) {
                      if (snapshot.hasData) {
                        User? user = snapshot.data;
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    //padding: EdgeInsets.only(top: 0),
                                    child: CircleAvatar(
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
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    //padding: EdgeInsets.only(top: 0),
                                    child: CircleAvatar(
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
                  info(context, "ID:", "3277247099032978773"),
                  SizedBox(height: 10),
                  info(context, "E-MAIL:", 'alvaro.victor@aluno.ifsertao-pe.edu.br'),
                  SizedBox(height: 10),
                  info(context, "MAT:", "2023140001"),
                  SizedBox(height: 10),
                  info(context, "VIN:", "Bolsista"),
                  SizedBox(height: 10),
                  info(context, "CUR:", "Sistemas para Internet"),
                  SizedBox(height: 10),
                  info(context, "P/A:", "3º Período"),
                  SizedBox(height: 10),
                 
                 
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget info(context, String titulo, String dado){
    return  Container(
                    width: 0.9 * MediaQuery.of(context).size.width,
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10),
                          width: 0.9 * MediaQuery.of(context).size.width,
                          height: 45,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 203, 255, 200),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                          width: 0.4 * MediaQuery.of(context).size.width,
                                
                                alignment: Alignment.center,
                                
                                child:
                            Text(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              dado,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 16, 16, 16),
                                  fontFamily: 'oswald',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                              ),
                            SizedBox(width: 10),
                          Icon(Icons.copy_sharp, color: Colors.green[800],)
                            ],
                        ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 0.25 * MediaQuery.of(context).size.width,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.green[700],
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Text(
                            titulo,
                            style: TextStyle(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                fontFamily: 'oswald',
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  );

  }
}
