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
          "VALIDAÇÕES",
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

          return ListView(
  children: snapshot.data!.docs.map((DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    String email = data['email'];
    String matricula = data['matricula'];
    String vinculo = data['vinculo']['tipoVinculo'];

    return ListTile(
      contentPadding: EdgeInsets.all(8),
      leading: CircleAvatar(
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
        "Autorizar",
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'oswlad',
          fontWeight: FontWeight.bold,
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
