import 'package:cloud_firestore/cloud_firestore.dart';
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
  void initState() {
    super.initState();
    Firebase.initializeApp();
  }

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
              left: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  'assets/imagens/viniEufrazio.jpg',
                  width: 150,
                  height: 150,
                ),
              ),
            ),
            Positioned(
              top: 300,
              left: 50,
              child: FutureBuilder<User?>(
                future: FirebaseAuth.instance.authStateChanges().first,
                builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else {
                    if (snapshot.hasData) {
                      User? user = snapshot.data;
                      return Column(
                        children: [
                          Text('Nome: ${user!.displayName}'),
                          Text('Email: ${user!.email}'),
                          // Text('Foto: ${user.photoURL}'),
                        ],
                      );
                    } else {
                      return Text('Usuário não autenticado');
                    }
                  }
                },
              ),
              
            ),
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
