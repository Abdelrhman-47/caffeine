import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {

}

class ConfigMessage {
  static final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    await _requestPermission();
    await _initLocalNotifications();
    await getToken();
    _setupTokenRefreshListener();
    _foregroundListener();
    _backgroundListener();
    _terminatedListener();
    _setupBackgroundHandler();
  }

  static Future<void> _requestPermission() async {
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    log('Permission status: ${settings.authorizationStatus}');

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log(' User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      log(' User granted provisional permission');
    } else {
      log(' User declined or has not accepted permission');
    }
  }

  static Future<void> _initLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );

    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsDarwin,
        );

    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications',
      importance: Importance.max,
      playSound: true,
      enableVibration: true,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    log(' Local Notifications Initialized');
  }

  static Future<String?> getToken() async {
    try {
      String? token = await _fcm.getToken();
      log(' FCM TOKEN => $token');
      return token;
    } catch (e) {
      log('Error getting token: $e');
      return null;
    }
  }

  static void _setupTokenRefreshListener() {
    _fcm.onTokenRefresh.listen((newToken)async {
      log('Token refreshed: $newToken');
        final supabase = Supabase.instance.client;
    final userId = supabase.auth.currentUser?.id;

    if (userId != null) {
      await supabase
          .from('users')
          .update({'notification_token': newToken})
          .eq('user_id', userId);
    }
    });
  }

  static void _foregroundListener() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('📩 Foreground Message Received');
      log('Title: ${message.notification?.title}');
      log('Body: ${message.notification?.body}');
      log('Data: ${message.data}');

      _showLocalNotification(message);
    });
  }

  static void _backgroundListener() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('📲 Notification opened from background');
      log('Title: ${message.notification?.title}');
      log('Data: ${message.data}');

      _handleNotificationAction(message);
    });
  }

  static Future<void> _terminatedListener() async {
    RemoteMessage? message = await FirebaseMessaging.instance
        .getInitialMessage();

    if (message != null) {
      log('🚀 App opened from terminated state via notification');
      log('Title: ${message.notification?.title}');
      log('Data: ${message.data}');

      _handleNotificationAction(message);
    }
  }

  static void _setupBackgroundHandler() {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    log('🌐 Background handler registered');
  }

  static Future<void> _showLocalNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'high_importance_channel', 
          'High Importance Notifications', 
          channelDescription:
              'This channel is used for important notifications',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: true,
          enableVibration: true,
          playSound: true,
        );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications.show(
      message.hashCode, 
      message.notification?.title ?? 'New Notification',
      message.notification?.body ?? '',
      notificationDetails,
      payload: message.data.toString(),
    );

    log('Local notification displayed');
  }

  static void _onNotificationTapped(NotificationResponse response) {
    log(' Notification tapped');
    log('Payload: ${response.payload}');

  }

  static void _handleNotificationAction(RemoteMessage message) {
    log(' Handling notification action');
    log('Data: ${message.data}');


  }

  static Future<void> subscribeToTopic(String topic) async {
    try {
      await _fcm.subscribeToTopic(topic);
      log(' Subscribed to topic: $topic');
    } catch (e) {
      log(' Error subscribing to topic: $e');
    }
  }

  static Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _fcm.unsubscribeFromTopic(topic);
      log('🚫 Unsubscribed from topic: $topic');
    } catch (e) {
      log('❌ Error unsubscribing from topic: $e');
    }
  }

  static Future<void> deleteToken() async {
    try {
      await _fcm.deleteToken();
      log(' Token deleted');
    } catch (e) {
      log('Error deleting token: $e');
    }
  }

  static Future<void> setForegroundNotificationPresentationOptions() async {
    await _fcm.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    log('⚙️ Foreground notification options set');
  }

  static Future<NotificationSettings> getNotificationSettings() async {
    return await _fcm.getNotificationSettings();
  }

  static Future<bool> areNotificationsEnabled() async {
    final settings = await _fcm.getNotificationSettings();
    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }
}
