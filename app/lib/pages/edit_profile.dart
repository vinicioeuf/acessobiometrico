import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late User? _user;
  String _name = '';
  String? _imagePath;
  final ImagePicker _picker = ImagePicker();
  bool _isSaving = false; // Flag para indicar se está salvando

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  void _getUserData() {
    _user = FirebaseAuth.instance.currentUser;
    _name = _user?.displayName ?? '';
  }

  void _updateName(String newName) {
    setState(() {
      _name = newName;
    });
  }

  Future<void> _pickImage() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imagePath = image.path;
      });
    }
  }

  Future<void> _uploadImage() async {
  if (_imagePath != null) {
    setState(() {
      _isSaving = true; // Inicia o indicador de progresso
    });

    String imageUrl = await upload(_imagePath!);

    if (imageUrl.isNotEmpty) {
      await _user?.updatePhotoURL(imageUrl);
    }

    setState(() {
      _isSaving = false; // Finaliza o indicador de progresso
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        leading: IconButton(
          icon: Icon(Icons.arrow_circle_left_outlined, size: 40, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Editar Perfil', style: GoogleFonts.oswald(
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 255, 255, 255)),),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: _user?.photoURL != null
                        ? NetworkImage(_user!.photoURL!)
                        : NetworkImage(_user?.photoURL ?? '')
                            as ImageProvider<Object>,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10), // Espaço entre a imagem e o nome do usuário
            Text(
              _name,
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            TextField(
      decoration: InputDecoration(
        labelText: 'Nome',
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green[700]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green[700]!),
        ),
      ),
      onChanged: (value) {
        _updateName(value);
      },
      // controller: TextEditingController(text: _name),
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.green[700],
    ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
  setState(() {
    _isSaving = true; // Ativar indicador de progresso
  });

  if (_imagePath != null) {
    await _uploadImage();
  }

  await _user?.updateDisplayName(_name);

  String uid = _user!.uid;
  DatabaseReference newUserRef = ref.child(uid);

  await newUserRef.update({
    "nome": _name,
    "foto": _user?.photoURL,
  });

  setState(() {
    _isSaving = false; // Desativar indicador de progresso
  });

                // Mostra o AlertDialog
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Sucesso'),
                      content: Text('Alterações salvas com sucesso!'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green[700], // Cor de fundo do botão
                minimumSize: Size(double.infinity, 50),
              ),
              child: _isSaving
                  ? CircularProgressIndicator(
                      color: Colors.white) // Mostrar indicador de progresso
                  : Text(
                      'SALVAR ALTERAÇÕES',
                      style:
                          TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold,),
                           // Cor do texto branco
                    ),
            ),
            // if (_isSaving)
            // Mostra o indicador de progresso se estiver salvando
          ],
        ),
      ),
    );
  }

  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref('users');
  final FirebaseStorage storage = FirebaseStorage.instance;
  Future<XFile?> getImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  Future<String> upload(String path) async {
    File file = File(path);
    try {
      String ref = 'image/img-${DateTime.now().toString()}.jpg';
      await storage.ref(ref).putFile(file);
      String imageUrl = await storage.ref(ref).getDownloadURL();
      return imageUrl;
    } on FirebaseException catch (e) {
      throw Exception("Erro no upload: ${e.code}");
    }
  }

  Future<String?> pickAndUploadImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('images/${DateTime.now().millisecondsSinceEpoch}');
      UploadTask uploadTask = storageReference.putFile(File(image.path));
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      String imageUrl = await taskSnapshot.ref.getDownloadURL();
      return imageUrl;
    }
    return null;
  }
}
