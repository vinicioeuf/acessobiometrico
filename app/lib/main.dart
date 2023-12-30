import 'package:app/services/firebase_message_service.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
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
  await AwesomeNotifications().initialize(null, [
    NotificationChannel(
        channelGroupKey: 'basic_channel_group',
        channelKey: 'basic_channel',
        channelName: ' Basic Notification',
        channelDescription: 'Basic notifications channel')
  ], channelGroups: [
    NotificationChannelGroup(
        channelGroupKey: 'basic_channel_groud', channelGroupName: 'Basic Group')
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  bool isAllowToSendNotification =
      await AwesomeNotifications().isNotificationAllowed();

  if (!isAllowToSendNotification) {
    AwesomeNotifications().requestPermissionToSendNotifications();
  }
  // await FirebaseMessage().initNotifications();
  runApp(AppWidget(title: 'Conectado!'));
}
