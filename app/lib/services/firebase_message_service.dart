import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessage{
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async{
    await _firebaseMessaging.requestPermission();

    final fOMToken = await _firebaseMessaging.getToken();

    print('token : ${fOMToken}');
  }

  // void handleMessage(RemoteMessage? message){
  //   if(message == null) return;

    
  // }
}