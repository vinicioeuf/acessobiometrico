import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
class VerAcessoAdm extends StatefulWidget {
  final String vinculo;

  const VerAcessoAdm({Key? key, required this.vinculo}) : super(key: key);


  @override
  _VerAcessoAdmState createState() => _VerAcessoAdmState();
}

class _VerAcessoAdmState extends State<VerAcessoAdm> {
  String vinculo = '';
  String curso = '';
  String perAno = '';
List<DogBreed?> breeds = [];
  double totalHoras = 0;
  int totalEntradas = 0;
  int totalSaidas = 0;
  DateTime? startDate;
  DateTime? endDate;
  @override
  void initState() {
    super.initState();
    fetchData();
    fetchUserInfo(widget.vinculo);
  }
  _selectDateRange(BuildContext context) async {
    final initialDateRange = DateTimeRange(
      start: startDate ?? DateTime.now(),
      end: endDate ?? DateTime.now(),
    );

    final pickedDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
      initialDateRange: initialDateRange,
    );

    if (pickedDateRange != null) {
      setState(() {
        startDate = pickedDateRange.start;
        endDate = pickedDateRange.end;
      });

      // Filtrar os dados com base no intervalo de datas selecionado
      filterData();
    }
  }
  Future<void> filterData() async {
  try {
    final response = await http.get(
      Uri.parse('https://api-labmaker.vercel.app/acessos'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> breedsList = data['acessos'];

      List<DogBreed?> foundBreeds = [];
      for (var json in breedsList) {
        final breed = DogBreed.fromJson(json);
        DateTime createdAt = DateTime.parse(breed.createdAt);
        if (breed.email == widget.vinculo &&
            (startDate == null || createdAt.isAfter(startDate!) || createdAt.isAtSameMomentAs(startDate!)) &&
            (endDate == null || createdAt.isBefore(endDate!) || createdAt.isAtSameMomentAs(endDate!))) {
          foundBreeds.add(breed);
        }
      }

      if (foundBreeds.isEmpty) {
        // ignore: use_build_context_synchronously
        fetchData();
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
      }

      calculateTotals(foundBreeds);

      setState(() {
        breeds = foundBreeds;
      });
    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
    print('Error fetching data: $e');
  }
}

  Future<void> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse('https://api-labmaker.vercel.app/acessos'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> breedsList = data['acessos'];

        List<DogBreed?> foundBreeds = [];
        for (var json in breedsList) {
          final breed = DogBreed.fromJson(json);
          if (breed.email == widget.vinculo) {
            foundBreeds.add(breed);
          }
        }

        calculateTotals(foundBreeds);

        setState(() {
          breeds = foundBreeds;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void calculateTotals(List<DogBreed?> breedsList) {
    totalHoras = 0.0;
    totalEntradas = 0;
    totalSaidas = 0;

    breedsList.forEach((breed) {
      if (breed != null) {
        if (breed.tipo == "Entrou") {
          totalEntradas++;
        } else if (breed.tipo == "Saiu") {
          totalSaidas++;
        }
      }
    });

    for (int i = 0; i < breedsList.length - 1; i++) {
      if (breedsList[i]?.tipo == "Entrou" &&
          breedsList[i + 1]?.tipo == "Saiu") {
        DateTime entrada = DateTime.parse(breedsList[i]!.createdAt);
        DateTime saida = DateTime.parse(breedsList[i + 1]!.createdAt);
        totalHoras += saida.difference(entrada).inMinutes / 60; // Modificação aqui
      }
    }
    totalHoras = double.parse(totalHoras.toStringAsFixed(2));
  }
  Future<void> fetchUserInfo(String email) async {
  try {
    final snapshot = await FirebaseFirestore.instance
        .collection('validações')
        .where('email', isEqualTo: email)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final data = snapshot.docs.first.data();
      vinculo = data['vinculo']['tipoVinculo'];
      curso = data['vinculo']['curso'];
      perAno = data['vinculo']['tempo'];

      // Faça o que quiser com as informações aqui
      print('vinculo: $vinculo, Curso: $curso, Período/Ano: $perAno');
    } else {
      print('Nenhum usuário encontrado com o email $email');
    }
  } catch (e) {
    print('Erro ao buscar informações do usuário: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        iconTheme: IconThemeData(color: const Color.fromARGB(255, 255, 255, 255)),
        actions: [
          IconButton(
            onPressed: () => _selectDateRange(context),
            icon: Icon(Icons.date_range),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Transform.translate(
          offset: Offset(0, -60),
          child: Column(
            children: [
              if (breeds.isNotEmpty)
                Column(
                  children: [
                    SizedBox(height: 0),
                    Container(
                      width: double.infinity,
                      height: 170,
                      decoration: BoxDecoration(
                        color: Colors.green[800],
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(100),
                          bottomRight: Radius.circular(100),
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(0, -80),
                      child: Container(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CircleAvatar(
                                radius: 75,
                                backgroundImage: NetworkImage(breeds.first?.foto ?? ""),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(0, -80),
                      child: Text(
                        "${breeds.first?.nome}",
                        style: GoogleFonts.oswald(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 0),
                    Transform.translate(
                      offset: Offset(0, -80),
                      child: Text(
                        vinculo,
                        style: GoogleFonts.oswald(
                            color: Colors.grey,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Transform.translate(
                        offset: Offset(0, -60),
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
                                  "$totalHoras h",
                                  style: GoogleFonts.oswald(
                                      color: Colors.black, fontSize: 15),
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
                                  "$totalEntradas",
                                  style: GoogleFonts.oswald(
                                      color: Colors.black, fontSize: 15),
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
                                  "$totalSaidas",
                                  style: GoogleFonts.oswald(
                                  color: Colors.black, fontSize: 15),
                            )
                          ],
                        ),
                        // SizedBox(width: 30),
                        
                      ],
                    ),
                  ),
                ),
                info(context, "STATUS:", "AUTORIZADO"),
                SizedBox(height: 15),
                info(context, "CURSO:", curso),
                SizedBox(height: 15),
                info(context, "PER/ANO:", perAno),
                SizedBox(height: 15),
                Container(
                  alignment: Alignment.center,
                  width: 0.9 * MediaQuery.of(context).size.width,
                  child: Container(
                    width: 0.9 * MediaQuery.of(context).size.width,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.red, // Cor de fundo do Container interno
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Text(
                      "DENUNCIAR",
                      style: GoogleFonts.oswald(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
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
