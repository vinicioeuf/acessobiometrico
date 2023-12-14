import 'package:app/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Validation extends StatefulWidget {
  @override
  _ValidationState createState() => _ValidationState();
}

class _ValidationState extends State<Validation> {
  String selectedValueVinculo = 'Professor';
  String? selectedValueTipo;
  String? selectedValueCurso;
  String? selectedValuePeriodo;

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
                  Container(
                    width: 0.9 * MediaQuery.of(context).size.width,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // Adicione aqui a lógica para processar e enviar as informações
                        // Pode chamar uma função para isso.
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
