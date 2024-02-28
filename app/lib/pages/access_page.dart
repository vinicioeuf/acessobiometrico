import 'dart:convert';
import 'package:app/pages/ver_acesso.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class AccessPage extends StatefulWidget {
  const AccessPage({Key? key}) : super(key: key);

  @override
  State<AccessPage> createState() => _AccessPageState();
}

class _AccessPageState extends State<AccessPage> {
  List<DogBreed> breeds = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void dispose() {
    // Certifique-se de cancelar qualquer operação assíncrona ou animação aqui
    super.dispose();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse('https://dogbreeddb.p.rapidapi.com/'),
        headers: {
          "X-RapidAPI-Key": "c3564955bfmsh215d19541e7ca79p11b5dfjsna3b5c6f6b0c8",
          "X-RapidAPI-Host": "dogbreeddb.p.rapidapi.com",
        },
      );

      // Verifique se o widget ainda está montado antes de chamar setState
      if (mounted) {
        print(response.body);
        if (response.statusCode == 200) {
          final List<dynamic> data = json.decode(response.body);
          setState(() {
            breeds = data.map((json) => DogBreed.fromJson(json)).toList();
          });
        } else {
          throw Exception('Failed to load data');
        }
      }
    } catch (e) {
      print('Error fetching data: $e');
      // Lidar com o erro, se necessário
    }
  }

  int selectedIndex = 0;

  @override
