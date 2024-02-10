import 'dart:convert';

// import 'package:app/pages/dog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
class PublicAcess extends StatefulWidget {
  const PublicAcess({super.key});

  @override
  State<PublicAcess> createState() => _PublicAcessState();
}

class _PublicAcessState extends State<PublicAcess> {
  List<DogBreed> breeds = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }
  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse('https://dogbreeddb.p.rapidapi.com/'),
      headers: {
        "X-RapidAPI-Key": "c3564955bfmsh215d19541e7ca79p11b5dfjsna3b5c6f6b0c8",
        "X-RapidAPI-Host": "dogbreeddb.p.rapidapi.com",
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        breeds = data.map((json) => DogBreed.fromJson(json)).toList();
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
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
                "VER MAIS",
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
                                      backgroundImage: AssetImage(
                                          'assets/imagens/vicCarlos.jpg'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "Álvaro Victor",
                              style:GoogleFonts.oswald(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Bolsista",
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
                                  "67h",
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
                  info(context, "CURSO:", "SISTEMAS PARA INTERNET"),
                  SizedBox(height: 15),
                  info(context, "PER/ANO:", "3º PERÍODO"),
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
  final String breedName;
  final String breedType;
  final String breedDescription;
  final String imgThumb;

  DogBreed({
    required this.id,
    required this.breedName,
    required this.breedType,
    required this.breedDescription,
    required this.imgThumb,
  });

  factory DogBreed.fromJson(Map<String, dynamic> json) {
    return DogBreed(
      id: json['id'],
      breedName: json['breedName'],
      breedType: json['breedType'],
      breedDescription: json['breedDescription'],
      imgThumb: json['imgThumb'] ?? '',
    );
  }
}