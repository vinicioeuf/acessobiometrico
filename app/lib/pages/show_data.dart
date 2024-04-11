import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;

class ValidacoesScreen extends StatefulWidget {
  @override
  _ValidacoesScreenState createState() => _ValidacoesScreenState();
}

class _ValidacoesScreenState extends State<ValidacoesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          
          leading: IconButton(
            icon: Icon(Icons.arrow_circle_left_outlined, size: 40),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "SOLICITAÇÕES",
            style: GoogleFonts.oswald(
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 255, 255, 255)),
          ),
          backgroundColor: Colors.green[800],
          shadowColor: Colors.white,
          iconTheme: IconThemeData(color: const Color.fromARGB(255, 255, 255, 255)),
        ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('validações').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Erro: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.green[800],
              ),
            );
          }

          // return MaterialApp(
          //   home: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Container(
          //         width: MediaQuery.of(context).size.width * 0.9,
          //         height: 110,
          //         decoration: BoxDecoration(
          //           color: Colors.blue,
          //           borderRadius: BorderRadius.circular(10),
          //         ),
          //       ),
          //     ],
          //   ),
          // );
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                document.data() as Map<String, dynamic>;
              String email = data['email'];
              String hora = data['hora'];
              String nome = data['nome'];
              bool aguardando = data['aguardando'];
              int idBiometria = data['idBiometria'];
              // bool autorizado = data['autorizado'];
              // bool negado = data['negado'];
              // String matricula = data['matricula'];
              String? vinculo = data['vinculo']['tipoVinculo'];
              String? tempo = data['vinculo']['tempo'];
              String? curso = data['vinculo']['curso'];
              String? foto = data['foto'] as String?;
              if (aguardando) {
                return Container(
                width: 0.9 * MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color.fromARGB(100, 225, 244, 203),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 0.6 * MediaQuery.of(context).size.width,
                          child:
                       Wrap(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  foto != null ? NetworkImage(foto) : null,
                              radius: 25,
                              backgroundColor: Colors.green[800],
                            ),
                            SizedBox(
                                width:
                                    10), // Espaçamento entre a imagem e o texto
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
                                  vinculo!,
                                  style: GoogleFonts.oswald(
                                    color: Colors.green[800],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: 0.6 * MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (tempo != null && curso != null)
                                Container(
                                  width: 0.6 * MediaQuery.of(context).size.width,
                                  constraints: BoxConstraints(maxWidth: 300),
                                  child: Text(
                                    'Curso: $tempo $curso',
                                    style: GoogleFonts.oswald(),
                                  ),
                                ),
                              Container(
                                width: 0.6 * MediaQuery.of(context).size.width,
                                constraints: BoxConstraints(
                                    maxWidth: 300), // Define um máximo de 200 de largura
                                child: Text(
                                  'E-mail: $email',
                                  style: GoogleFonts.oswald(),
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "$hora  ",
                            style: GoogleFonts.oswald(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () async {
                              FirebaseFirestore.instance.collection('validações').doc(document.id).update({
                                'autorizado': true,
                                'aguardando': false,
                              });
                              User? user = FirebaseAuth.instance.currentUser;
                              String uid = user!.uid;
                              // ignore: deprecated_member_use
                              DatabaseReference userRef = FirebaseDatabase.instance.reference().child('users').child(uid);
                              userRef.update({
                                'aprovado': true,
                              });
                              try {
                                final response = await http.post(
                                  Uri.parse(
                                      "https://api-labmaker.onrender.com/addusuarios"),
                                  headers: <String, String>{
                                    'Content-Type': 'application/json; charset=UTF-8',
                                  },
                                  body: jsonEncode(<String, dynamic>{
                                    "nome": nome.toString(),
                                    "email": email.toString(),
                                    "idBiometria": idBiometria.toInt(),
                                    "foto": foto.toString(),
                                    "status": "Ativo"
                                  }),
                                );

                                // Verifique se a requisição foi bem-sucedida
                                if (response.statusCode == 200) {
                                  print('Requisição POST bem-sucedida');
                                } else {
                                  print(
                                      'Erro na requisição POST. Código de status: ${response.statusCode}');
                                }
                              } catch (error) {
                                print('Erro ao enviar requisição POST: $error');
                              }
                              showDialog(
                                context: context,
                                barrierDismissible: false, 
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Solicitação aprovada!'),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Ok'),
                                        onPressed: () {
                                          Navigator.of(context).pushReplacementNamed('/home'); // Substitui a rota da página atual pela página de login
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green[800],
                              onPrimary: Colors.white, // Cor do texto
                              textStyle: GoogleFonts.oswald(
                                fontWeight: FontWeight.bold,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Text('Aprovar'),
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () async{
                              FirebaseFirestore.instance.collection('validações').doc(document.id).update({
                                'negado': true,
                                'aguardando': false,
                              });
                              User? user = FirebaseAuth.instance.currentUser;
                              String uid = user!.uid;
                              // ignore: deprecated_member_use
                              DatabaseReference userRef = FirebaseDatabase.instance.reference().child('users').child(uid);
                              userRef.update({
                                'negado': true,
                              });
                              showDialog(
                                context: context,
                                barrierDismissible: false, 
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Solicitação negada!'),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Ok'),
                                        onPressed: () {
                                          Navigator.of(context).pushReplacementNamed('/home'); // Substitui a rota da página atual pela página de login
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red[800],
                              onPrimary: Colors.white, // Cor do texto
                              textStyle: GoogleFonts.oswald(
                                fontWeight: FontWeight.bold,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Text(' Negar  '),
                          ),
                        ],
              
                      ),
                    ),
                  ],
                ),
              );
              } else {
                return Container(
                  alignment: Alignment.center,
                  child: Text(""),
                );
              }
              
            }).toList(),
          );
        },
      ),
    );
  }
}