Widget build(BuildContext context) {
  Widget getContent() {
    if (breeds.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.green,),
      );
    } else {
      return ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Acessos(
            context,
            breeds[index].imgThumb,
            breeds[index].breedName,
            breeds[index].breedType,
            "Saiu",
            "13:56",
            "20/10/2023",
          );
        },
      );
    }
  }

  return MaterialApp(
    home: Scaffold(
      body: Column(
        children: [
          Enfeites(),
          Expanded(
            child: getContent(),
          ),
        ],
      ),
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
@override
// ignore: non_constant_identifier_names
Widget Enfeites(){
  return SingleChildScrollView(
    child: Column(
      mainAxisAlignment:
          MainAxisAlignment.center, // Centraliza verticalmente
      children: [
        SizedBox(height: 35),
        Center(
          child: Image.asset("assets/imagens/labmaker-navbar2.jpg"),
        ),
        Divider(
          height: 1,
          color: Colors.grey,
        ),
        Center(
          child: RichText(
            text: TextSpan(
              text: 'Acessos ao LabMaker',
              style: GoogleFonts.oswald(
                textStyle: TextStyle(
                  color: Color.fromARGB(255, 36, 64, 25),
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 30),
        Wrap(
          alignment: WrapAlignment.spaceAround,
          children: [
            Container(
              width: 100.0, // Largura desejada
              child: ElevatedButton(
                onPressed: () {
                  // Ação para 24h
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green[800],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text(
                  '24h',
                  style: GoogleFonts.oswald(
                    textStyle: TextStyle(
                      fontSize: 17, // Tamanho de fonte aumentado
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 20.0,
              height: 40.0,
            ), // Espaçamento entre os botões
            Container(
              width: 100.0, // Largura desejada
              child: ElevatedButton(
                onPressed: () {
                  // Ação para 7 dias
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green[800],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text(
                  '7 dias',
                  style: GoogleFonts.oswald(
                    textStyle: TextStyle(
                      fontSize: 17, // Tamanho de fonte aumentado
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 20.0,
              height: 40.0,
            ), // Espaçamento entre os botões
            // Espaçamento entre os botões // Espaçamento entre os botões
            Container(
              width: 100.0, // Largura desejada
              child: ElevatedButton(
                onPressed: () {
                  // Ação para 30 dias
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green[800]!,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text(
                  '30 dias',
                  style: GoogleFonts.oswald(
                    textStyle: TextStyle(
                      fontSize: 17, // Tamanho de fonte aumentado
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
      ]
    )
  );
}
Widget Acessos(BuildContext context, String imagem, String nome, String vinculo,
    String estado, String hora, String data) {
  return Container(
    margin: EdgeInsets.all(8),
    padding: EdgeInsets.all(8),
    width: MediaQuery.of(context).size.width,
    child: Wrap(
      alignment: WrapAlignment.start,
      children: [
        ClipOval(
            child: Image.network(
              imagem,
              width: 40.0, // ajuste o tamanho conforme necessário
              height: 40.0, // ajuste o tamanho conforme necessário
              fit: BoxFit.cover,
            ),
          ),
        SizedBox(width: 10),
        Container(
          width: 190,
          child: // Espaçamento entre a imagem e o texto
              Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nome,
                style: GoogleFonts.oswald(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                vinculo,
                style: GoogleFonts.oswald(
                  color: const Color.fromARGB(255, 118, 118, 118),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(children: [
                Text(
                  estado,
                  style: GoogleFonts.oswald(
                    color: estado == 'Entrou' ? Colors.green[800] : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  ' às $hora em $data',
                  style: GoogleFonts.oswald(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]),
              SizedBox(height: 10),
            ],
          ),
        ),
        Container(
          width: 0.2 * MediaQuery.of(context).size.width,
          height: 60,
          alignment: Alignment.centerRight,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            GestureDetector(
              onTap: () {
                // Navegar para a HomePage quando o ícone de perfil for clicado
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VerAcesso()),
                );
              },
              child: Icon(
                Icons.double_arrow_sharp,
                size: 35.0,
                color: Colors.green[800],
              ),
            ),
          ]),
        ),
        // child: ElevatedButton(
        //     onPressed: () {},
        //     style: ElevatedButton.styleFrom(
        //       shape: RoundedRectangleBorder(
        //               borderRadius: BorderRadius.circular(30.0),
        //             ),
        //       fixedSize: Size(MediaQuery.of(context).size.width, 50),
        //       primary: Colors.white,
        //     ),
        //     child: Text('Ver Mais',
        //         style: GoogleFonts.oswald(
        //           textStyle: TextStyle(
        //             fontSize: 20.0,
        //             color: Colors.green[800],
        //           ),
        //         )
        //         )
        //         )
        SizedBox(height: 5),
        Container(
          color: Colors.grey,
          width: MediaQuery.of(context).size.width,
          height: 1,
        )
      ],
    ),
  );
}



// body: SingleChildScrollView(
            //   child: Column(
            //     mainAxisAlignment:
            //         MainAxisAlignment.center, // Centraliza verticalmente
            //     children: [
            //       SizedBox(height: 35),
            //       Center(
            //         child: Image.asset("assets/imagens/labmaker-navbar2.jpg"),
            //       ),
            //       Divider(
            //         height: 1,
            //         color: Colors.grey,
            //       ),
            //       Center(
            //         child: RichText(
            //           text: TextSpan(
            //             text: 'Acessos ao LabMaker',
            //             style: GoogleFonts.oswald(
            //               textStyle: TextStyle(
            //                 color: Color.fromARGB(255, 36, 64, 25),
            //                 fontSize: 35,
            //                 fontWeight: FontWeight.bold,
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //       SizedBox(height: 30),
            //       Wrap(
            //         alignment: WrapAlignment.spaceAround,
            //         children: [
            //           Container(
            //             width: 100.0, // Largura desejada
            //             child: ElevatedButton(
            //               onPressed: () {
            //                 // Ação para 24h
            //               },
            //               style: ElevatedButton.styleFrom(
            //                 primary: Colors.green[800],
            //                 shape: RoundedRectangleBorder(
            //                   borderRadius: BorderRadius.circular(30.0),
            //                 ),
            //               ),
            //               child: Text(
            //                 '24h',
            //                 style: GoogleFonts.oswald(
            //                   textStyle: TextStyle(
            //                     fontSize: 17, // Tamanho de fonte aumentado
            //                     color: Colors.white,
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ),
            //           SizedBox(
            //             width: 20.0,
            //             height: 40.0,
            //           ), // Espaçamento entre os botões
            //           Container(
            //             width: 100.0, // Largura desejada
            //             child: ElevatedButton(
            //               onPressed: () {
            //                 // Ação para 7 dias
            //               },
            //               style: ElevatedButton.styleFrom(
            //                 primary: Colors.green[800],
            //                 shape: RoundedRectangleBorder(
            //                   borderRadius: BorderRadius.circular(30.0),
            //                 ),
            //               ),
            //               child: Text(
            //                 '7 dias',
            //                 style: GoogleFonts.oswald(
            //                   textStyle: TextStyle(
            //                     fontSize: 17, // Tamanho de fonte aumentado
            //                     color: Colors.white,
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ),
            //           SizedBox(
            //             width: 20.0,
            //             height: 40.0,
            //           ), // Espaçamento entre os botões
            //           // Espaçamento entre os botões // Espaçamento entre os botões
            //           Container(
            //             width: 100.0, // Largura desejada
            //             child: ElevatedButton(
            //               onPressed: () {
            //                 // Ação para 30 dias
            //               },
            //               style: ElevatedButton.styleFrom(
            //                 primary: Colors.green[800]!,
            //                 shape: RoundedRectangleBorder(
            //                   borderRadius: BorderRadius.circular(30.0),
            //                 ),
            //               ),
            //               child: Text(
            //                 '30 dias',
            //                 style: GoogleFonts.oswald(
            //                   textStyle: TextStyle(
            //                     fontSize: 17, // Tamanho de fonte aumentado
            //                     color: Colors.white,
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //       SizedBox(height: 30),