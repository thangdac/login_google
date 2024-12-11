import 'package:flutter/material.dart';
import 'loginScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart'; // Giữ import nếu cần dùng GoogleSignIn

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Khởi tạo Firebase cho Web với FirebaseOptions
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyAoroorCuKsUwz0Egs394eg0430JJhZRzw",
      appId: "1:372949648585:android:9a49f06ab848b1fad6f918",
      messagingSenderId: "372949648585",
      projectId: "test-fe6e9",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LoginScreen(), // Set LoginScreen as the home screen
    );
  }
}
