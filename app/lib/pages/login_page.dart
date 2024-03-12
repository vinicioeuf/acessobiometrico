import 'dart:io';
import 'package:app/pages/home_page.dart';
import 'package:app/services/auth_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref('users');
  final FirebaseStorage storage = FirebaseStorage.instance;
  
  bool _obscurePassword = true;
  final formKey = GlobalKey<FormState>();
  final nomeController = TextEditingController();
  final email = TextEditingController();
  final senha = TextEditingController();
  final foto = TextEditingController();
  bool isLogin = true;
  late String titulo;
  late String actionButton;
  late String toogleDesc;
  late String toogleButton;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    setFormAction(true);
    
  }

  setFormAction(bool acao) {
    setState(() {
      isLogin = acao; // Update isLogin based on the provided parameter

      if (isLogin) {
        titulo = "LOGIN";
        actionButton = "Entrar";
        toogleDesc = "Ainda não tem uma conta?";
        toogleButton = "Cadastre-se";
      } else {
        titulo = "CADASTRE-SE";
        actionButton = "Enviar";
        toogleDesc = "Já possui uma conta?";
        toogleButton = "Entrar";
      }
    });
  }

  
  login() async {
    final authService = AuthService();
    setState(() {
      loading = true;
    });
    try {
      
      await authService.login(email.text, senha.text);
      setState(() {
      });
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>HomePage()),(Route<dynamic> route) => false); // Substitui a rota da página atual pela página principal
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message),
      ));
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  registrar() async {
    setState(() {
      loading = true;
    });
    final authService = AuthService();
    try {
      await authService.registrar(nomeController.text, email.text, senha.text, foto.text);
      await authService.sendEmailVerification(); // Adicione esta linha
      showDialog(
        context: context,
        barrierDismissible: false, 
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Conta criada! Valide seu e-mail antes de fazer o login.'),
            actions: <Widget>[
              TextButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/login');
                },
              ),
            ],
          );
        },
      );
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message),
      ));
    } finally {
      setState(() {
        loading = false;
      });
    }

  }

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Image.asset("assets/imagens/labmaker-navbar2.jpg"),
            ),
            Divider(
              height: 1,
              color: Colors.grey,
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: titulo,
                        style: GoogleFonts.oswald(
                          textStyle: TextStyle(
                            color: Colors.green[800],
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  if (!isLogin)
                   // Condição para exibir o campo de input do nome apenas quando não estiver logando
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Nome',
                        filled: true,
                        fillColor: Color.fromARGB(255, 238, 244, 236),
                        labelStyle: TextStyle(
                          color: Colors.green[800],
                          fontWeight: FontWeight.bold,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      controller: nomeController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Informe seu nome";
                        }
                        return null;
                      },
                    ),
                  SizedBox(height: 30),
                  TextFormField(
                      decoration: InputDecoration(
                        labelText: 'E-mail',
                        filled: true,
                        fillColor: Color.fromARGB(255, 238, 244, 236),
                        labelStyle: TextStyle(
                          color: Colors.green[800],
                          fontWeight: FontWeight.bold,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Informe seu e-mail";
                        }
                        return null;
                      }),
                  SizedBox(height: 30),
                  TextFormField(
                      obscureText:
                          _obscurePassword, // Define a visibilidade da senha
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        filled: true,
                        fillColor: Color.fromARGB(255, 238, 244, 236),
                        labelStyle: TextStyle(
                          color: Colors.green[800],
                          fontWeight: FontWeight.bold,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.green[800],
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      controller: senha,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Informe sua senha";
                        } else if (value.length < 6) {
                          return "Senha fraca. Tente outra";
                        }
                        return null;
                      }),
                  
                  SizedBox(height: 30),
                  ElevatedButton(
                    // onPressed: () {
                    //     Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => HomePage()),
                    // );
                    //   },
                    onPressed: loading
                        ? null
                        : () {
                            if (formKey.currentState!.validate()) {
                              if (isLogin) {
                                login();
                              } else {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false, 
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Agora vamos escolher uma boa foto de perfil.'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text('Ok'),
                                          onPressed: () {
                                            registrar(); // Substitui a rota da página atual pela página de login
                                            
                                            Navigator.of(context).pop(); // Fecha o diálogo
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                                // registrar();
                              }
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      minimumSize: Size(double.infinity, 60),
                    ),
                    child: loading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text(
                          actionButton,
                          style: GoogleFonts.oswald(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(toogleDesc,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'oswald',
                              fontSize:
                                  0.04 * MediaQuery.of(context).size.width,
                              fontWeight: FontWeight.normal,
                            )),
                        TextButton(
                          onPressed: () => setFormAction(!isLogin),
                          child: Text(
                            toogleButton,
                            style: TextStyle(
                                color: Colors.green[800],
                                fontSize:
                                    0.04 * MediaQuery.of(context).size.width,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                ],
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
  Future<String?> pickAndUploadImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      Reference storageReference = FirebaseStorage.instance.ref().child('images/${DateTime.now().millisecondsSinceEpoch}');
      UploadTask uploadTask = storageReference.putFile(File(image.path));
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      String imageUrl = await taskSnapshot.ref.getDownloadURL();
      return imageUrl;
    }
    return null;
  }
}
