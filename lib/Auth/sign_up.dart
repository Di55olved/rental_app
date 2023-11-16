// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rental_app/Apis/api.dart';
import 'package:rental_app/Auth/sign_in.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  //Email Controller and Value
  TextEditingController emailController = TextEditingController();
  String emailValue = '';
  //Password Controller and Value
  TextEditingController passController = TextEditingController();
  String passValue = '';
  //Confirm Password Controller and Value
  TextEditingController confPassController = TextEditingController();
  String confPassValue = '';

  //Function to check for email domain
  bool verifyEmail(String emailText) {
    String valv = "khi.iba.edu.pk";
    String valv2 = "iba.edu.pk";

    List<String> parts = emailText.split('@');

    if (parts[1] == valv || parts[1] == valv2) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          //iRent Logo
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Image(
              image: AssetImage('assets/iRent_brown.png'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              //Heading: Sign Up
              const Text(
                "Sign Up",
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
              const SizedBox(height: 20.0),
              Row(
                children: [
                  //Password and Confirm Password Text Fields
                  Expanded(
                    child: TextFormField(
                      obscureText: true,
                      controller: passController,
                      autovalidateMode: AutovalidateMode.always,
                      validator: (value) {
                        if (value != null && value.length > 20) {
                          return "Max Character limit 20";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          label: Text("Password"),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 116, 80, 3))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 116, 80, 3)))),
                    ),
                  ),
                  //space
                  const SizedBox(width: 25.0),
                  Expanded(
                    child: TextFormField(
                      obscureText: true,
                      controller: confPassController,
                      autovalidateMode: AutovalidateMode.always,
                      validator: (value) {
                        if (value != null && value.length > 20) {
                          return "Max Character limit 20";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          label: Text("Confirm Password"),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 116, 80, 3))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 116, 80, 3)))),
                    ),
                  )
                ],
              ),
              //Space
              const SizedBox(
                height: 15.0,
              ),
              //Elevated Button: Sign Up
              SizedBox(
                width: 400.0,
                height: 50.0,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      emailValue = emailController.text;
                      passValue = passController.text;
                      confPassValue = confPassController.text;

                      if (verifyEmail(emailValue)) {
                        if (passValue == confPassValue) {
                          await Api.auth.createUserWithEmailAndPassword(
                              email: emailValue, password: passValue);
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const SignInPage()));
                        } else {
                          log("passwords don't match");
                        }
                      } else {
                        log("Email not from IBA");
                      }
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
                  child: const Text("Sign Up"),
                ),
              ),
              //Space
              const SizedBox(
                height: 15.0,
              ),
              Row(
                children: [
                  //Text Line: "Have an account? Log In"
                  const Text("Have an account?"),
                  const SizedBox(
                    width: 3.0,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignInPage()),
                      );
                    },
                    child: const Text(
                      "Log In",
                      style: TextStyle(color: Color.fromARGB(255, 116, 80, 3)),
                    ),
                  )
                ],
              ),
            ]),
          )
        ],
      ),
    );
  }
}
