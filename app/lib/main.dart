import 'package:app/services/firebase_message_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:app/firebase_options.dart';
import 'package:app/pages/app_widget.dart';
// import 'package:app/services/firebase_message_service.dart';


// void main() {
//   runApp(AppWidget(title: 'Tomi',));
// }
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessage().initNotifications();
  runApp(AppWidget(title: 'Conectado!'));
}
