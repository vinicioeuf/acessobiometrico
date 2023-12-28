import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
Future<void> myBackgroundMessageHandler(RemoteMessage message) async {
    print('Mensagem em segundo plano: ${message.notification?.title}');
    print('Mensagem em segundo plano: ${message.notification?.body}');
    // Adicione aqui o código para lidar com a mensagem em segundo plano
  }
class FirebaseMessage {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();

    final fcmToken = await _firebaseMessaging.getToken();

    print('Token: $fcmToken');

    FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);

    FirebaseFirestore.instance
        .collection('validações') // Substitua 'suaColecao' pelo nome da sua coleção
        .snapshots()
        .listen((querySnapshot) {
      querySnapshot.docChanges.forEach((change) {
        if (change.type == DocumentChangeType.added) {
          // Envie a notificação aqui
          sendNotification();
        }
      });
    });
  }

  

  void sendNotification() {
    // Adicione o código para enviar a notificação aqui
  }
}
