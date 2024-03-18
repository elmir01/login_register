import 'dart:ffi';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:material_text_fields/material_text_fields.dart';
import 'package:material_text_fields/utils/form_validation.dart';
import 'package:signup_signin/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:signup_signin/home_page.dart';
import 'package:signup_signin/register_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late bool _passwordVisible;
  void initState() {
    _passwordVisible = false;
  }

  final FirebaseAuthService _auth = FirebaseAuthService();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  void _signIn() async {
    String email = _emailTextController.text;
    String password = _passwordTextController.text;
    User? user = await _auth.signInWithEmailAndPassword(email, password);
    if (user != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please enter correct information.'),
            backgroundColor: Colors.white,
            actions: <Widget>[
              TextButton(
                child: Text(
                  'Close',
                  style: TextStyle(color: Colors.blue),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      print('Somer error happened');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Log in',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
            ),
          )),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(19.0),
            child: MaterialTextField(
              keyboardType: TextInputType.emailAddress,
              hint: 'Email',
              textInputAction: TextInputAction.next,
              prefixIcon: const Icon(Icons.email_outlined),
              controller: _emailTextController,
              validator: FormValidation.emailTextField,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(19.0),
            child: MaterialTextField(
              keyboardType: TextInputType.emailAddress,
              hint: 'Password',
              textInputAction: TextInputAction.done,
              obscureText: !_passwordVisible,
              // theme: FilledOrOutlinedTextTheme(
              //   // fillColor: Colors.green.withAlpha(50),
              //   radius: 12,
              // ),
              prefixIcon: Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
              controller: _passwordTextController,
              validator: FormValidation.requiredTextField,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _signIn();
                  },
                  child: Text(
                    'Log In',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Don\'t have an account?',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegsisterPage()));
              },
              child: Text(
                'Sign Up',
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ))
        ],
      ),
    );
  }
}
