import 'package:app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final senha = TextEditingController();
  bool isLogin = true;
  late String titulo;
  late String actionButton;
  late String toogleDesc;
  late String toogleButton;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    setFormAction(true);
  }

  setFormAction(bool acao) {
    setState(() {
      isLogin = acao; // Update isLogin based on the provided parameter

      if (isLogin) {
        titulo = "LOGIN";
        actionButton = "Entrar";
        toogleDesc = "Ainda não tem uma conta?";
        toogleButton = "Cadastre-se";
      } else {
        titulo = "CADASTRE-SE";
        actionButton = "Enviar";
        toogleDesc = "Já possui uma conta?";
        toogleButton = "Entrar";
      }
    });
  }

  login() async {
  final authService = AuthService();
  try {
    await authService.login(email.text, senha.text);
    Navigator.pushReplacementNamed(context, '/home'); // ou outra rota desejada
  } catch (e) {
    print('Erro no login_page.dart: $e');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Erro no login. Verifique suas credenciais e tente novamente.'),
    ));
  }
}

registrar() async {
  final authService = AuthService();
  try {
    await authService.registrar(email.text, senha.text);
    Navigator.pushReplacementNamed(context, '/home'); // ou outra rota desejada
  } catch (e) {
    print('Erro no login_page.dart: $e');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Erro no registro. Tente novamente.'),
    ));
  }
}


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Image.asset("assets/imagens/labmaker-navbar2.jpg"),
            ),
            Divider(
              height: 1,
              color: Colors.grey,
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: titulo,
                        style: GoogleFonts.oswald(
                          textStyle: TextStyle(
                            color: Colors.green[800],
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  TextFormField(
                      decoration: InputDecoration(
                        labelText: 'E-mail',
                        filled: true,
                        fillColor: Color.fromARGB(255, 238, 244, 236),
                        labelStyle: TextStyle(
                          color: Colors.green[800],
                          fontWeight: FontWeight.bold,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Informe seu e-mail";
                        }
                        return null;
                      }),
                  SizedBox(height: 30),
                  TextFormField(
                      obscureText:
                          _obscurePassword, // Define a visibilidade da senha
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        filled: true,
                        fillColor: Color.fromARGB(255, 238, 244, 236),
                        labelStyle: TextStyle(
                          color: Colors.green[800],
                          fontWeight: FontWeight.bold,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.green[800],
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      controller: senha,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Informe sua senha";
                        } else if (value.length < 6) {
                          return "Senha fraca. Tente outra";
                        }
                        return null;
                      }),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        if (isLogin) {
                          login();
                        } else {
                          registrar();
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      minimumSize: Size(double.infinity, 60),
                    ),
                    child: Text(
                      actionButton,
                      style: GoogleFonts.oswald(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(toogleDesc,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'oswald',
                              fontSize:
                                  0.04 * MediaQuery.of(context).size.width,
                              fontWeight: FontWeight.normal,
                            )),
                        TextButton(
                          onPressed: () => setFormAction(!isLogin),
                          child: Text(
                            toogleButton,
                            style: TextStyle(
                                color: Colors.green[800],
                                fontSize:
                                    0.04 * MediaQuery.of(context).size.width,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
