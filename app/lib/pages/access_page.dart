import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AccessPage extends StatefulWidget {
  const AccessPage({Key? key}) : super(key: key);

  @override
  State<AccessPage> createState() => _AccessPageState();
}

class _AccessPageState extends State<AccessPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 120.0, // Largura desejada
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
                            fontSize: 20.0, // Tamanho de fonte aumentado
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0), // Espaçamento entre os botões
                  Container(
                    width: 120.0, // Largura desejada
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
                            fontSize: 20.0, // Tamanho de fonte aumentado
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0), // Espaçamento entre os botões
                  Container(
                    width: 120.0, // Largura desejada
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
                            fontSize: 20.0, // Tamanho de fonte aumentado
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Acessos('assets/imagens/leoCampello.jpg', "Leonardo Campello",
                  "Professor", "Saiu", "13:56", "20/10/2023"),
              Acessos('assets/imagens/viniEufrazio.jpg', "Vinicio Eufrazio",
                  "Bolsista", "Saiu", "13:53", "20/10/2023"),
              Acessos('assets/imagens/vicCarlos.jpg', "Álvaro Victor",
                  "Bolsista", "Saiu", "13:53", "20/10/2023"),
              Acessos('assets/imagens/leoCampello.jpg', "Leonardo Campello",
                  "Professor", "Entrou", "07:53", "20/10/2023"),
              Acessos('assets/imagens/viniEufrazio.jpg', "Vinicio Eufrazio",
                  "Bolsista", "Entrou", "07:45", "20/10/2023"),
              Acessos('assets/imagens/vicCarlos.jpg', "Álvaro Victor",
                  "Bolsista", "Entrou", "07:45", "20/10/2023"),
            ],
          ),
        ),
      ),
    );
  }
}

Widget Acessos(String imagem, String nome, String vinculo, String estado,
    String hora, String data) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center, // Centraliza horizontalmente
    children: [
      Row(
        mainAxisAlignment:
            MainAxisAlignment.center, // Centraliza horizontalmente
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(imagem),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "$nome",
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "$vinculo",
                  style: TextStyle(fontSize: 13.0, color: Colors.grey),
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          estado,
                          style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                            color: estado == "Entrou"
                                ? Colors.green[800]!
                                : Colors.red,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          'às $hora em $data',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: ElevatedButton(
              onPressed: () {
                // Adicione a ação desejada para o botão
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.green[800]!,
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
              child: Text(
                'Ver mais',
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      SizedBox(height: 10),
      Divider(
        height: 1,
        color: Colors.grey,
      ),
      SizedBox(
        height: 5,
      )
    ],
  );
}
