import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Validation extends StatefulWidget {
  @override
  _ValidationState createState() => _ValidationState();
}

class _ValidationState extends State<Validation> {
  String selectedValueVinculo = 'Estudante';
  String? selectedValueTipo;
  String? selectedValueCurso;
  String? selectedValuePeriodo;

  List<String> tiposPorVinculo = ['Médio Integrado', 'Subsequente', 'Proeja', 'Superior'];

  List<String> cursosMedioIntegrado = ['Informática', 'Agropecuária', 'Edificações'];
  List<String> cursosSubsequente = ['Edificações', 'Agropecuária'];
  List<String> cursosSuperior = ['Sistemas para Internet', 'Alimentos', 'Física'];

  List<String> periodosMedioIntegrado = ['1º ano', '2º ano', '3º ano'];
  List<String> periodosProejaFisica = ['1º período', '2º período', '3º período', '4º período', '5º período', '6º período', '7º período', '8º período'];
  List<String> periodosSubsequente = ['1º período', '2º período', '3º período', '4º período'];
  List<String> periodosSuperiorSistemasAlimentos = ['1º período', '2º período', '3º período', '4º período', '5º período', '6º período'];

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
                      color: Color.fromARGB(255, 61, 96, 47),
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Container(
                width: 0.7 * MediaQuery.of(context).size.width,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'E-mail Institucional',
                    filled: true,
                    fillColor: Color.fromARGB(255, 238, 244, 236),
                    labelStyle: TextStyle(
                      color: Colors.green[800],
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
              SizedBox(height: 10),
              Container(
                width: 0.7 * MediaQuery.of(context).size.width,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Nº Matrícula',
                    filled: true,
                    fillColor: Color.fromARGB(255, 238, 244, 236),
                    labelStyle: TextStyle(
                      color: Colors.green[800],
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
              SizedBox(height: 10),
              Container(
                width: 0.7 * MediaQuery.of(context).size.width,
                child: DropdownButton<String>(
                  value: selectedValueVinculo,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValueVinculo = newValue!;
                      selectedValueTipo = null;
                      selectedValueCurso = null;
                      selectedValuePeriodo = null;
                    });
                  },
                  items: ['Estudante', 'Professor', 'Bolsista', 'Estagiário']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              if (selectedValueVinculo == 'Estudante' ||
                  selectedValueVinculo == 'Estagiário' ||
                  selectedValueVinculo == 'Bolsista')
                Container(
                  width: 0.7 * MediaQuery.of(context).size.width,
                  child: DropdownButton<String>(
                    value: selectedValueTipo,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValueTipo = newValue!;
                        selectedValueCurso = null;
                        selectedValuePeriodo = null;
                      });
                    },
                    items: tiposPorVinculo
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              if (selectedValueTipo != null &&
                  (selectedValueTipo == 'Médio Integrado' ||
                      selectedValueTipo == 'Subsequente' ||
                      selectedValueTipo == 'Superior'))
                Container(
                  width: 0.7 * MediaQuery.of(context).size.width,
                  child: DropdownButton<String>(
                    value: selectedValueCurso,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValueCurso = newValue!;
                        selectedValuePeriodo = null;
                      });
                    },
                    items: (selectedValueTipo == 'Médio Integrado'
                            ? cursosMedioIntegrado
                            : selectedValueTipo == 'Subsequente'
                                ? cursosSubsequente
                                : cursosSuperior)
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              if (selectedValueCurso != null)
                Container(
                  width: 0.7 * MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 0.3 * MediaQuery.of(context).size.width,
                        child: DropdownButton<String>(
                          value: selectedValuePeriodo,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedValuePeriodo = newValue!;
                            });
                          },
                          items: (selectedValueTipo == 'Médio Integrado'
                              ? periodosMedioIntegrado
                              : selectedValueTipo == 'Subsequente'
                                  ? periodosSubsequente
                                  : selectedValueTipo == 'Proeja' || selectedValueCurso == 'Física'
                                  ? periodosProejaFisica 
                                  : periodosSuperiorSistemasAlimentos )
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
