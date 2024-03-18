import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:material_text_fields/labeled_text_field.dart';
import 'package:material_text_fields/material_text_fields.dart';
import 'package:material_text_fields/theme/material_text_field_theme.dart';
import 'package:material_text_fields/utils/form_validation.dart';
import 'package:signup_signin/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:signup_signin/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class RegsisterPage extends StatefulWidget {
  const RegsisterPage({super.key});

  @override
  State<RegsisterPage> createState() => _RegsisterPageState();
}

class _RegsisterPageState extends State<RegsisterPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  TextEditingController _userTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  late bool _passwordVisible;
  void initState() {
    _passwordVisible = false;
  }

  void dispose() {
    _userTextController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  void _signUp() async {
    String username = _userTextController.text;
    String email = _emailTextController.text;
    String password = _passwordTextController.text;
    User? user = await _auth.signUpWithEmailAndPassword(email, password);
    if (user != null) {
      print('User is succesfully created');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Sign Up',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
              ),
            )),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(19.0),
              child: MaterialTextField(
                keyboardType: TextInputType.name,
                hint: 'Username',
                textInputAction: TextInputAction.next,
                prefixIcon: const Icon(Icons.person),
                controller: _userTextController,
              ),
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
                    onPressed: () async {
                      _signUp();
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Already have an account?',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: Text(
                  'Log in',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ))
          ],
        ),
      ),
    );
  }
}
