import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:app/pages/app_widget.dart';
import 'package:app/firebase_options.dart';


// void main() {
//   runApp(AppWidget(title: 'Tomi',));
// }
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(AppWidget(title: 'Conectado!'));
}
