import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:material_text_fields/theme/material_text_field_theme.dart';
import 'package:signup_signin/firebase_options.dart';
import 'package:signup_signin/login_page.dart';
import 'package:signup_signin/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        inputDecorationTheme: FilledOrOutlinedTextTheme(
            radius: 16,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            errorStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            fillColor: Colors.white,
            suffixIconColor: Colors.blue,
            prefixIconColor: Colors.blue,
            focusedColor: Colors.blue),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}
