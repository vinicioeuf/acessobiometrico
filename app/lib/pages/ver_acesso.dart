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
  List<DogBreed> breeds = [];
  String? uu;
  bool carregando = true;
  late String estado;
  @override
  void initState() {
    super.initState();
    fetchData();
    initializeData();
  }
Future<void> initializeData() async {
    User? user = await FirebaseAuth.instance.authStateChanges().first;
    if (user != null) {
      String uid = user.uid;


      DatabaseReference starCountRef2 =
          FirebaseDatabase.instance.ref('users/$uid/matricula');
      starCountRef2.onValue.listen((DatabaseEvent event) {
        final data = event.snapshot.value;
        if (mounted) {
          setState(() {
            uu = data as String?;
          });
        }
      });
    }
  }
  Future<void> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse('https://api-labmaker-db7c20aa74d8.herokuapp.com/acessos'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> breedsList = data['acessos'];

        setState(() {
          breeds = breedsList.map((json) => DogBreed.fromJson(json)).toList();
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Map<String, List<DogBreed>> groupByUser() {
    Map<String, List<DogBreed>> userAccess = {};

    for (var breed in breeds) {
      if (!userAccess.containsKey(breed.email)) {
        userAccess[breed.email] = [];
      }
      userAccess[breed.email]?.add(breed);
    }

    return userAccess;
  }

  Map<String, double> calculateWorkHours() {
    var userAccess = groupByUser();
    Map<String, double> workHours = {};

    userAccess.forEach((user, accessList) {
      accessList.sort((a, b) => a.createdAt.compareTo(b.createdAt));

      double totalHours = 0;
      DateTime? lastInTime;

      for (var access in accessList) {
        if (access.tipo == 'Entrou') {
          lastInTime = DateTime.parse(access.createdAt);
        } else if (access.tipo == 'Saiu' && lastInTime != null) {
          DateTime outTime = DateTime.parse(access.createdAt);
          totalHours += outTime.difference(lastInTime).inHours.toDouble();
          lastInTime = null;
        }
      }

      workHours[user] = totalHours;
    });

    return workHours;
  }


  @override
  Widget build(BuildContext context) {
    Map<String, double> userWorkHours = calculateWorkHours();
    CollectionReference users = FirebaseFirestore.instance.collection('validações');
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_circle_left_outlined, size: 40),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                "Banco de Horas",
                style: GoogleFonts.oswald(
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 255, 255, 255)),
              ),
              backgroundColor: Colors.green[800],
              shadowColor: Colors.white,
              iconTheme: IconThemeData(
                  color: const Color.fromARGB(255, 255, 255, 255)),
            ),
            body: ListView.builder(
                itemCount: userWorkHours.length,
                itemBuilder: (context, index) {
                  var user = userWorkHours.keys.elementAt(index);
                  var workHours = userWorkHours[user];
                  return SingleChildScrollView(
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
                  FutureBuilder<DocumentSnapshot>(
                    future: users.doc(uu).get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      Map<String, dynamic> data = {};
                      if (snapshot.data?.data() != null) {
                        data = snapshot.data!.data() as Map<String, dynamic>;
                      }
                      if (snapshot.connectionState == ConnectionState.waiting &&
                          carregando) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.green[800],
                          ),
                        );
                      } else {
                        if (data['aguardando'] == true) {
                          estado = "EM ESPERA";
                        } else if (data['autorizado'] == true) {
                          estado = "AUTORIZADO";
                        } else if (data['negado'] == true) {
                          estado = "NEGADO";
                        } else {
                          estado = "Erro";
                        }
                        carregando = false;
                        return Column(children: [
                          Container(
                      alignment: Alignment.center,
                      child: Transform.translate(
                        offset: Offset(0, -80),
                        child: Column(
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
                                      backgroundImage: NetworkImage(
                                          '${data['foto'] ?? ''}'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "${data['nome'] ?? ''}",
                              style: GoogleFonts.oswald(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "${data['vinculo']['tipoVinculo'] ?? ''}",
                              style: GoogleFonts.oswald(
                                  color: Colors.grey,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      )),
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
                                  '${workHours?.toStringAsFixed(2)}',
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
                                  "13",
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
                                  "13",
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
                  info(context, "CURSO:", "${data['vinculo']['curso'] ?? ''}"),
                  SizedBox(height: 15),
                  info(context, "PER/ANO:", "${data['vinculo']['tempo'] ?? ''}"),
                  SizedBox(height: 15),
                        ],);
                      }
                    },
                  ),
                  
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
            )
          );
        }
      ),
    ));
   }
                
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

class DogBreed {
  final int? id;
  final String nome;
  final String email;
  final String foto;
  final String createdAt;
  final String tipo;

  DogBreed({
    required this.id,
    required this.nome,
    required this.email,
    required this.foto,
    required this.createdAt,
    required this.tipo,
  });

  factory DogBreed.fromJson(Map<String, dynamic> json) {
    return DogBreed(
      id: json['id'] as int?,
      nome: json['nome'] as String,
      email: json['email'] as String,
      foto: json['foto'] as String,
      createdAt: json['createdAt'] as String? ?? '',
      tipo: json['tipo'] as String,
    );
  }
}

