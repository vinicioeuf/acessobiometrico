import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class ValidacoesScreen extends StatefulWidget {
  @override
  _ValidacoesScreenState createState() => _ValidacoesScreenState();
}

class _ValidacoesScreenState extends State<ValidacoesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "SOLICITAÇÕES",
          style: GoogleFonts.oswald(
              fontWeight: FontWeight.bold, color: Colors.green[800]),
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.green[800]),
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
              bool autorizado = data['autorizado'];
              bool negado = data['negado'];
              String matricula = data['matricula'];
              String vinculo = data['vinculo']['tipoVinculo'];
              String tempo = data['vinculo']['tempo'];
              String curso = data['vinculo']['curso'];
              String? foto = data['foto'] as String?;
              if (aguardando) {
                return Container(
                width: 0.9 * MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(1),
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Color.fromARGB(100, 225, 244, 203),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
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
                                  vinculo,
                                  style: GoogleFonts.oswald(
                                    color: Colors.green[800],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 0.6 * MediaQuery.of(context).size.width,
                              constraints: BoxConstraints(maxWidth: 200),
                              child: Text(
                                'Curso: $tempo $curso',
                                style: GoogleFonts.oswald(),
                              ),
                            ),
                            Container(
                              width: 0.6 * MediaQuery.of(context).size.width,
                              constraints: BoxConstraints(
                                  maxWidth:
                                      200), // Define um máximo de 200 de largura
                              child: Text(
                                'E-mail: $email',
                                style: GoogleFonts.oswald(),
                              ),
                            ),
                          ],
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
                            onPressed: () {
                              FirebaseFirestore.instance.collection('validações').doc(document.id).update({
                                'autorizado': true,
                                'aguardando': false,
                              });
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Solicitação aprovada!'),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Ok'),
                                        onPressed: () {
                                          Navigator.of(context).pushReplacementNamed('/show'); // Substitui a rota da página atual pela página de login
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
                            onPressed: () {
                              FirebaseFirestore.instance.collection('validações').doc(document.id).update({
                                'negado': true,
                                'aguardando': false,
                              });
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Solicitação negada!'),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Ok'),
                                        onPressed: () {
                                          Navigator.of(context).pushReplacementNamed('/show'); // Substitui a rota da página atual pela página de login
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
                return Container();
              }
              
            }).toList(),
          );
        },
      ),
    );
  }
}
