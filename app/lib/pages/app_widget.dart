import 'package:app/pages/addadm.dart';
import 'package:app/pages/edit_profile.dart';
import 'package:app/pages/esqueceu_senha.dart';
import 'package:app/pages/show_case.dart';
import 'package:app/pages/slash_page.dart';
import 'package:app/pages/home_page.dart';
import 'package:app/pages/login_page.dart';
import 'package:app/pages/profile_page.dart';
import 'package:app/pages/about_page.dart';
import 'package:app/pages/access_page.dart';
import 'package:app/pages/team_dev.dart';
import 'package:app/pages/teste.dart';
import 'package:app/pages/teste2.dart';
import 'package:app/pages/ver_acess_adm.dart';
import 'package:app/pages/ver_acesso.dart';
import 'package:app/widgets/auth_check.dart';
import 'package:flutter/material.dart';
import 'package:app/pages/show_data.dart';

class AppWidget extends StatelessWidget {
  final String title;

  const AppWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData( 
        primarySwatch: MaterialColor(0xFFA7BF8B, {
          50: Color(0xFFA7BF8B),
          100: Color(0xFFA7BF8B),
          200: Color(0xFFA7BF8B),
          300: Color(0xFFA7BF8B),
          400: Color(0xFFA7BF8B),
          500: Color(0xFFA7BF8B),
          600: Color(0xFFA7BF8B),
          700: Color(0xFFA7BF8B),
          800: Color(0xFFA7BF8B),
          900: Color(0xFFA7BF8B),
        }),
      ),
      initialRoute: '/splash',
      routes: {
  '/splash': (_) => const SplashPage(),
  '/login': (_) => const LoginPage(),
  '/home': (_) => HomePage(),
  '/about': (_) => AboutPage(),
  '/access': (_) => AccessPage(),
  '/profile': (_) => ProfilePage(),
  '/teamDev': (_) => TeamDevPage(),
  '/show': (_) => ValidacoesScreen(),
  '/addadm': (_) => AddAdm(),
  '/editprofile': (_) => EditProfile(),
  '/esqueceu_senha': (_) => EsqueceuSenha(),
  '/teste': (_) => Teste(),
  '/teste2': (_) => Teste2(),
  '/ver_acesso': (_) => VerAcesso(),
  '/ver_acess_adm': (_) => VerAcessoAdm()
},

      home: AuthCheck(),
    );
  }
}
