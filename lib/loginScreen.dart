import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_google/services/database.dart';
import 'HomeScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    checkUser();
  }

  // Kiểm tra người dùng đã đăng nhập chưa
  void checkUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  // Hàm đăng nhập
  void _login() {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    if (email == "12" && password == "12") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Đăng nhập thất bại'),
            content: const Text('Email hoặc mật khẩu không chính xác'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  // Hàm đăng nhập bằng Google
  signInWithGoogle(BuildContext context)async{
    final FirebaseAuth firebaseAuth= FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: '372949648585-0dnv31t2p87kkkjocodc6aj2ujnv95ic.apps.googleusercontent.com',
    );

    final GoogleSignInAccount? googleSignInAccount= await googleSignIn.signIn();

    final GoogleSignInAuthentication? googleSignInAuthentication= await googleSignInAccount?.authentication;

    final AuthCredential credential= GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication?.idToken,
      accessToken:  googleSignInAuthentication?.accessToken,
    );

    UserCredential result= await firebaseAuth.signInWithCredential(credential);

    User? userdetails= result.user;

    if(result!=null){
      Map<String, dynamic> userInfoMap={
        "email": userdetails!.email,
        "name": userdetails.displayName,
        "imgUrl": userdetails.photoURL,
        "id": userdetails.uid,
      };
      await DatabaseMethods().addUser(userdetails.uid, userInfoMap).then((value) {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng Nhập'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Email Field
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Password Field
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Mật khẩu',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),

            // Login Button
            ElevatedButton(
              onPressed: _login,
              child: const Text('Đăng Nhập'),
            ),
            const SizedBox(height: 24),

            // Google Login Button
            GestureDetector(
              onTap: () {
                signInWithGoogle(context);
              },
              child: const Text(
                'Đăng Nhập Bằng Google',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
