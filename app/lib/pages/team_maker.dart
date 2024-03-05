import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable, use_key_in_widget_constructors
class TeamMakerPage extends StatelessWidget {
  

  BuildContext? get context => null;

  @override
  Widget build(BuildContext context) => Scaffold(
   appBar: AppBar(
          
          leading: IconButton(
            icon: Icon(Icons.arrow_circle_left_outlined, size: 40),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "EQUIPE MAKER",
            style: TextStyle(
                fontFamily: 'oswald',
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 255, 255, 255)),
          ),
          backgroundColor: Colors.green[800],
          shadowColor: Colors.white,
          iconTheme: IconThemeData(color: const Color.fromARGB(255, 255, 255, 255)),
        ),
        body: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(20),
            children: <Widget>[
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
              child:
                Text("DOCENTES", style: GoogleFonts.oswald(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.green[700]),),

              ),
              SizedBox(height: 15),
              buildTeamMember('assets/imagens/PLemos.jpg', 'Pedro', 'Coordenador do Labmaker', 'Doutor em Química (UFPB). Licenciado em Química (UFRPE). Mestre em Química (UFRPE/Universidade de Coimbra). Professor EBTT do IFSertãoPE - Campus Salgueiro.'),
              SizedBox(height: 10),
              buildTeamMember('assets/imagens/marcelo-santos.jpeg', 'Marcelo Santos', 'Coordenador do Centro de Inovação', 'Doutor em Ciências da Computação (UFPE e Université Evry Val d`Essonne - IBISC Lab (França). Mestre em Engenharia da Informação (UFABC). Graduado em Sistemas de Informação (IFAL). Professor EBTT do IFSertãoPE - Campus Salgueiro.'),
              SizedBox(height: 10),
              buildTeamMember('assets/imagens/adeisa-guimaraes.jpeg', 'Adeisa Guimarães', 'Membro', 'Mestre em Desenvolvimento Regional e Especialista em Gestão Pública Municipal pela Universidade Estadual da Paraíba. Especialista em Meio Ambiente (FURNE/UNIPÊ). Graduada em Licenciatura Plena em Geografia. Professora EBTT do IFSertãoPE.'),
              SizedBox(height: 10),
              buildTeamMember('assets/imagens/augusto-coimbra.jpeg', 'Augusto Coimbra', 'Membro', 'Especialista em Administração de Sistemas de Informação (UFLA) e em Docência para a Educação Profissional (SENAC-PE). Graduado em Ciência da Computação (FACAPE). Professor EBTT do IFSertãoPE - Campus Petrolina.'),
              SizedBox(height: 10),
              buildTeamMember('assets/imagens/francenila-rodrigues.jpeg', 'Francenila Rodrigues', 'Membro', 'Mestre em Engenharia de Software (CESAR). Especialista em Engenharia de Software e Graduada em Ciência da Computação (FACAPE). Professora EBTT do IFSertãoPE.'),
              SizedBox(height: 10),
              buildTeamMember('assets/imagens/francisco-kelsen.jpeg', 'Francisco Kelsen', 'Membro', 'Doutor em Ciência da Computação (UFPE). Mestre em Computação Aplicada (UECE). Especialista em Gestão de Projetos (UECE). Bacharel em Sistemas de Informação (UNESA). Professor EBTT do IFSertãoPE - Campus Salgueiro.'),//(TALVEZ REMOVER ELE)
              SizedBox(height: 10),
              buildTeamMember('assets/imagens/handherson-damasceno.jpeg', 'Handherson Damasceno', 'Membro', 'Doutor e Mestre em Educação (UFBA). Especialista em Educação a Distância (UNEB). Graduado em Pedagogia (UEFS) e em Licenciatura em Letras - Português pelo Centro Universitário Claretiano. Professor EBTT do IFSertãoPE.'),
              SizedBox(height: 10),
              buildTeamMember('assets/imagens/leoCampello.jpg', 'Leonardo Campello', 'Membro', 'Mestre em Ciências (UNIVASF). Graduado em Engenharia de Computação (UNIVASF e University of Idaho). Professor EBTT do IFSertãoPE - Campus Salgueiro.'),
              SizedBox(height: 10),
              buildTeamMember('assets/imagens/marcelo-souza.jpeg', 'Marcelo Souza', 'Membro', 'Doutor em Física (UFS). Mestre em Física (UFS). Licenciado em Física (UEFS). Professor EBTT do IFSertãoPE - Campus Salgueiro.'), //(TALVEZ REMOVER ELE)
              SizedBox(height: 10),
              buildTeamMember('assets/imagens/marcos-padilha.jpeg', 'Marcos Padilha', 'Membro', 'Doutorando em Ciência e Engenharia de Materiais (UFPB). Mestre em Engenharia Civil (UNICAP). Especialista em Gestão e Engenharia de Petróleo e Gás (IBEC). Graduado em Engenharia Civil (UFPB) e Tecnologia em Construção de Edifícios (UFPB). Professor EBTT do IFSertãoPE.'),
              SizedBox(height: 10),
              buildTeamMember('assets/imagens/marinaldo.jpeg', 'Marinaldo', 'Membro', 'Mestrando em Engenharia Civil e Ambiental (UFPE). Pós-Graduado em Engenharia e Segurança do Trabalho (FIP). Engenheiro Civil (UFCG). Professor EBTT do IFPB.'),//(TALVEZ REMOVER ELE)
              SizedBox(height: 10),
              buildTeamMember('assets/imagens/pedro-davi.jpeg', 'Pedro Matos', 'Membro', 'Mestre em Física (UFBA). Graduado em Licenciatura em Física e Bacharel em Física (UFBA). Professor EBTT do IFSertãoPE.'),
              SizedBox(height: 10),
              buildTeamMember('assets/imagens/thales-ferreira.jpeg', 'Thales Ferreira', 'Membro', 'Especialista em Estrutura de Concreto e Fundações (UNIP). Graduado em Engenharia Civil (UNIVASF). Professor EBTT do IFSertãoPE.'),
              SizedBox(height: 10),
              buildTeamMember('assets/imagens/yanne-andrade.jpeg', 'Yanne Andrade', 'Membro', 'Mestra em Gestão Ambiental (IFPE). Especialista em Gestão Ambiental e Desenvolvimento Sustentável (UNINTER). Graduada em Arquitetura e Urbanismo (UFPE). Professora EBTT do IF Sertão-PE - Campus Salgueiro.'),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
              child:
                Text("DISCENTES", style: GoogleFonts.oswald(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.green[700]),),

              ),
              SizedBox(height: 15),
              buildTeamMember('assets/imagens/viniEufrazio.jpg', 'Vinicio Eufrazio', 'Bolsista', 'Graduando em Tecnologia em Sistemas para Internet (IFSertãoPE), Técnico em Informática (IFSertãoPE), Administrador de sites na K1Digital.'),
              SizedBox(height: 10),
              buildTeamMember('assets/imagens/vicCarlos.jpg', 'Victor Carlos', 'Bolsista', 'Graduando em Tecnologia em Sistemas para Internet (IFSertãoPE), Técnico em Informática (IFSertãoPE).'),
              SizedBox(height: 10),
              buildTeamMember('assets/imagens/alanny.jpg', 'Alanny Barbosa', 'Membro', 'Graduando em Tecnologia em Sistemas para Internet (IFSertãoPE), Técnica em Agropecuária (IFSertãoPE).'),
            ],
          ),
        ),
      );

  int selectedIndex = 0;

 
   Widget buildTeamMember(
      String imagePath, String name, String role, String description) {
    return Container(
      alignment: Alignment.topCenter,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start, // Alteração aqui
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start, // Alteração aqui
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(imagePath),
              ),
              SizedBox(height: 15),
              const Column(
                children: [
                  Icon(Icons.mail, color: Colors.black),
                  SizedBox(height: 20),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 13,
                    backgroundImage: AssetImage('assets/imagens/github.png'),
                  ),
                  SizedBox(height: 20),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 13,
                    backgroundImage: AssetImage('assets/imagens/linkedin.png'),
                  ),
                  SizedBox(height: 20),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 13,
                    backgroundImage: AssetImage('assets/imagens/instagram.png'),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(width: 50),
          Container(
            width: 1,
            height: 200,
            color: Colors.green[800],
          ),
          SizedBox(width: 50),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'oswald',
                      color: Colors.green[800]),
                ),
                SizedBox(height: 5),
                Text(
                  role,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                      fontFamily: 'oswald',
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  description,
                  style: TextStyle(fontSize: 16, fontFamily: 'oswald'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
