import 'package:postgres/postgres.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AgendamentoPage extends StatefulWidget {
  const AgendamentoPage({Key? key}) : super(key: key);

  @override
  State<AgendamentoPage> createState() => _AgendamentoPageState();
}

class _AgendamentoPageState extends State<AgendamentoPage> {
  int selectedIndex = 0;

  Future<PostgreSQLConnection> conectarAoBancoDeDados() async {
    final connection = PostgreSQLConnection(
      'bagn5vr3bcf9lplyqthm-postgresql.services.clever-cloud.com',
      5432,
      'bagn5vr3bcf9lplyqthm',
      username: 'uscce6rjf5lgua9fjb48',
      password: 'a8n5RmNZpHJ4gkZQMuj1dm3AfKMuNf',
    );

    await connection.open();

    return connection;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 35),
              Image.asset("assets/imagens/labmaker-navbar2.jpg"),
                Divider(
                height: 1,
                color: Colors.grey,
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'AGENDAMENTOS',
                    style: GoogleFonts.oswald(
                      textStyle: TextStyle(
                        color: Color.fromARGB(255, 61, 96, 47),
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  buildImageItem('assets/imagens/impressora3d.png', 'IMPRESSORA 3D'),
                  buildImageItem('assets/imagens/arduino.png', 'KIT ARDUÍNO'),
                ].map((Widget item) {
                  return Padding(
                    padding: EdgeInsets.all(20.0), // Espaçamento desejado
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0), // Raio do arredondamento
                      child: item,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget buildImageItem(String imagePath, String text) {
  return SingleChildScrollView(
    child: Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green[700],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  imagePath,
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                  semanticLabel:text,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}


}
