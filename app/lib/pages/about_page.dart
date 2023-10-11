import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Image.asset("assets/imagens/labmaker-navbar2.jpg"),
          const SizedBox(height: 20),
          const Text(
            'Sobre o LabMaker',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Image.asset("assets/imagens/labMaker.jpg"),
          const SizedBox(height: 20),
          const Text(
            'O Laboratório Maker é um espaço inovador e inspirador, projetado para promover a aprendizagem e a criatividade dos alunos. Equipado com tecnologias de ponta, o laboratório oferece aos estudantes a oportunidade de explorar e experimentar diversas áreas, como programação, robótica, eletrônica e design.'
'Neste ambiente estimulante, os alunos têm acesso a computadores, impressoras 3D, kits de robótica e outros recursos tecnológicos avançados. Eles podem desenvolver projetos práticos, criar protótipos, programar dispositivos e explorar soluções inovadoras para desafios do mundo real.'
'Além disso, o laboratório é um espaço de colaboração, onde os alunos podem trabalhar em equipe, compartilhar ideias e aprender uns com os outros. Os professores e instrutores especializados estão sempre presentes para orientar e apoiar os estudantes em suas jornadas de aprendizagem.'
'O Laboratório de Tecnologia Escolar é um ambiente que estimula a curiosidade, a experimentação e o pensamento crítico. Ele prepara os alunos para os desafios do século XXI, capacitando-os com habilidades essenciais para o mundo digital. É um local onde a imaginação ganha vida e onde os estudantes podem transformar suas ideias em realidade.'
'Seja para desenvolver projetos acadêmicos, participar de competições de tecnologia ou simplesmente explorar novas possibilidades, o Laboratório de Tecnologia Escolar é um espaço que inspira e capacita os alunos a se tornarem os inovadores e criadores do futuro.',
            style: TextStyle(fontSize: 10),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  children: [
                    const Text(
                      'Equipe de Desenvolvimento',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Image.asset('assets/team_image_1.png'),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  children: [
                    const Text(
                      'Equipe LabMaker',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Image.asset('assets/team_image_2.png'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/team_image_3.png'),
              const SizedBox(width: 20),
              Image.asset('assets/team_image_4.png'),
            ],
          ),
          const SizedBox(height: 20),
          Image.asset('assets/team_image_5.png'),
        ],
      ),
    );
  }
}

