import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'loginScreen.dart'; // Thêm import cho LoginScreen

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Màn Hình Chính'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Đăng xuất khi nhấn nút
            FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          },
          child: const Text('Đăng xuất'),
        ),
      ),
    );
  }
}
