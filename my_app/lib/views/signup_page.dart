import 'package:acr_cloud_sdk_example/reusable_widgets/reusable_widgets.dart';
import 'package:acr_cloud_sdk_example/utils/color_utils.dart';
import 'package:acr_cloud_sdk_example/views/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            hexStringToColor("CB2B93"),
            hexStringToColor("9546C4"),
            hexStringToColor("5E61F4")
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
              child: Padding(
            padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                logoWidget("assets/images/logo.png"),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Username", Icons.person_outline, false,
                    _userNameTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField(
                    "Email", Icons.person_outline, false, _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Password", Icons.lock_outlined, true,
                    _passwordTextController),
                const SizedBox(
                  height: 20,
                ),
                signInSignUpButton(context, false, () {
                  FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text)
                      .then((value) {
                    print("Create new account successfully");
                    users
                        .doc(_emailTextController.text)
                        .set({'username': _userNameTextController.text})
                        .then((value) => print("Data is added to firestore"))
                        .catchError((error) => print('Got error: $error'));
                    // users
                    //     .add({
                    //       'username': _userNameTextController.text,
                    //       'email': _emailTextController.text,
                    //       'uid': uid
                    //     })
                    //     .then((value) => print("Data is added to firestore"))
                    //     .catchError((error) => print('Got error: $error'));
                  }).onError((error, stackTrace) {
                    print("Error ${error.toString()}");
                  });

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                })
              ],
            ),
          ))),
    );
  }
}
