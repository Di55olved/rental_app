// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rental_app/Apis/api.dart';
import 'package:rental_app/Auth/sign_up.dart';
import 'package:rental_app/Screens/home_screen.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  //Email Controller and Value
  TextEditingController emailController = TextEditingController();
  String emailValue = '';
  //Password Controller and Value
  TextEditingController passController = TextEditingController();
  String passValue = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          //iRent Logo image
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Image(
              image: AssetImage("assets/iRent_brown.png"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              //Heading: Log In
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  "Log In",
                  style: TextStyle(
                    color: Color.fromARGB(255, 116, 80, 3),
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                //Space
                const SizedBox(
                  height: 40.0,
                ),
                //Email Text Field
                TextFormField(
                  controller: emailController,
                  autovalidateMode: AutovalidateMode.always,
                  validator: (value) {
                    if (value != null && value.length > 50) {
                      return 'Max length of 50 characters';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: "Email",
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 116, 80, 3))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 116, 80, 3))),
                  ),
                ),
                //Space
                const SizedBox(
                  height: 20.0,
                ),
                //Password Text Field
                TextFormField(
                  controller: passController,
                  obscureText: true,
                  autovalidateMode: AutovalidateMode.always,
                  validator: (value) {
                    if (value != null && value.length > 20) {
                      return 'Max length of 20 characters';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: "Password",
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 116, 80, 3))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 116, 80, 3))),
                  ),
                ),
                //Space
                const SizedBox(
                  height: 15.0,
                ),
                //Sign In Button
                SizedBox(
                  width: 400.0,
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: () async {
                      //Save credentials to Text Values
                      emailValue = emailController.text;
                      passValue = passController.text;
                      //Use FirebaseAuth.instance to sign in
                      try {
                        await Api.auth.signInWithEmailAndPassword(
                            email: emailValue, password: passValue);
                        //Navigate to HomeScreen if Sign In was successful
                        await Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                        );
                        //Display the exceptions
                      } on FirebaseAuthException catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              e.code == 'user-not-found'
                                  ? 'No user found for that email.'
                                  : e.code == 'wrong-password'
                                      ? 'Wrong password provided for that user.'
                                      : 'An error occurred: $e',
                            ),
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('An unexpected error occurred: $e'),
                          ),
                        );
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 255, 181, 22)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0)))),
                    child: const Text("Sign In"),
                  ),
                ),
                //Space
                const SizedBox(
                  height: 15.0,
                ),
                //Text Line: "Don't have an account? Sign Up"
                Row(
                  children: [
                    const Text("Don't have an account?"),
                    const SizedBox(
                      width: 3.0,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const SignUpPage()));
                      },
                      child: const Text(
                        "Sign Up",
                        style:
                            TextStyle(color: Color.fromARGB(255, 116, 80, 3)),
                      ),
                    )
                  ],
                ),
                //Space
                const SizedBox(
                  height: 15.0,
                ),
                //Text Line: "Forgot Password?"
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          TextEditingController forPass =
                              TextEditingController();
                          return AlertDialog(
                            title: const Text("Password Reset"),
                            actions: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    TextField(
                                      controller: forPass,
                                      decoration: const InputDecoration(
                                          label: Text("Enter Email: "),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0)),
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 116, 80, 3))),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0)),
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 116, 80, 3)))),
                                    ),
                                    ElevatedButton(
                                        onPressed: () async {
                                          String forPassValue = forPass.text;
                                          try {
                                            if (SignUpPage.verifyEmail(
                                                forPassValue)) {
                                              await Api.auth
                                                  .sendPasswordResetEmail(
                                                email: forPassValue,
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                content: Text(
                                                    "Password Reset Email Sent"),
                                                duration: Duration(seconds: 2),
                                              ));
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const SignInPage()));
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                content:
                                                    Text("Not an IBA Email"),
                                                duration: Duration(seconds: 1),
                                              ));
                                            }
                                          } on FirebaseAuthException catch (e) {
                                            log('$e');
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text("$e"),
                                              duration:
                                                  const Duration(seconds: 1),
                                            ));
                                          }
                                        },
                                        child: const Text("Submit")),
                                  ],
                                ),
                              )
                            ],
                          );
                        });
                  },
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(color: Color.fromARGB(255, 116, 80, 3)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
