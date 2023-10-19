import 'package:flutter/material.dart';
import 'package:app/pages/agendamento_page.dart';
import 'package:app/pages/projects_page.dart';
import 'package:app/pages/avisos_page.dart';
import 'package:app/pages/access_page.dart';

class ExplorarPage extends StatelessWidget {
  
  Widget buildBox(IconData icon, String text, int index, BuildContext context) {
    return Container(
      width: 370,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.green[700],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 50,
          ),
          SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Image.asset("assets/imagens/labmaker-navbar2.jpg"),
        Divider(
          height: 1,
          color: Colors.grey,
        ),
        SizedBox(height: 10),
        Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProjectsPage()),
                );
              },
              child: buildBox(Icons.rocket_launch, 'PROJETOS', 0, context),
            ),
            
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AvisosPage()),
                );
              },
              child: buildBox(Icons.report, 'AVISOS', 1, context),
            ),
            
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AgendamentoPage()),
                );
              },
              child: buildBox(Icons.date_range, 'AGENDAMENTO', 2, context),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AccessPage()),
                );
              },
              child: buildBox(Icons.fingerprint, 'ACESSOS', 3, context),
            ),
          ],
        ),
      ],
    );
  }
}
