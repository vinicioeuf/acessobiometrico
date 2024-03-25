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
  late Map<String, dynamic> currentUserData;
  List<DogBreed> originalBreeds = [];
  late String estado;
  late String userId;
  @override
  void initState() {
    super.initState();
    fetchData();
    initializeData();
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2022),
      lastDate: DateTime(now.year, now.month, now.day, 23, 59, 59),
    );

    if (picked != null) {
      DateTime startDate = picked.start;
      DateTime endDate = picked.end;

      // Ajuste nas datas para considerar todo o intervalo selecionado
      startDate =
          DateTime(startDate.year, startDate.month, startDate.day, 0, 0, 0);
      endDate = DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 59);

      // Filtrar os dados com base no intervalo selecionado
      List<DogBreed> filteredBreeds = breeds.where((breed) {
        DateTime createdAt = DateTime.parse(breed.createdAt);
        return createdAt.isAtSameMomentAs(startDate) ||
            createdAt.isAfter(startDate) && createdAt.isBefore(endDate) ||
            createdAt.isAtSameMomentAs(endDate);
      }).toList();
      if (filteredBreeds.isEmpty) {
        // Caso não haja dados dentro do intervalo selecionado, exibir uma mensagem ou tomar outra ação
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Sem dados"),
              content: Text("Não há dados dentro do intervalo selecionado."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      } else {
        // Atualizar os dados exibidos com base no intervalo filtrado
        setState(() {
          breeds = filteredBreeds;
        });
      }
    }
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

  Map<String, Map<String, dynamic>> calculateWorkHoursAndCounts() {
  var userAccess = groupByUser();
  Map<String, Map<String, dynamic>> workData = {};

  String currentUserEmail = FirebaseAuth.instance.currentUser?.email ?? '';

  userAccess.forEach((user, accessList) {
    if (user == currentUserEmail) {
      accessList.sort((a, b) => a.createdAt.compareTo(b.createdAt));

      double totalHours = 0;
      int entryCount = 0;
      int exitCount = 0;
      DateTime? lastInTime;

      for (var access in accessList) {
        if (access.tipo == 'Entrou') {
          entryCount++;
          lastInTime = DateTime.parse(access.createdAt);
        } else if (access.tipo == 'Saiu' && lastInTime != null) {
          exitCount++;
          DateTime outTime = DateTime.parse(access.createdAt);
          Duration duration = outTime.difference(lastInTime);
          totalHours += duration.inMinutes.toDouble() / 60;
          lastInTime = null;
        }
      }

      workData[user] = {
        'totalHours': totalHours,
        'entryCount': entryCount,
        'exitCount': exitCount,
      };
    }
  });

  // Verificar se não há dados, definir valores padrão para zero
  if (workData.isEmpty) {
    workData[currentUserEmail] = {
      'totalHours': 0,
      'entryCount': 0,
      'exitCount': 0,
    };
  }

  return workData;
}

  @override
  Widget build(BuildContext context) {
    Map<String, Map<String, dynamic>> userData = calculateWorkHoursAndCounts();
    CollectionReference users =
        FirebaseFirestore.instance.collection('validações');
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
        iconTheme:
            IconThemeData(color: const Color.fromARGB(255, 255, 255, 255)),
        actions: [
          IconButton(
            onPressed: () => _selectDateRange(context),
            icon: Icon(Icons.date_range),
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: userData.length,
          itemBuilder: (context, index) {
            var user = userData.keys.elementAt(index);
            var workData = userData[user];
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
                        return Column(
                          children: [
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
                                                    '${FirebaseAuth.instance.currentUser?.photoURL ?? ''}'),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        "${FirebaseAuth.instance.currentUser?.displayName ?? ''}",
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "HORAS",
                                            style: GoogleFonts.oswald(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                          Text(
                                            '${workData?['totalHours']?.toStringAsFixed(2)}',
                                            style: GoogleFonts.oswald(
                                                color: Colors.black,
                                                fontSize: 15),
                                          )
                                        ],
                                      ),
                                      SizedBox(width: 30),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "ENTRADAS",
                                            style: GoogleFonts.oswald(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                          Text(
                                            "${workData?['entryCount']}",
                                            style: GoogleFonts.oswald(
                                                color: Colors.black,
                                                fontSize: 15),
                                          )
                                        ],
                                      ),
                                      SizedBox(width: 30),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "SAÍDAS",
                                            style: GoogleFonts.oswald(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                          Text(
                                            "${workData?['exitCount']}",
                                            style: GoogleFonts.oswald(
                                                color: Colors.black,
                                                fontSize: 15),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )),
                            info(context, "STATUS:", estado),
                            SizedBox(height: 15),
                            info(context, "CURSO:",
                                "${data['vinculo']['curso'] ?? ''}"),
                            SizedBox(height: 15),
                            info(context, "PER/ANO:",
                                "${data['vinculo']['tempo'] ?? ''}"),
                            SizedBox(height: 15),
                          ],
                        );
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
            ));
          }),
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
                              fontWeight: FontWeight.bold)
                          : dado == 'NEGADO'
                              ? GoogleFonts.oswald(
                                  color: Colors.red,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)
                              : dado == "EM ESPERA"
                                  ? GoogleFonts.oswald(
                                      color: Color.fromARGB(255, 190, 146, 0),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)
                                  : GoogleFonts.oswald(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
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
