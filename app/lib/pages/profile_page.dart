import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseStorage storage = FirebaseStorage.instance;
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
            ElevatedButton.icon(onPressed: pickAndUploadImage, icon: Icon(Icons.upload), label: Text('Enviar imagem')),
            SizedBox(height: 50),
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
  Future<XFile?> getImage() async{
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  }
  Future<void> upload(String path) async{
    File file = File(path);
    try{
      String ref = 'image/img-${DateTime.now().toString()}.jpg';
      await storage.ref(ref).putFile(file);
    } on FirebaseException catch(e){
      throw Exception("Erro no upload: ${e.code}");
    }
  }
  pickAndUploadImage() async{
    XFile? file = await getImage();
    if(file != null){
      await upload(file.path);
    }
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<FirebaseStorage>('storage', storage));
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
