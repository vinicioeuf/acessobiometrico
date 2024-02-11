import 'dart:convert';

// import 'package:app/pages/dog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
class VerAcesso extends StatefulWidget {
  const VerAcesso({super.key});

  @override
  State<VerAcesso> createState() => _VerAcessoState();
}

class _VerAcessoState extends State<VerAcesso> {
  Map<String, dynamic>? userData;
  String? abc;
  String? vinculo;
  @override
  void initState() {
    super.initState();
    fetchData();
    abccc();
    // getTipoVinculo(getMatriculaDoUsuarioAtual() as String);
  }
  Future<String> getTipoVinculo(String matricula) async {
    var doc = await FirebaseFirestore.instance.collection('validações').doc(matricula).get();
    if (doc.exists) {
      return doc.data()?['vinculo']['tipoVinculo'];
    } else {
      return 'Vínculo não encontrado';
    }
  }
  
  Future<void> abccc() async {
    User? user = await FirebaseAuth.instance.authStateChanges().first;
    if (user != null) {
      String uid = user.uid;
      DatabaseReference starCountRef =
          FirebaseDatabase.instance.ref('users/$uid/vinculo');
      starCountRef.onValue.listen((DatabaseEvent event) {
        final datado = event.snapshot.value;
        if (mounted) {
          setState(() {
            vinculo = datado as String?;
            print(vinculo);
          });
        }
      });
      DatabaseReference starCountRef2 =
          FirebaseDatabase.instance.ref('users/$uid/matricula');
      starCountRef2.onValue.listen((DatabaseEvent event) {
        final data = event.snapshot.value;
        if (mounted) {
          setState(() {
            abc = data as String?;
          });
        }
      });
    }
  }
  Future<String> getVinculo() async {
    DocumentSnapshot document = await FirebaseFirestore.instance.collection('validações').doc(abc).get();
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    return data['vinculo']['tipoVinculo'];
  }
  
  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('https://api-labmaker-db7c20aa74d8.herokuapp.com/'));
    if (response.statusCode == 200) {
      setState(() {
        userData = json.decode(response.body);
        // print(userData);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    String? emailAPI = userData?['usuarios'][0]['email'];
    int? idBiometriaAPI = userData?['usuarios'][0]['idBiometria'];
    int? horas = userData?['usuarios'][0]['horas'];
    int? entradas = userData?['usuarios'][0]['entradas'];
    int? saidas = userData?['usuarios'][0]['saidas'];
    // print("O EMAIL È: {$emailAPI}");
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              title: Text(
                "SEUS ACESSOS",
                style: GoogleFonts.oswald(
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 255, 255, 255)),
              ),
              backgroundColor: Colors.green[800],
              shadowColor: Colors.white,
              iconTheme: IconThemeData(
                  color: const Color.fromARGB(255, 255, 255, 255)),
            ),
            body: SingleChildScrollView(
                child: Transform.translate(
              offset: Offset(0, -40),
              child: Column(
                children: [
                  SizedBox(height: 5),
                  Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.green[800],
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
                                        child: CircleAvatar(
                                          radius: 75,
                                          backgroundImage: NetworkImage(user!.photoURL ?? '')
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  '${user.displayName}',
                                  style:GoogleFonts.oswald(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  '${vinculo as String?}',
                                  style: GoogleFonts.oswald(
                                      color: Colors.grey,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            );
                          }
                           else {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
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
                            
                        }

                      ),
                    ),
                  ),
                  Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Transform.translate(
                        offset: Offset(0, -20),
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "HORAS",
                                  style: GoogleFonts.oswald(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                Text(
                                  "${horas}h",
                                  style: GoogleFonts.oswald(
                                      color: Colors.black,
                                      fontSize: 15),
                                )
                              ],
                            ),
                            SizedBox(width: 30),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "ENTRADAS",
                                  style: GoogleFonts.oswald(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                Text(
                                  "${entradas}",
                                  style: GoogleFonts.oswald(
                                      color: Colors.black,
                                      fontSize: 15),
                                )
                              ],
                            ),
                            SizedBox(width: 30),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "SAÍDAS",
                                  style: GoogleFonts.oswald(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                Text(
                                  "${saidas}",
                                  style: GoogleFonts.oswald(
                                      color: Colors.black,
                                      fontSize: 15),
                                )
                              ],
                            )
                          ],
                        ),
                      )),
                  info(context, "STATUS:", "AUTORIZADO"),
                  SizedBox(height: 15),
                  info(context, "CURSO:", "SISTEMAS PARA INTERNET"),
                  SizedBox(height: 15),
                  info(context, "PER/ANO:", "3º PERÍODO"),
                  SizedBox(height: 15),
                  // Container(
                  //   alignment: Alignment.center,
                  //   width: 0.9 * MediaQuery.of(context).size.width,
                  //   child: Container(
                  //     width: 0.9 * MediaQuery.of(context).size.width,
                  //     height: 50,
                  //     alignment: Alignment.center,
                  //     decoration: BoxDecoration(
                  //       color: Colors.red, // Cor de fundo do Container interno
                  //       borderRadius: BorderRadius.circular(30.0),
                  //     ),
                  //     child: Text(
                  //       "DENUNCIAR",
                  //       style: GoogleFonts.oswald(
                  //         color: Color.fromARGB(255, 255, 255, 255),
                  //         fontSize: 20,
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ))));
  }

  Widget info(context, String titulo, String dado) {
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
                  color: Color.fromARGB(100, 225, 244, 203),
              
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 0.4 * MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    dado,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: dado == "AUTORIZADO"
                        ? GoogleFonts.oswald(
                            color: Colors.green[800],
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          )
                        : GoogleFonts.oswald(
                            color: Color.fromARGB(255, 16, 16, 16),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                  ),
                ),
                SizedBox(width: 10),
              ],
            ),
          ),
          Container(
              alignment: Alignment.center,
              width: 0.33 * MediaQuery.of(context).size.width,
              height: 50,
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.green[800],
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Text(
                  titulo,
                  style: GoogleFonts.oswald(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      fontSize: 20,
                      fontWeight: FontWeight.w800),
                ),
              ))
        ],
      ),
    );
  }
}
class DogBreed {
  final int id;
  final String emailAPI;
  final String horas;
  final String entradas;
  final String saidas;

  DogBreed({
    required this.id,
    required this.emailAPI,
    required this.horas,
    required this.entradas,
    required this.saidas,
  });

  factory DogBreed.fromJson(Map<String, dynamic> json) {
    return DogBreed(
      id: json['_id'],
      emailAPI: json['email'],
      horas: json['horas'],
      entradas: json['entradas'],
      saidas: json['saidas'] ?? '',
    );
  }
}