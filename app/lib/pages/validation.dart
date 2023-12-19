import 'package:app/pages/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// ignore: depend_on_referenced_packages
import 'package:fluttertoast/fluttertoast.dart';

class Validation extends StatefulWidget {
  @override
  _ValidationState createState() => _ValidationState();
}

class _ValidationState extends State<Validation> {
  String? getEmail = null;
  String? getMatricula = null;

  pegarEmail(email) {
    this.getEmail = email;
  }

  pegarMatricula(matricula) {
    this.getMatricula = matricula;
  }

  String? selectedValueVinculo = null;
  String? selectedValueTipo;
  String? selectedValueCurso;
  String? selectedValuePeriodo;
  bool exibirMensagem = false;

  List<String> tiposPorVinculo = ['Médio Integrado', 'Subsequente', 'Superior'];

  List<String> cursosMedioIntegrado = [
    'Informática',
    'Agropecuária',
    'Edificações'
  ];
  List<String> cursosSubsequente = ['Edificações', 'Agropecuária'];
  List<String> cursosSuperior = [
    'Sistemas para Internet',
    'Alimentos',
    'Física'
  ];

  List<String> periodosMedioIntegrado = ['1º ano', '2º ano', '3º ano'];
  List<String> periodosProejaFisica = [
    '1º período',
    '2º período',
    '3º período',
    '4º período',
    '5º período',
    '6º período',
    '7º período',
    '8º período'
  ];
  List<String> periodosSubsequente = [
    '1º período',
    '2º período',
    '3º período',
    '4º período'
  ];
  List<String> periodosSuperiorSistemasAlimentos = [
    '1º período',
    '2º período',
    '3º período',
    '4º período',
    '5º período',
    '6º período'
  ];


void enviarValidacao() {
  RegExp alunoRegex = RegExp(r'^[a-zA-Z]+\.[a-zA-Z]+@aluno\.ifsertao-pe\.edu\.br$');
  RegExp professorRegex = RegExp(r'^[a-zA-Z]+\.[a-zA-Z]+@ifsertao-pe\.edu\.br$');

  if (getMatricula == null ||
      getEmail == null ||
      (!alunoRegex.hasMatch(getEmail!) && !professorRegex.hasMatch(getEmail!))) {
    setState(() {
      exibirMensagem = true;
    });
    print("Número de matrícula ou e-mail inválido");

    // Mostra um Toast para alertar o usuário sobre o erro
    Fluttertoast.showToast(
      msg: "Número de matrícula ou e-mail inválido",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  } else {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection("validações")
        .doc(getMatricula!);

    Map<String, dynamic> validacao = {
      "email": getEmail,
      "matricula": getMatricula,
      "aguardando": true,
      "autorizado": false,
      "negado": false,
      "vinculo": {
        "curso": selectedValueCurso,
        "tempo": selectedValuePeriodo,
        "tipoCurso": selectedValueTipo,
        "tipoVinculo": selectedValueVinculo,
      },
    };

    documentReference.set(validacao).whenComplete(() {
      // Mostra um AlertDialog e redireciona para a HomePage quando o processo estiver completo
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Sucesso'),
            content: Text('A validação foi enviada com sucesso.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Fecha o AlertDialog
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40),
              Container(
                alignment: Alignment.center,
                child: Text(
                  'SOLICITAR ACESSO',
                  style: GoogleFonts.oswald(
                    textStyle: TextStyle(
                      color: Colors.green[800],
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'E-mail Institucional:',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.green[800],
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: 0.9 * MediaQuery.of(context).size.width,
                        child: TextField(
                          onChanged: (String email) {
                            pegarEmail(email);
                          },
                          decoration: InputDecoration(
                            hintText: "nome.sobrenome@aluno.ifsertao-pe.edu.br",
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 117, 115, 115)),
                            filled: true,
                            fillColor: Color.fromARGB(255, 238, 244, 236),
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'oswald',
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Número Matrícula:',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.green[800],
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: 0.9 * MediaQuery.of(context).size.width,
                        child: TextField(
                          onChanged: (String matricula) {
                            pegarMatricula(matricula);
                          },
                          decoration: InputDecoration(
                            hintText: "202300000000",
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 117, 115, 115)),
                            filled: true,
                            fillColor: Color.fromARGB(255, 238, 244, 236),
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'oswald',
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Vínculo:',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.green[800],
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: 0.9 * MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color.fromARGB(255, 238, 244, 236)),
                        child: DropdownButton<String>(
                          padding: EdgeInsets.all(8.0),
                          underline: Container(),
                          value: selectedValueVinculo,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedValueVinculo = newValue!;
                              selectedValueTipo = null;
                              selectedValueCurso = null;
                              selectedValuePeriodo = null;
                            });
                          },
                          style: TextStyle(
                              color: Color.fromARGB(255, 238, 244, 236),
                              fontSize: 16),
                          icon: Icon(Icons.arrow_drop_down,
                              color: Color.fromARGB(255, 117, 115, 115)),
                          elevation: 2, // Ajuste o valor conforme necessário
                          dropdownColor: Color.fromARGB(255, 238, 244, 236),
                          items: [
                            'Estudante',
                            'Professor',
                            'Bolsista',
                            'Estagiário'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  value,
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 117, 115, 115),
                                      fontSize: 16),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  if (selectedValueVinculo != 'Professor')
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tipo de Curso:',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.green[800],
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          width: 0.9 * MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color.fromARGB(255, 238, 244, 236)),
                          child: DropdownButton<String>(
                            padding: EdgeInsets.all(8.0),
                            value: selectedValueTipo,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedValueTipo = newValue!;
                                selectedValueCurso = null;
                                selectedValuePeriodo = null;
                              });
                            },
                            style: TextStyle(
                                color: Color.fromARGB(255, 238, 244, 236),
                                fontSize: 16),
                            icon: Icon(Icons.arrow_drop_down,
                                color: Color.fromARGB(255, 117, 115, 115)),
                            underline: Container(),
                            elevation: 2, // Ajuste o valor conforme necessário
                            dropdownColor: Color.fromARGB(255, 238, 244, 236),
                            items: tiposPorVinculo
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 117, 115, 115),
                                      fontSize: 16),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  if (selectedValueTipo != null &&
                      (selectedValueTipo == 'Médio Integrado' ||
                          selectedValueTipo == 'Subsequente' ||
                          selectedValueTipo == 'Superior'))
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Curso:',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.green[800],
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          width: 0.9 * MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color.fromARGB(255, 238, 244, 236)),
                          child: DropdownButton<String>(
                            padding: EdgeInsets.all(8.0),
                            value: selectedValueCurso,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedValueCurso = newValue!;
                                selectedValuePeriodo = null;
                              });
                            },
                            style: TextStyle(
                                color: Color.fromARGB(255, 238, 244, 236),
                                fontSize: 16),
                            icon: Icon(Icons.arrow_drop_down,
                                color: Color.fromARGB(255, 117, 115, 115)),
                            underline: Container(),
                            elevation: 2, // Ajuste o valor conforme necessário
                            dropdownColor: Color.fromARGB(255, 238, 244, 236),
                            items: (selectedValueTipo == 'Médio Integrado'
                                    ? cursosMedioIntegrado
                                    : selectedValueTipo == 'Subsequente'
                                        ? cursosSubsequente
                                        : cursosSuperior)
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 117, 115, 115),
                                      fontSize: 16),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  if (selectedValueCurso != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Período/Ano',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.green[800],
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          width: 0.9 * MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color.fromARGB(255, 238, 244, 236)),
                          child: DropdownButton<String>(
                            padding: EdgeInsets.all(8.0),
                            value: selectedValuePeriodo,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedValuePeriodo = newValue!;
                              });
                            },
                            style: TextStyle(
                                color: Color.fromARGB(255, 238, 244, 236),
                                fontSize: 16),
                            icon: Icon(Icons.arrow_drop_down,
                                color: Color.fromARGB(255, 117, 115, 115)),
                            underline: Container(),
                            elevation: 2, // Ajuste o valor conforme necessário
                            dropdownColor: Color.fromARGB(255, 238, 244, 236),
                            items: (selectedValueTipo == 'Médio Integrado'
                                    ? periodosMedioIntegrado
                                    : selectedValueTipo == 'Subsequente'
                                        ? periodosSubsequente
                                        : selectedValueCurso == 'Física'
                                            ? periodosProejaFisica
                                            : periodosSuperiorSistemasAlimentos)
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 117, 115, 115),
                                        fontSize: 16)),
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  SizedBox(height: 20),
                  if (exibirMensagem)
                      Text(
                        'Matrícula ou E-mail inválido',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'oswald',
                        ),
                      ),
                  SizedBox(height: 20),
                  Container(
                    width: 0.9 * MediaQuery.of(context).size.width,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        enviarValidacao();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green[800],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'Enviar',
                        style: GoogleFonts.oswald(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
