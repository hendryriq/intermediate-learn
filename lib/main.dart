import 'package:flutter/material.dart';
import 'package:intermediate_learn/UI/uiberita/screen_berita.dart';
import 'package:intermediate_learn/akses_gambar.dart';
import 'package:intermediate_learn/firebase_learn/authentication.dart';
import 'package:intermediate_learn/firebase_learn/login_signup_screen.dart';
import 'package:intermediate_learn/firebase_learn/root_page.dart';
import 'package:intermediate_learn/firebase_options.dart';
import 'package:intermediate_learn/sqflite_flutter/list_pegawai.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async{
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
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: RootPage(
        auth: Auth(),
      )
    );
  }
}



