import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AvisosPage extends StatefulWidget {
  const AvisosPage({super.key});

  @override
  State<AvisosPage> createState() => _AvisosPageState();
}

class _AvisosPageState extends State<AvisosPage> {
  
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
                
              },
              child: buildBox(Icons.rocket_launch, 'Dps eu altero aq', 0, context),
            ),
          ],
        ),
      ],
    );
  }
  
  Widget buildBox(IconData icon, String text, int index, BuildContext context) {
    return Container(
      width: 370,
      height: 150,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 157, 157, 157),
        borderRadius: BorderRadius.circular(50),
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
}