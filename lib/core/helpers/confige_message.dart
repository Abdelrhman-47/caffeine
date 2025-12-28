import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// 🔥 Background Message Handler (MUST be top-level function)
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log('🔥 Background Message: ${message.notification?.title}');
  log('🔥 Background Data: ${message.data}');
}

class ConfigMessage {
  static final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  /// 🔥 INIT كله هنا - Initialize all notification configurations
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

  /// 🔐 Request Permission - طلب الإذن
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

    log('🔐 Permission status: ${settings.authorizationStatus}');

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('✅ User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      log('⚠️ User granted provisional permission');
    } else {
      log('❌ User declined or has not accepted permission');
    }
  }

  /// 🔔 Initialize Local Notifications - تهيئة الإشعارات المحلية
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

    // Create Android notification channel
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

    log('🔔 Local Notifications Initialized');
  }

  /// 🔑 Get FCM Token - الحصول على التوكن
  static Future<String?> getToken() async {
    try {
      String? token = await _fcm.getToken();
      log('🔑 FCM TOKEN => $token');
      // TODO: Send this token to your backend server
      return token;
    } catch (e) {
      log('❌ Error getting token: $e');
      return null;
    }
  }

  /// 🔄 Token Refresh Listener - مراقبة تحديث التوكن
  static void _setupTokenRefreshListener() {
    _fcm.onTokenRefresh.listen((newToken)async {
      log('🔄 Token refreshed: $newToken');
        final supabase = Supabase.instance.client;
    final userId = supabase.auth.currentUser?.id;

    if (userId != null) {
      await supabase
          .from('users')
          .update({'notification_token': newToken})
          .eq('user_id', userId);
    }
      // TODO: Send the new token to your backend server
    });
  }

  /// 📩 Foreground Listener - الاستماع للإشعارات في المقدمة
  static void _foregroundListener() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('📩 Foreground Message Received');
      log('Title: ${message.notification?.title}');
      log('Body: ${message.notification?.body}');
      log('Data: ${message.data}');

      // Show local notification when app is in foreground
      _showLocalNotification(message);
    });
  }

  /// 📲 Background Listener - الاستماع عند فتح الإشعار من الخلفية
  static void _backgroundListener() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('📲 Notification opened from background');
      log('Title: ${message.notification?.title}');
      log('Data: ${message.data}');

      // Handle navigation or action when notification is tapped
      _handleNotificationAction(message);
    });
  }

  /// 🚀 Terminated Listener - الاستماع عند فتح الإشعار من حالة الإغلاق
  static Future<void> _terminatedListener() async {
    RemoteMessage? message = await FirebaseMessaging.instance
        .getInitialMessage();

    if (message != null) {
      log('🚀 App opened from terminated state via notification');
      log('Title: ${message.notification?.title}');
      log('Data: ${message.data}');

      // Handle navigation or action when app is opened from terminated state
      _handleNotificationAction(message);
    }
  }

  /// 🌐 Setup Background Handler - إعداد معالج الخلفية
  static void _setupBackgroundHandler() {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    log('🌐 Background handler registered');
  }

  /// 🔔 Show Local Notification - عرض إشعار محلي
  static Future<void> _showLocalNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'high_importance_channel', // Channel ID
          'High Importance Notifications', // Channel name
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
      message.hashCode, // Notification ID
      message.notification?.title ?? 'New Notification',
      message.notification?.body ?? '',
      notificationDetails,
      payload: message.data.toString(),
    );

    log('🔔 Local notification displayed');
  }

  /// 👆 Handle Notification Tap - معالجة النقر على الإشعار
  static void _onNotificationTapped(NotificationResponse response) {
    log('👆 Notification tapped');
    log('Payload: ${response.payload}');

    // TODO: Navigate to specific screen based on payload
  }

  /// 🎯 Handle Notification Action - معالجة إجراء الإشعار
  static void _handleNotificationAction(RemoteMessage message) {
    log('🎯 Handling notification action');
    log('Data: ${message.data}');

    // TODO: Implement your navigation logic here
    // Example: Navigate to specific screen based on message.data
    // if (message.data['type'] == 'chat') {
    //   Navigator.pushNamed(context, '/chat', arguments: message.data);
    // }
  }

  /// 📱 Subscribe to Topic - الاشتراك في موضوع
  static Future<void> subscribeToTopic(String topic) async {
    try {
      await _fcm.subscribeToTopic(topic);
      log('📱 Subscribed to topic: $topic');
    } catch (e) {
      log('❌ Error subscribing to topic: $e');
    }
  }

  /// 🚫 Unsubscribe from Topic - إلغاء الاشتراك من موضوع
  static Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _fcm.unsubscribeFromTopic(topic);
      log('🚫 Unsubscribed from topic: $topic');
    } catch (e) {
      log('❌ Error unsubscribing from topic: $e');
    }
  }

  /// 🗑️ Delete Token - حذف التوكن
  static Future<void> deleteToken() async {
    try {
      await _fcm.deleteToken();
      log('🗑️ Token deleted');
    } catch (e) {
      log('❌ Error deleting token: $e');
    }
  }

  /// ⚙️ Set Foreground Notification Presentation Options - iOS
  static Future<void> setForegroundNotificationPresentationOptions() async {
    await _fcm.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    log('⚙️ Foreground notification options set');
  }

  /// 📊 Get Notification Settings - الحصول على إعدادات الإشعارات
  static Future<NotificationSettings> getNotificationSettings() async {
    return await _fcm.getNotificationSettings();
  }

  /// 🔍 Check if Notifications are Enabled - التحقق من تفعيل الإشعارات
  static Future<bool> areNotificationsEnabled() async {
    final settings = await _fcm.getNotificationSettings();
    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }
}
