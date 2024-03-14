import 'package:app/services/auth_service.dart';
import 'package:flutter/material.dart';

class EsqueceuSenha extends StatefulWidget {
  const EsqueceuSenha({super.key});

  @override
  State<EsqueceuSenha> createState() => _EsqueceuSenhaState();
}

class _EsqueceuSenhaState extends State<EsqueceuSenha> {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Esqueceu sua senha?'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Por favor, preencha o campo abaixo com seu e-mail institucional para prosseguir", style: TextStyle(color: Colors.grey[400])),
            SizedBox(height: 10,),
           TextField(
  controller: emailController,
  decoration: InputDecoration(
    labelText: 'E-mail',
    border: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black),
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),
),

            SizedBox(height: 20),
            Container(
  width: MediaQuery.of(context).size.width * 0.8,
  height: 40.0,
  child: ElevatedButton(
    onPressed: () {
      // Adicione aqui a lógica para enviar o e-mail de recuperação
      enviarEmailRecuperacao(context, emailController.text);
    },
    style: ElevatedButton.styleFrom(
      primary: Colors.green[800],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
    ),
    child: Text(
      'Enviar',
      style: TextStyle(color: Colors.white),
    ),
  ),
),

          ],
        ),
      ),
    );
  }

  void enviarEmailRecuperacao(BuildContext context, String email) async {
    try {
      final authService = AuthService();
      await authService.sendPasswordResetEmail(email);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('E-mail de recuperação enviado. Verifique sua caixa de entrada.'),
        ),
      );

      Navigator.pop(context); // Voltar para a tela de login
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message),
        ),
      );
    }
  }
}