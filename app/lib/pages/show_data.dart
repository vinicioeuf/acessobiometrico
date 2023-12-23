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
              fontWeight: FontWeight.bold,
              color: Colors.green[800]),
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
              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
              String email = data['email'];
              String nome = data['nome'];
              String matricula = data['matricula'];
              String vinculo = data['vinculo']['tipoVinculo'];
              String tempo = data['vinculo']['tempo'];
              String curso = data['vinculo']['curso'];
              String? foto = data['foto'] as String?;
              return Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color.fromARGB(100, 225, 244, 203),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start, // Alinha os elementos ao topo
                  children: [
                    CircleAvatar(
                      backgroundImage: foto != null ? NetworkImage(foto) : null,
                      radius: 25,
                      backgroundColor: Colors.green[800],
                    ),
                    SizedBox(width: 10), // Espaçamento entre a imagem e o texto
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
                        SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              constraints: BoxConstraints(maxWidth: 200),
                              child: Text(
                                'Curso: $tempo $curso',
                                style: GoogleFonts.oswald(),
                              ),
                            ),
                            Container(
                              constraints: BoxConstraints(maxWidth: 200), // Define um máximo de 200 de largura
                              child: Text(
                                'E-mail: $email',
                                style: GoogleFonts.oswald(),
                              ),
                            ),
                          ],
                        ),
                        
                      ],
                    ),
                    Spacer(), // Empurra o botão para a extremidade direita
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "10:32PM  ",
                          style: GoogleFonts.oswald(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: () {
                            // Lógica para aprovar
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green[800],
                            onPrimary: Colors.white, // Cor do texto
                            textStyle: GoogleFonts.oswald(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          child: Text('Aprovar'),
                        ),
                        SizedBox(height: 2), // Espaçamento entre os botões
                        ElevatedButton(
                          onPressed: () {
                            // Lógica para negar
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red[800],
                            onPrimary: Colors.white, // Cor do texto
                            textStyle: GoogleFonts.oswald(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          child: Text(' Negar  '),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          );

        },
      ),
    );
  }
}
