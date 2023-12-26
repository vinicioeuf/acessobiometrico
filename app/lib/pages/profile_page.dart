import 'package:app/pages/show_data.dart';
import 'package:app/pages/validation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<bool> esconderList = [false, false, false, false, false, false];
  Object? dados;
  bool carregando = true;
  String? uu;
  // String? mat;
  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('validações');

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
                        User? usuario = FirebaseAuth.instance.currentUser;
                        String uid = usuario!.uid;
                        // ignore: deprecated_member_use
                        // DatabaseReference userRef = FirebaseDatabase.instance.reference().child('users').child(uid);
                        // print(userRef.once().then((value) => null));
                        DatabaseReference starCountRef = FirebaseDatabase
                            .instance
                            .ref('users/$uid/solicitou');
                        starCountRef.onValue.listen((DatabaseEvent event) {
                          final data = event.snapshot.value;
                          // print(data);
                          setState(() {
                            dados = data;
                          });
                        });
                        DatabaseReference starCountRef2 = FirebaseDatabase
                            .instance
                            .ref('users/$uid/matricula');
                        starCountRef2.onValue.listen((DatabaseEvent event) {
                          final data = event.snapshot.value;
                          // print(data);
                          setState(() {
                            uu = data as String?;
                          });
                        });
                        // DatabaseReference starCountRef2 =
                        //         FirebaseDatabase.instance.ref('users/$uid/matricula');
                        // starCountRef.onValue.listen((DatabaseEvent event) {
                        //     final data = event.snapshot.value;
                        //     // print(data);
                        //     setState(() {
                        //       mat = data as String?;
                        //     });
                        // });

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
                              height: 0,
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
                  SizedBox(
                    height: 0,
                  ),
                  if (dados == true)
                    FutureBuilder<DocumentSnapshot>(
                      future: users.doc(uu).get(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        // if (snapshot.hasError) {
                        //   return Text("Something went wrong");
                        // }

                        // if (snapshot.hasData && !snapshot.data!.exists) {
                        //   return Text("Document does not exist");
                        // }

                        // if (snapshot.connectionState == ConnectionState.done) {
                        //   Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                        //   return Text("Full Name: ${data['nome']}");
                        // }
                        
                        Map<String, dynamic> data = {};
                        if (snapshot.data?.data() != null) {
                          data = snapshot.data!.data() as Map<String, dynamic>;
                        }
                        if (snapshot.connectionState == ConnectionState.waiting && carregando == true) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Colors.green[800],
                            ),
                          );
                          
                        } else {
                          carregando = false;
                          return Column(children: [
                            info(context, "ID:", "ID", "3277247099032978773",
                                true, 0),
                            SizedBox(height: 10),
                            info(context, "E-MAIL:", "E-MAIL", '${data['email']}',
                                true, 1),
                            SizedBox(height: 10),
                            info(context, "MAT:", 'MATRÍCULA',
                                "${data['matricula']}", true, 2),
                            SizedBox(height: 10),
                            if (data['vinculo'] != null &&
                                data['vinculo']['tipoVinculo'] != null)
                              info(context, "VIN:", 'VÍNCULO',
                                  '${data['vinculo']['tipoVinculo']}', false, 3),
                            SizedBox(height: 10),
                            if (data['vinculo'] != null &&
                                data['vinculo']['tipoCurso'] != null)
                              info(context, "CUR:", 'CURSO',
                                  '${data['vinculo']['tipoCurso']}', false, 4),
                            SizedBox(height: 10),
                            if (data['vinculo'] != null &&
                                data['vinculo']['tempo'] != null)
                              info(context, "P/A:", 'PERÍODO/ANO',
                                  '${data['vinculo']['tempo']}', false, 5),
                            SizedBox(height: 30),
                          ]);
                        }
                        
                        

                        
                      },
                    ),
                  if (dados == false)
                    Container(
                      width: 300,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Validation()),
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
                  SizedBox(height: 10),
                  if (dados == false)
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget info(context, String titulo, String tituloCompleto, String dado,
      bool copy, int index) {
    return Container(
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
                  alignment: Alignment.centerLeft,
                  child: Text(
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
                if (copy)
                  GestureDetector(
                    onTap: () {
                      _copyToClipboard(dado);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Copiado'),
                        ),
                      );
                    },
                    child: Icon(Icons.copy_sharp, color: Colors.green[800]),
                  ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                esconderList[index] = !esconderList[index];
              });
            },
            child: AnimatedContainer(
              width: esconderList[index]
                  ? 0.9 * MediaQuery.of(context).size.width
                  : 0.33 * MediaQuery.of(context).size.width,
              height: 50,
              alignment: Alignment.center,
              duration: const Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green[800],
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Center(
                  child: Container(
                    child: esconderList[index]
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                Icon(
                                  Icons.lock_outline_rounded,
                                  color: Colors.white,
                                ),
                                Text(
                                  tituloCompleto,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'oswald',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                )
                              ])
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                Icon(Icons.lock_open_rounded,
                                    color: Colors.white),
                                Text(titulo,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'oswald',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18))
                              ]),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _copyToClipboard(String s) {
  Clipboard.setData(ClipboardData(text: s));
}
