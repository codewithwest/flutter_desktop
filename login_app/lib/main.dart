import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_or_signup.dart';
import 'homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // auto sign n from previous records
  autoLogin() async {
    //get pref instances
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // check if logged in
    bool? loggedIn = prefs.getBool('loggedin');
    // navigate conditionally
    if (loggedIn == true) {
      return MyHomePage();
    } else {
      return const LoginOrSignup();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
          colorScheme: const ColorScheme.dark(), useMaterial3: true),
      home: FutureBuilder(
          future: autoLogin(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.data != null) {
              return const LoginOrSignup();
            } else {
              return const LoginOrSignup();
            }
          }),
    );
  }
}
