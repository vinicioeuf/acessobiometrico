import 'package:app/pages/addadm.dart';
import 'package:app/pages/edit_profile.dart';
import 'package:app/pages/login_page.dart';
import 'package:app/pages/show_data.dart';
import 'package:app/pages/teste.dart';
import 'package:app/pages/teste2.dart';
import 'package:app/pages/validation.dart';
import 'package:app/pages/ver_acesso.dart';
import 'package:app/services/prefs_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<bool> esconderList = [false, false, false, false, false, false, false];
  Object? dados;
  bool carregando = true;
  String? uu;
  int? uu2;
  bool _isMounted = false;
  bool showcaseDisplayed = false;
  late String estado;
  GlobalKey _three = GlobalKey();
  GlobalKey _four = GlobalKey();
  GlobalKey _five = GlobalKey();
  GlobalKey _six = GlobalKey();
  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration.zero, () {
    //   ShowCaseWidget.of(context).startShowCase([_three, _four, _five, _six]);
    // });
    _isMounted = true;
    initializeData();
    _checkShowCaseStatus(context);
    _checkAnimationStatus();
    // Add a delay to trigger the initial animation after 1 second
  }

  Future<void> _checkShowCaseStatus(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool showcaseDisplayed =
        prefs.getBool('show_case_displayed_profile') ?? false;

    if (!showcaseDisplayed) {
      // Exibe o ShowCase
      Future.delayed(Duration.zero, () {
        ShowCaseWidget.of(context).startShowCase([_three, _four, _five, _six]);
      });

      // Marca o ShowCase como exibido nas preferências compartilhadas
      prefs.setBool('show_case_displayed_profile', true);
    }
  }

  Future<void> _checkAnimationStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool animationCompleted = prefs.getBool('animation_completed') ?? false;

    if (!animationCompleted) {
      // Add a delay to trigger the initial animation after 2 seconds
      Future.delayed(Duration(seconds: 2), () {
        if (_isMounted) {
          setState(() {
            esconderList[0] =
                true; // Assuming the "STATUS" section is at index 6
          });

          // Add a second delay to toggle the value back to false after 2 seconds
          Future.delayed(Duration(seconds: 1), () {
            if (_isMounted) {
              setState(() {
                esconderList[0] = false;

                // Mark the animation as completed
                prefs.setBool('animation_completed', true);
              });
            }
          });
        }
      });
    }
  }

  Future<void> initializeData() async {
    User? user = await FirebaseAuth.instance.authStateChanges().first;
    if (user != null) {
      String uid = user.uid;

      DatabaseReference starCountRef =
          FirebaseDatabase.instance.ref('users/$uid/solicitou');
      starCountRef.onValue.listen((DatabaseEvent event) {
        final data = event.snapshot.value;
        if (mounted) {
          setState(() {
            dados = data;
          });
        }
      });

      DatabaseReference starCountRef2 =
          FirebaseDatabase.instance.ref('users/$uid/matricula');
      starCountRef2.onValue.listen((DatabaseEvent event) {
        final data = event.snapshot.value;
        if (mounted) {
          setState(() {
            uu = data as String?;
          });
        }
      });

      DatabaseReference starCountRef3 =
          FirebaseDatabase.instance.ref('users/$uid/credencial');
      starCountRef3.onValue.listen((DatabaseEvent event) {
        final data = event.snapshot.value;
        if (mounted) {
          setState(() {
            uu2 = data as int?;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
  }

  // New method to initialize data

  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('validações');

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 5),
            Transform.translate(
              offset: Offset(0, -10),
              child: Container(
                padding: EdgeInsets.all(15),
                alignment: Alignment.centerRight,
                width: 0.9 * double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.green[700],
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(100),
                    bottomRight: Radius.circular(100),
                  ),
                ),
                child: GestureDetector(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "SAIR",
                        style: GoogleFonts.oswald(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.login_outlined,
                        color: Colors.white,
                        size: 25,
                      )
                    ],
                  ),
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    PrefsService.logout();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Transform.translate(
                offset: Offset(0, -80),
                child: FutureBuilder<User?>(
                  future: FirebaseAuth.instance.authStateChanges().first,
                  builder:
                      (BuildContext context, AsyncSnapshot<User?> snapshot) {
                    if (snapshot.hasData) {
                      User? user = snapshot.data;

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  child: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(user!.photoURL ?? ''),
                                    radius: 75,
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      // Navegar para a página EditProfile() aqui
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EditProfile()),
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.green[
                                            700], // Cor de fundo do ícone de edição
                                      ),
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors
                                            .white, // Cor do ícone de edição
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 0,
                          ),
                          Text(
                            '${user.displayName}',
                            style: GoogleFonts.oswald(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  child: CircleAvatar(
                                    radius: 75,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ),
            Column(
              children: [
                if (uu2 == 1)
                  Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceEvenly, // Pode ajustar conforme necessário
                    children: [
                      Showcase(
                        key: _four,
                        description:
                            'Ãqui você pode aprovar a solicitação de alguém.',
                        overlayOpacity: 0.5,
                        targetShapeBorder: const CircleBorder(),
                        targetPadding: const EdgeInsets.all(8),
                        child: Container(
                          width: 0.42 * MediaQuery.of(context).size.width,
                          height: 60,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0,
                                      3), // altere os valores conforme necessário
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ValidacoesScreen(), //Depois eu volto para ValidacoesScreen()
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green[800],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              child: Text(
                                'SOLICITAÇÕES',
                                style: GoogleFonts.oswald(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.5,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Showcase(
                        key: _five,
                        description:
                            'Aqui você pode aprovar a solicitação de alguém.',
                        overlayOpacity: 0.5,
                        targetShapeBorder: const CircleBorder(),
                        targetPadding: const EdgeInsets.all(8),
                        child: Container(
                          width: 0.42 * MediaQuery.of(context).size.width,
                          height: 60,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0,
                                      3), // altere os valores conforme necessário
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddAdm(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green[800],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              child: Text(
                                'INCLUIR GESTOR',
                                style: GoogleFonts.oswald(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.5,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                SizedBox(
                  height: 15,
                ),
                if (dados == true)
                  FutureBuilder<DocumentSnapshot>(
                    future: users.doc(uu).get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      Map<String, dynamic> data = {};
                      if (snapshot.data?.data() != null) {
                        data = snapshot.data!.data() as Map<String, dynamic>;
                      }
                      if (snapshot.connectionState == ConnectionState.waiting &&
                          carregando) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.green[800],
                          ),
                        );
                      } else {
                        if (data['aguardando'] == true) {
                          estado = "EM ESPERA";
                        } else if (data['autorizado'] == true) {
                          estado = "AUTORIZADO";
                        } else if (data['negado'] == true) {
                          estado = "NEGADO";
                        } else {
                          estado = "Erro";
                        }
                        carregando = false;
                        return Column(children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        VerAcesso(), //Depois eu volto para ValidacoesScreen()
                                  ),
                                );
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                  right:
                                      26), // Adiciona espaço à direita do texto
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'Ver histórico',
                                  style: GoogleFonts.oswald(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          info(context, "STATUS:", "STATUS", estado, false, 6),
                          SizedBox(height: 10),
                          if (estado == "AUTORIZADO")
                            Showcase(
                              key: _six,
                              description:
                                  'Informe este número quando for cadastrar sua biometria.',
                              overlayOpacity: 0.5,
                              targetShapeBorder: const CircleBorder(),
                              targetPadding: const EdgeInsets.all(8),
                              child: info(context, "ID:", "ID",
                                  "${data['idBiometria']}", true, 0),
                            ),
                          SizedBox(height: 10),
                          info(context, "E-MAIL:", "E-MAIL", '${data['email']}',
                              true, 1),
                          SizedBox(height: 10),
                          info(context, "MAT:", 'MATRÍCULA',
                              "${data['matricula']}", true, 2),
                          SizedBox(height: 10),
                          if (data['vinculo'] != null &&
                              data['vinculo']['tipoVinculo'] != null)
                            info(context, "VIN:", 'VÍNCULO',
                                '${data['vinculo']['tipoVinculo']}', false, 3),
                          SizedBox(height: 10),
                          if (data['vinculo'] != null &&
                              data['vinculo']['curso'] != null)
                            info(context, "CUR:", 'CURSO',
                                '${data['vinculo']['curso']}', false, 4),
                          SizedBox(height: 10),
                          if (data['vinculo'] != null &&
                              data['vinculo']['tempo'] != null)
                            info(context, "P/A:", 'PER/ANO',
                                '${data['vinculo']['tempo']}', false, 5),
                          SizedBox(height: 30),
                        ]);
                      }
                    },
                  ),

                if (dados == false && !showcaseDisplayed)
                  Showcase(
                    key: _three,
                    description: 'Você pode solicitar acesso ao LabMaker!',
                    overlayOpacity: 0.5,
                    targetShapeBorder: const CircleBorder(),
                    targetPadding: const EdgeInsets.all(8),
                    child: Container(
                      width: 0.85 * MediaQuery.of(context).size.width,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Validation()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green[800],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: Text(
                          'SOLICITAR ACESSO AO LABMAKER',
                          style: GoogleFonts.oswald(
                            textStyle: TextStyle(
                              fontSize: 20.0, // Tamanho de fonte aumentado
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                // if (dados == false)

                SizedBox(height: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget info(context, String titulo, String tituloCompleto, String dado,
      bool copy, int index) {
    return Container(
      width: 0.9 * MediaQuery.of(context).size.width,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            width: 0.9 * MediaQuery.of(context).size.width,
            height: 60,
            decoration: BoxDecoration(
              color: Color.fromARGB(100, 225, 244, 203),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 0.4 * MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft,
                  child: Text(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      dado,
                      style: dado == "AUTORIZADO"
                          ? GoogleFonts.oswald(
                              color: Colors.green[800],
                              fontSize: 18,
                              fontWeight: FontWeight.bold)
                          : dado == 'NEGADO'
                              ? GoogleFonts.oswald(
                                  color: Colors.red,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)
                              : dado == "EM ESPERA"
                                  ? GoogleFonts.oswald(
                                      color: Color.fromARGB(255, 190, 146, 0),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)
                                  : GoogleFonts.oswald(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                ),
                SizedBox(width: 10),
                if (copy)
                  GestureDetector(
                    onTap: () {
                      _copyToClipboard(dado);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Copiado'),
                        ),
                      );
                    },
                    child: Icon(Icons.copy_sharp, color: Colors.green[800]),
                  ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                esconderList[index] = !esconderList[index];
              });
            },
            child: AnimatedContainer(
              width: esconderList[index]
                  ? 0.9 * MediaQuery.of(context).size.width
                  : 0.27 * MediaQuery.of(context).size.width,
              height: 60,
              alignment: Alignment.centerLeft,
              duration: const Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green[800],
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: esconderList[index]
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                Icon(
                                  Icons.lock_outline_rounded,
                                  color: Colors.white,
                                ),
                                Text(
                                  tituloCompleto,
                                  style: GoogleFonts.oswald(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                )
                              ])
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                Icon(Icons.lock_open_rounded,
                                    color: Colors.white),
                                Text(titulo,
                                    style: GoogleFonts.oswald(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18))
                              ]),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _copyToClipboard(String s) {
    Clipboard.setData(ClipboardData(text: s));
  }
}
