import './login_or_signup.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

username() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? mail = prefs.getString('mail');

  return Text("Mail is: $mail");
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    logOut() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // Set loggedIn back to false
      prefs.setBool('loggedin', false);
      // Delete mail user.
      prefs.remove('mail');

      // Navigate to homepage.

      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (c, a1, a2) => const LoginOrSignup(),
          transitionsBuilder: (c, anim, a2, child) =>
              FadeTransition(opacity: anim, child: child),
          transitionDuration: const Duration(milliseconds: 200),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("You have successfully logged in!"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: FutureBuilder(
              future: username(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data.toString());
                } else {
                  return const Text("Mail is: undefined");
                }
              },
            ),
          ),
          Center(
            child: MaterialButton(
              child: const Text("Logout"),
              onPressed: () => logOut(),
            ),
          ),
        ],
      ),
    );
  }
}
