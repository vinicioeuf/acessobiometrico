import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddAdm extends StatefulWidget {
  const AddAdm({super.key});

  @override
  State<AddAdm> createState() => _AddAdmState();
}

class _AddAdmState extends State<AddAdm> {
  
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
            "ADICIONAR ADMINISTRADOR",
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
              int cred = data['credencial'];
              String documentName = data['uid'];
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
              if(cred != 1){
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
                    if(cred != 1)
                    
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
                    if(cred != 1)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                         
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () async {
                              DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
                    
                    // Atualize os dados no nó apropriado no Realtime Database
                              FirebaseFirestore.instance.collection('validações').doc(document.id).update({
                                'credencial': 1,
                              });

                              User? user = FirebaseAuth.instance.currentUser;
                              String uid = user!.uid;
                              // Atualize os dados do usuário no Realtime Database
                              print(documentName);
                              databaseReference.child('users').child(documentName).update({
                                'credencial': 1,
                              });

                              showDialog(
                                context: context,
                                barrierDismissible: false, 
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Este usuário agora é um administrador!'),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Ok'),
                                        onPressed: () {
                                          Navigator.of(context).pop(); // Substitui a rota da página atual pela página de login
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
                            child: Text('Permitir'),
                          ),
                          SizedBox(height: 10),
                        ],
              
                      ),
                    ),
                  ],
                ),
              );
              }else{
                return Container();
              }
              
            }).toList(),
          );
        },
      ),
    );
  }
}
