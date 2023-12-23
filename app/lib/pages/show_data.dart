import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
          style: TextStyle(
              fontFamily: 'oswald',
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
              String matricula = data['matricula'];
              String vinculo = data['vinculo']['tipoVinculo'];
              String? foto = data['foto'] as String?;
              return Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color.fromARGB(120, 225, 244, 203),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(0),
                  leading: CircleAvatar(
                    backgroundImage: foto != null ? NetworkImage(foto) : null,
                    radius: 50,
                    backgroundColor: Colors.green[800],
                  ),
                  title: Text(email),
                  subtitle: Text("$vinculo - $matricula"),
                  trailing: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Container(
                      alignment: Alignment.center,
                      width: 100,
                      height: 35,
                      color: Colors.green[800],
                      child: Text(
                        "Aprovar",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'oswlad',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      
                    ),
                  ),
                ),
              );
            }).toList(),
          );

        },
      ),
    );
  }
}
