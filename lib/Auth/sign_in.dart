import 'package:flutter/material.dart';
import 'package:rental_app/Auth/sign_up.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Image(
              image: AssetImage("assets/iRent_brown.png"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
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
                const SizedBox(
                  height: 40.0,
                ),
                TextFormField(
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
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
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
                const SizedBox(
                  height: 15.0,
                ),
                SizedBox(
                  width: 400.0,
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 255, 181, 22)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0)))),
                    child: const Text("Sign In"),
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Row(
                  children: [
                    const Text("Don't have an account?"),
                    const SizedBox(
                      width: 3.0,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpPage()),
                        );
                      },
                      child: const Text(
                        "Sign Up",
                        style:
                            TextStyle(color: Color.fromARGB(255, 116, 80, 3)),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15.0,
                ),
                InkWell(
                  onTap: () {},
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(color: Color.fromARGB(255, 116, 80, 3)),
                  ),
                )
                // Add text input fields and login button here
              ],
            ),
          ),
        ],
      ),
    );
  }
}
