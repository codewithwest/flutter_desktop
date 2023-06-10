import 'package:flutter/material.dart';
import './login.dart';
import './signup.dart';

class LoginOrSignup extends StatelessWidget {
  const LoginOrSignup({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    loginbut() {
      return Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return const Login();
        }),
      );
    }

    return Scaffold(
        body: Column(children: [
      Expanded(
          flex: 1,
          child: Container(
            margin: const EdgeInsets.all(5),
            width: width,
            height: height / 12,
            decoration: const BoxDecoration(
              color: Color.fromARGB(228, 72, 149, 4),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 36, 5, 237),
                  blurRadius: 2,
                ),
              ],
            ),
            child: const Center(
                child: Text(
              'WEST DYNAMICS',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            )),
          )),
      Container(),
      SizedBox(
        height: height - (height / 8),
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              MaterialButton(
                color: Color.fromARGB(225, 166, 12, 227),
                onPressed: loginbut,
                child: const Text("Login"),
              ),
              MaterialButton(
                color: Color.fromARGB(226, 34, 121, 150),
                child: const Text("Sign up"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return Signup();
                    }),
                  );
                },
              ),
            ])),
      ),
    ]));
  }
}
