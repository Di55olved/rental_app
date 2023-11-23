// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:rental_app/Apis/api.dart';
import 'package:rental_app/Apis/user.dart';
import 'package:rental_app/Auth/sign_in.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();

  //Function to check for email domain
  static bool verifyEmail(String emailText) {
    String valv = "khi.iba.edu.pk";
    String valv2 = "iba.edu.pk";

    List<String> parts = emailText.split('@');

    if (parts.length >= 2) {
      if (parts[1] == valv || parts[1] == valv2) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }
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
  //OTP controller and Value
  TextEditingController otpController = TextEditingController();
  String otpValue = '';

  //Email OTP
  EmailOTP myOTP = EmailOTP();

  //Function to store the OTP
  void showPopup(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Enter OTP: "),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextField(
                      controller: otpController,
                      decoration: const InputDecoration(
                          label: Text("Enter OTP (check spam folder): "),
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
                    ElevatedButton(
                        onPressed: () async {
                          otpValue = otpController.text;
                          bool check = await myOTP.verifyOTP(otp: otpValue);

                          if (check == true) {
                            await Api.auth.createUserWithEmailAndPassword(
                                email: emailValue, password: passValue);
                            Users user = Users(
                                image: 'null',
                                balance: 0,
                                strikes: 0,
                                name: 'null',
                                id: Api.auth.currentUser!.uid,
                                email: Api.auth.currentUser!.email.toString(),
                                status: 'Active');

                            await Api.firestore
                                .collection('users')
                                .doc(Api.auth.currentUser!.uid)
                                .set(user.toJson());

                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => const SignInPage()));
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Invalid OTP, Try again"),
                              duration: Duration(seconds: 1),
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
                  if (SignUpPage.verifyEmail(emailController.text) != true) {
                    return 'Email not from IBA';
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
                        if (value != null && value.length < 8) {
                          return "Password should be atleast 8 characters long";
                        }
                        // Check if the password contains at least one digit
                        if (!value!.contains(RegExp(r'\d'))) {
                          return "Password should contain at least one digit";
                        }
                        // Check if the password contains at least one uppercase character
                        if (!value.contains(RegExp(r'[A-Z]'))) {
                          return "Password should contain at least one uppercase character";
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

                      if (SignUpPage.verifyEmail(emailValue)) {
                        if (passValue == confPassValue) {
                          myOTP.setConfig(
                              appEmail: "bh3082336888@gmail.com",
                              appName: "iRENT",
                              userEmail: emailValue,
                              otpLength: 4,
                              otpType: OTPType.digitsOnly);
                          if (await myOTP.sendOTP() == true) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Otp Sent"),
                              duration: Duration(seconds: 2),
                            ));
                            showPopup(context);
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Oops, OTP failed to send, retry"),
                              duration: Duration(seconds: 1),
                            ));
                          }
                        } else {
                          log("passwords don't match");
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Passwords don't match"),
                            duration: Duration(seconds: 2),
                          ));
                        }
                      } else {
                        log("Email not from IBA");
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Email not from IBA"),
                          duration: Duration(seconds: 2),
                        ));
                      }
                    } catch (e) {
                      log('$e');
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
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(color: Colors.white),
                  ),
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
