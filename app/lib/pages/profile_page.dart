import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            CustomPaint(
              painter: _SemiCirclePainter(),
              child: Container(
                height: 600,
                width: 600,
              ),
            ),
            Positioned(
              top: 100,
              left: 120, // Ajuste a posição vertical da imagem conforme necessário
               // Ajuste a posição horizontal da imagem conforme necessário
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  'assets/imagens/viniEufrazio.jpg',
                  width: 150,
                  height: 150,
                  
                ),
                
              ),
              
            ),
            
            Center(
              child: Text("Vinicio Eufrazio"),
            ),
            

            // Restante do conteúdo da página aqui
          ],
        ),
      ),
    );
  }
}

class _SemiCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0)
      ..arcToPoint(
        Offset(size.width, 0),
        radius: const Radius.circular(100),
        clockwise: false,
      )
      ..lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
