import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'pages/home_page.dart';
import 'services/auth_service.dart';
import 'app_keys.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'pages/login_page.dart';
import 'package:flutter/foundation.dart'; 
import 'dart:io';
import 'services/notification_service.dart'; // ← PASTIKAN BARIS INI ADA

Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();

    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  } else {
    debugPrint('Firebase tidak diinisialisasi karena berjalan di Desktop/Web.');
  }


  await Supabase.initialize(
    url: 'https://kstiquuqgrlawkkplrlb.supabase.co',
    publishableKey: 'sb_publishable_dYKHIboi8sBmBwXT5i_wMQ_LvFftGs_',
  );
  Supabase.instance.client.auth.onAuthStateChange.listen((data) {
  debugPrint('Auth event: ${data.event}');

  if (data.event == AuthChangeEvent.signedOut) {
    navigatorKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }
});


  runApp(const KosFinderApp());
}

class KosFinderApp extends StatelessWidget {
  const KosFinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KosFinder',
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      navigatorKey: navigatorKey, // dari app_keys.dart (lihat di bawah)
      scaffoldMessengerKey: messengerKey,
      home: AuthService.instance.isLoggedIn
          ? const HomePage() // Session Exists -> Home
          : const LoginPage(), // No Session   -> Login
    );

  }
}
