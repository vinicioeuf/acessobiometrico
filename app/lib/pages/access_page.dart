import 'package:app/pages/ver_acesso.dart';
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
              SizedBox(height: 30),
              Acessos(
                  context,
                  'assets/imagens/leoCampello.jpg',
                  "Leonardo Campello",
                  "Professor",
                  "Saiu",
                  "13:56",
                  "20/10/2023"),
              Acessos(
                  context,
                  'assets/imagens/viniEufrazio.jpg',
                  "Vinicio Eufrazio",
                  "Bolsista",
                  "Saiu",
                  "13:53",
                  "20/10/2023"),
              Acessos(context, 'assets/imagens/vicCarlos.jpg', "Álvaro Victor",
                  "Bolsista", "Saiu", "13:53", "20/10/2023"),
              Acessos(
                  context,
                  'assets/imagens/leoCampello.jpg',
                  "Leonardo Campello",
                  "Professor",
                  "Entrou",
                  "07:53",
                  "20/10/2023"),
              Acessos(
                  context,
                  'assets/imagens/viniEufrazio.jpg',
                  "Vinicio Eufrazio",
                  "Bolsista",
                  "Entrou",
                  "07:45",
                  "20/10/2023"),
              Acessos(context, 'assets/imagens/vicCarlos.jpg', "Álvaro Victor",
                  "Bolsista", "Entrou", "07:45", "20/10/2023"),
            ],
          ),
        ),
      ),
    );
  }
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
        CircleAvatar(
          backgroundImage: AssetImage(imagem),
          radius: 35,
          backgroundColor: Colors.green[800],
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
            width: 0.2*MediaQuery.of(context).size.width,
            height: 60,
            alignment: Alignment.centerRight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
            ]
            ),
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
