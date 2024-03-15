
import 'package:app/pages/team_dev.dart';
import 'package:app/pages/team_maker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

// ignore: must_be_immutable
class _AboutPageState extends State<AboutPage> {
  GlobalKey _team = GlobalKey();
  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration.zero, () {
    //     ShowCaseWidget.of(context).startShowCase([_team]);
    //   });
    // Verifique se o ShowCase já foi exibido nas preferências compartilhadas
    _checkShowCaseStatus();

  }
  Future<void> _checkShowCaseStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? showCaseDisplayed = prefs.getBool('show_case_displayed');

    if (showCaseDisplayed == false) {
      // Exibe o ShowCase
      Future.delayed(Duration.zero, () {
        ShowCaseWidget.of(context).startShowCase([_team]);
      });

      // Marca o ShowCase como exibido nas preferências compartilhadas
      prefs.setBool('show_case_displayed', true);
    }
  }
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/imagens/labmaker-navbar2.jpg'), // Passo 1
            Container(
              height: 1,
              color: Colors.grey, // Passo 2
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Sobre o LabMaker', // Passo 3
                style: GoogleFonts.oswald(
                          fontWeight: FontWeight.bold,
                            fontSize: 35.0,
                            color: Colors.green[800],
                        )
                  
              ),
            ),
            Image.asset('assets/imagens/labMaker.jpg'), 
            SizedBox(height: 20),
            Container(
              width:double.infinity,
              height: 250,
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width:5),
                  Showcase(
                    key: _team,
                    description:
                        'Você também pode ver a nossa equipe maker!',
                    overlayOpacity: 0.5,
                    targetShapeBorder: const CircleBorder(),
                    targetPadding: const EdgeInsets.all(3),
                    child: Container(
                      alignment: Alignment.topCenter,
                      width: 0.5 * MediaQuery.of(context).size.width,
                      
                    child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                        Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TeamMakerPage()),
                    );
                      },
                         style: ElevatedButton.styleFrom(
                         fixedSize: Size(200, 50),
                        primary: Colors.green[800],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Text(
                        'Equipe Maker',
                        style: GoogleFonts.oswald(
                          fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.white,
                        )
                      )
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                        Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TeamDevPage()),
                    );
                      },
                         style: ElevatedButton.styleFrom(
                          fixedSize: Size(200, 50),
                        primary: Colors.green[800],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Text(
                        'Equipe de Devs',
                        style: GoogleFonts.oswald(
                          fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.white,
                        )
                      )
                      )
                    ],
                  ),
                  ),
                  ),
                  
                  
                    
                  SizedBox(width: 10),
                  //Barra
                  Container(
                    width: 1,
                    height: 250 ,
                    color: Colors.green[800],
                  ),
                  SizedBox(width: 10),
                  Container(
                    width:  0.4 * MediaQuery.of(context).size.width,
                    height: 0.95*MediaQuery.of(context).size.width,
                    alignment: Alignment.topCenter,
                  //Descrição
                  child: Text("O Labmaker tem como meta criar um ambiente propício para o surgimento de agentes transformadores da realidade através da participação ativa em diversos problemas da sociedade.",
                  style: GoogleFonts.oswald(
                            fontSize: 15.0,
                            color: Colors.black,
                        ),)
                  ),
                  SizedBox(height: 50),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}