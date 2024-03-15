import 'package:app/pages/access_page.dart';
import 'package:app/pages/home_page.dart';
import 'package:app/pages/teste.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

class Teste2 extends StatelessWidget {
  const Teste2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ShowCaseWidget(
        builder: Builder(
          builder: (context) => HomePage(),
        ),
      ),
    );
  }
}