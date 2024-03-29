import 'dart:convert';
import 'dart:ffi';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:mailer/mailer.dart';
import 'package:app/notification_controller.dart';
import 'package:app/services/firebase_message_service.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class Validation extends StatefulWidget {
  @override
  _ValidationState createState() => _ValidationState();
}

class _ValidationState extends State<Validation> {
  bool isLoading = false;
  late User? user;
  late String? photoURL;
  late String? nome;
  String? getEmail = null;
  // FirebaseMessaging fcm;
  String? getMatricula = null;
  late String agora;
  Future<String> _getHoraBrasil() async {
    tz.initializeTimeZones();
    final location = tz.getLocation('America/Sao_Paulo');
    final now = tz.TZDateTime.now(location);
    return DateFormat.jm().format(now);
  }

  int? credencial;

  @override
  void initState() {
    super.initState();
    // enviaNotificacao();
    
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:
            NotificationController.onNotificationCreateMethod,
        onNotificationDisplayedMethod:
            NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:
            NotificationController.onDismissActionReceivedMethod);
    user = FirebaseAuth.instance.currentUser;
    photoURL = user?.photoURL;
    nome = user?.displayName;
    _getHoraBrasil().then((hora) {
      setState(() {
        agora = hora;
      });
    });
    
    // onButtonPressed();
    // print(credencial);
// ignore: unrelated_type_equality_checks
  }
  
  sendEmail(BuildContext context, List<String> recipientEmails) async {
    String username = 'vinicioseufrazio3@gmail.com'; // Seu email
    String password = 'gmegrmmpwodgexkc'; // Sua senha

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'Labmaker')
      ..recipients.addAll(recipientEmails)
      // ..ccRecipients.addAll(['abc@gmail.com', 'xyz@gmail.com']) // Seus ccRecipients
      ..subject = 'Alguem fez uma nova solicitacao!'
      ..text =
          'Olá! Fizeram uma nova solicitação de acesso ao labmaker, abra o app e confira.';

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Email enviado com sucesso")));
    } on MailerException catch (e) {
      print('Message not sent.');
      print(e.message);
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  Future<List<String>> getEmailsFromFirestore() async {
  List<String> emails = [];
  try {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("validações").get();
    querySnapshot.docs.forEach((doc) {
      // Verifique se o campo 'credencial' é igual a 1 antes de adicionar o email à lista
      if (doc['credencial'] == 1) {
        emails.add(doc['email']);
      }
    });
  } catch (e) {
    print("Erro ao obter emails: $e");
  }
  return emails;
}
  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        title: 'Labmaker',
        body: 'Alguem fez uma solicitação, vem conferir!',
      ),
    );
    print("Handling a background message: ${message.messageId}");
  }

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
  RegExp alunoRegex =
      RegExp(r'^[a-zA-Z0-9_.+-]+\.[a-zA-Z0-9_.+-]+@aluno\.ifsertao-pe\.edu\.br$');
  RegExp professorRegex =
      RegExp(r'^[a-zA-Z0-9_.+-]+\.[a-zA-Z0-9_.+-]+@ifsertao-pe\.edu\.br$');

  if (getMatricula == null ||
      user?.email == null ||
      (!alunoRegex.hasMatch(user!.email!) &&
          !professorRegex.hasMatch(user!.email!))) {
    setState(() {
      exibirMensagem = true;
    });

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
    Random random = new Random();
    int idBiometria = random.nextInt(100) + 1;

    Map<String, dynamic> validacao = {
      "email": user?.email, // Adicione o email do usuário aqui
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
      "foto": photoURL,
      "nome": nome,
      "hora": agora,
      "idBiometria": idBiometria,
      "credencial": 0,
      "uid": user?.uid,
    };

    documentReference.set(validacao).whenComplete(() async {
      User? user = FirebaseAuth.instance.currentUser;
      String uid = user!.uid;

      DatabaseReference userRef =
          FirebaseDatabase.instance.reference().child('users').child(uid);
      userRef.update({
        'solicitou': true,
        'matricula': getMatricula,
        'vinculo': selectedValueVinculo,
        'curso': selectedValueCurso,
        'tempo': selectedValuePeriodo,
        'tipoCurso': selectedValueTipo,
      });

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Sucesso'),
            content: Text('A solicitação foi enviada com sucesso.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Fecha o AlertDialog
                  Navigator.of(context).pushReplacementNamed('/home');
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
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_circle_left_outlined, size: 40),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "SOLICITAR ACESSO",
            style: GoogleFonts.oswald(
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 255, 255, 255)),
          ),
          backgroundColor: Colors.green[800],
          shadowColor: Colors.white,
          iconTheme:
              IconThemeData(color: const Color.fromARGB(255, 255, 255, 255)),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40),
              Container(
                alignment: Alignment.center,
              ),
              Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'E-mail Institucional:',
                        style: GoogleFonts.oswald(
                          fontSize: 16,
                          color: Colors.green[800],
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: 0.9 * MediaQuery.of(context).size.width,
                        child: TextFormField(
                          onChanged: (String email) {
                            pegarEmail(email);
                          },
                          initialValue: user?.email,
                          enabled: false,
                          decoration: InputDecoration(
                            hintText: user?.email,
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 117, 115, 115)),
                            filled: true,
                            fillColor: Color.fromARGB(255, 238, 244, 236),
                            labelStyle: GoogleFonts.oswald(
                              fontWeight: FontWeight.bold,
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
                        style: GoogleFonts.oswald(
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
                              color: Color.fromARGB(255, 117, 115, 115),
                            ),
                            filled: true,
                            fillColor: Color.fromARGB(255, 238, 244, 236),
                            labelStyle: GoogleFonts.oswald(
                              fontWeight: FontWeight.bold,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          keyboardType: TextInputType.number, // Defina o tipo de entrada como numérico
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly // Permita apenas dígitos
                          ],
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
                        style: GoogleFonts.oswald(
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
                          style: GoogleFonts.oswald(
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
                            'Voluntário',
                            'Estagiário'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  value,
                                  style: GoogleFonts.oswald(
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
                          style: GoogleFonts.oswald(
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
                            style: GoogleFonts.oswald(
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
                                  style: GoogleFonts.oswald(
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
                          style: GoogleFonts.oswald(
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
                            style: GoogleFonts.oswald(
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
                          style: GoogleFonts.oswald(
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
                            style: GoogleFonts.oswald(
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
                                    style: GoogleFonts.oswald(
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
                      style: GoogleFonts.oswald(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  SizedBox(height: 20),
                  Container(
                    width: 0.9 * MediaQuery.of(context).size.width,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        // enviaNotificacao();
                        setState(() {
                          isLoading = true;
                        });
                        // await _firebaseMessagingBackgroundHandler(RemoteMessage());
                        List<String> recipientEmails = await getEmailsFromFirestore();
                        await sendEmail(context, recipientEmails);
                        await FirebaseMessage().initNotifications();
                        
                        enviarValidacao();
                        setState(() {
                          isLoading = true;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green[800],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: isLoading ? CircularProgressIndicator(color: Colors.white,) : Text(
                        'Enviar',
                        style: GoogleFonts.oswald(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
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


