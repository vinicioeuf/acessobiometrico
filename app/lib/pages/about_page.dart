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
          Container(
            alignment: Alignment.center,
            child: const Text(
              'Sobre o LabMaker',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
            ),
          ),
          const SizedBox(height: 20),
          Image.asset("assets/imagens/labMaker.jpg"),
          const SizedBox(height: 20),
          const Text(
            'O Laboratório Maker é um espaço inovador e inspirador, projetado para promover a aprendizagem e a criatividade dos alunos. Equipado com tecnologias de ponta, o laboratório oferece aos estudantes a oportunidade de explorar e experimentar diversas áreas, como programação, robótica, eletrônica e design.',
            style: TextStyle(fontSize: 15),
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
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                    const SizedBox(height: 10),
                    AspectRatio(
                      aspectRatio: 1,
                      child: Image.asset('assets/imagens/leoCampello.jpg'),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  children: [
                    const Text(
                      'Equipe LabMaker',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                    const SizedBox(height: 10),
                    AspectRatio(
                      aspectRatio: 1,
                      child: Image.asset('assets/imagens/vicCarlos.jpg'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset('assets/imagens/viniEufrazio.jpg'),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset('assets/imagens/PLemos.jpg'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

