import 'package:flutter/material.dart';

// ignore: must_be_immutable, use_key_in_widget_constructors
class TeamDevPage extends StatelessWidget {
  BuildContext? get context => null;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: Icon(
            Icons.arrow_circle_left_outlined,
            size: 40,
          ),
          title: Text(
            "EQUIPE DE DESENVOLVIMENTO",
            style: TextStyle(
                fontFamily: 'oswald',
                fontWeight: FontWeight.bold,
                color: Colors.green[800]),
          ),
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.green[800]),
        ),
        body: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(20),
            children: <Widget>[
              SizedBox(height: 25),
              buildTeamMember(
                  'assets/imagens/leoCampello.jpg',
                  'LEONARDO CAMPELLO',
                  'Professor',
                  'Mestre em Ciências (UNIVASF). Graduado em Engenharia de Computação (UNIVASF e University of Idaho). Professor EBTT do IFSertãoPE - Campus Salgueiro.'),
              SizedBox(height: 25),
              buildTeamMember(
                  'assets/imagens/vicCarlos.jpg',
                  'ÁLVARO VICTOR',
                  'Aluno',
                  'Graduando em Tecnologia em Sistemas para Internet (IFSertãoPE), Técnico em Informática (IFSertãoPE).'),
              SizedBox(height: 25),
              buildTeamMember(
                  'assets/imagens/viniEufrazio.jpg',
                  'VINICIO EUFRAZIO',
                  'Aluno',
                  'Graduando em Tecnologia em Sistemas para Internet (IFSertãoPE), Técnico em Informática (IFSertãoPE), Administrador de sites na K1Digital.'),
            ],
          ),
        ),
      );

  int selectedIndex = 0;


Widget buildTeamMember(
    String imagePath, String name, String role, String description) {
  return Container(
    alignment: Alignment.topCenter,
    width: double.infinity,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start, // Alteração aqui
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start, // Alteração aqui
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(imagePath),
            ),
            SizedBox(height: 10),
            const Column(
              children: [
                Icon(Icons.mail, color: Colors.black),
                SizedBox(height: 10),
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/imagens/github.png') ,
            ),
            SizedBox(height: 10),
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/imagens/linkedin.png') ,
            ),
            SizedBox(height: 10),
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/imagens/instagram.png') ,
            ),
              ],
            ),
          ],
        ),
        SizedBox(width: 50),
        Container(
          width: 1,
          height: 200,
          color: Colors.green[800],
        ),
        SizedBox(width: 50),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'oswald',
                    color: Colors.green[800]),
              ),
              SizedBox(height: 5),
              Text(
                role,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                    fontFamily: 'oswald',
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                description,
                style: TextStyle(fontSize: 16, fontFamily: 'oswald'),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

}
