import 'dart:convert';
import 'package:app/pages/ver_acesso.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class AccessPage extends StatefulWidget {
  const AccessPage({Key? key}) : super(key: key);

  @override
  State<AccessPage> createState() => _AccessPageState();
}

class _AccessPageState extends State<AccessPage> {
  List<DogBreed> breeds = [];
  String sortBy = 'Recentes';
  String filterBy = 'Suas';
  int? userCredential;
  bool isLoading = false; // Adicionado

  @override
  void initState() {
    super.initState();
    fetchData();
    inicia();
  }

  Future<void> inicia() async {
    User? user = await FirebaseAuth.instance.authStateChanges().first;
    if (user != null) {
      String uid = user.uid;

      DatabaseReference starCountRef3 =
          FirebaseDatabase.instance.ref('users/$uid/credencial');
      starCountRef3.onValue.listen((DatabaseEvent event) {
        final data = event.snapshot.value;
        if (mounted) {
          setState(() {
            userCredential = data as int?;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    // Certifique-se de cancelar qualquer operação assíncrona ou animação aqui
    super.dispose();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true; // Define isLoading como true ao iniciar o carregamento
    });

    User? user = await FirebaseAuth.instance.authStateChanges().first;
    try {
      final response = await http.get(
        Uri.parse('https://api-labmaker-db7c20aa74d8.herokuapp.com/acessos'),
      );

      if (mounted) {
        print(response.body);
        if (response.statusCode == 200) {
          final Map<String, dynamic> data = json.decode(response.body);
          final List<dynamic> breedsList = data['acessos'];

          setState(() {
            breeds = breedsList
                .map((json) => DogBreed.fromJson(json))
                .where((breed) => breed.email == user?.email)
                .toList();
            isLoading = false; // Define isLoading como false após o carregamento
          });
        } else {
          throw Exception('Failed to load data');
        }
      }
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        isLoading = false; // Define isLoading como false se ocorrer um erro
      });
    }
  }

  Future<void> fetchDataForAllUsers() async {
  setState(() {
    isLoading = true;
  });

  try {
    final response = await http.get(
      Uri.parse('https://api-labmaker-db7c20aa74d8.herokuapp.com/acessos'),
    );

    if (mounted) {
      print(response.body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> breedsList = data['acessos'];

        setState(() {
          breeds = breedsList.map((json) => DogBreed.fromJson(json)).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    }
  } catch (e) {
    print('Error fetching data: $e');
    setState(() {
      isLoading = false;
    });
  }
}

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget getContent() {
      if (isLoading) {
        return Center(
          child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.green),), // Indicador de progresso circular
        );
      } else if (breeds.isEmpty) {
        return Center(
          child: Text(
            'Você não acessou o LabMaker ainda',
            style: TextStyle(fontSize: 16, color: Colors.black87),
          ),
        );
      } else {
        return ListView.builder(
          itemCount: breeds.length,
          itemBuilder: (context, index) {
            DateTime dateTime = DateTime.parse(breeds[index].createdAt);

            // Subtrair 3 horas
            dateTime = dateTime.subtract(Duration(hours: 3));

            String formattedDateTime = DateFormat('HH:mm').format(dateTime) +
                ' do dia ' +
                DateFormat('dd/MM/yyyy').format(dateTime);

            return Acessos(
                context,
                breeds[index].foto,
                breeds[index].nome,
                breeds[index].email,
                breeds[index].tipo,
                formattedDateTime);
          },
        );
      }
    }

    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Enfeites(),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Dropdown para ordenar
                Container(
                  width: 0.9 * MediaQuery.of(context).size.width,
                  height: 65,
                  child: DropdownButton<String>(
                    value: sortBy,
                    onChanged: (value) {
                      setState(() {
                        sortBy = value!;
                      });
                    },
                    items: ['Recentes', 'Antigas'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    icon: Icon(Icons.arrow_drop_down,
                        color: Colors.black), // Adicione esta linha para personalizar o ícone
                    isExpanded: true,
                  ),
                ),
                if (userCredential == 1)
                  Container(
  width: 0.9 * MediaQuery.of(context).size.width,
  height: 65,
  child: DropdownButton<String>(
    value: filterBy,
    onChanged: (value) {
      setState(() {
        filterBy = value!;
        if (filterBy == 'Todo mundo') {
          fetchDataForAllUsers();
        } else {
          fetchData(); // Chama fetchData se outra opção for selecionada
        }
      });
    },
    items: ['Suas', 'Todo mundo'].map((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList(),
    icon: Icon(Icons.arrow_drop_down, color: Colors.black),
    isExpanded: true,
  ),
),

              ],
            ),
            Expanded(
              child: getContent(),
            ),
          ],
        ),
      ),
    );
  }
}

class DogBreed {
  final int? id; // Altere para int?
  final String nome;
  final String email;
  final String foto;
  final String createdAt;
  final String tipo;

  DogBreed({
    required this.id,
    required this.nome,
    required this.email,
    required this.foto,
    required this.createdAt,
    required this.tipo,
  });

  factory DogBreed.fromJson(Map<String, dynamic> json) {
    return DogBreed(
        id: json['id'] as int?,
        nome: json['nome'] as String,
        email: json['email'] as String,
        foto: json['foto'] as String,
        createdAt: json['createdAt'] as String? ?? '',
        tipo: json['tipo'] as String);
  }
}

@override
Widget Enfeites() {
  return SingleChildScrollView(
      child: Column(mainAxisAlignment: MainAxisAlignment.center // Centraliza verticalmente
          ,
          children: [
        SizedBox(height: 35),
        Center(
          child: Image.asset("assets/imagens/labmaker-navbar2.jpg"),
        ),
        Divider(
          height: 1,
          color: Colors.grey,
        ),
        Center(
          child: RichText(
            text: TextSpan(
              text: 'Seus acessos ao LabMaker',
              style: GoogleFonts.oswald(
                textStyle: TextStyle(
                  color: Color.fromARGB(255, 36, 64, 25),
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 11),
      ]));
}

Widget Acessos(BuildContext context, String imagem, String nome, String vinculo,
    String estado, String hora) {
  return Container(
    margin: EdgeInsets.all(8),
    padding: EdgeInsets.all(8),
    width: MediaQuery.of(context).size.width,
    child: Wrap(
      alignment: WrapAlignment.start,
      children: [
        ClipOval(
          child: Image.network(
            imagem,
            width: 40.0, // ajuste o tamanho conforme necessário
            height: 40.0, // ajuste o tamanho conforme necessário
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: 10),
        Container(
          width: 0.55 * MediaQuery.of(context).size.width,
          child: // Espaçamento entre a imagem e o texto
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
                  color: const Color.fromARGB(255, 118, 118, 118),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(children: [
                Text(
                  estado,
                  style: GoogleFonts.oswald(
                    color: estado == 'Entrou' ? Colors.green[800] : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  ' às $hora',
                  style: GoogleFonts.oswald(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]),
              SizedBox(height: 10),
            ],
          ),
        ),
        Container(
          width: 0.2 * MediaQuery.of(context).size.width,
          height: 60,
          alignment: Alignment.centerRight,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            GestureDetector(
              onTap: () {
                // Navegar para a HomePage quando o ícone de perfil for clicado
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VerAcesso()),
                );
              },
              child: Icon(
                Icons.double_arrow_sharp,
                size: 35.0,
                color: Colors.green[800],
              ),
            ),
          ]),
        ),
        SizedBox(height: 5),
        Container(
          color: Colors.grey,
          width: MediaQuery.of(context).size.width,
          height: 1,
        )
      ],
    ),
  );
}
