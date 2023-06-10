import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:login_app/homepage.dart';
//import 'login_or_signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';

login(BuildContext context, mail, pwd) async {
  String auth = "chatappauthkey231r4";
  if (mail.toString().isNotEmpty && pwd.toString().isNotEmpty) {
    late IOWebSocketChannel channel;
    try {
      // Create connection.
      channel = IOWebSocketChannel.connect('ws://127.0.0.1:3000/login$mail');
    } catch (e) {
      //
      print("Error on connecting to websocket: $e");
    }
    // Data that will be sent to Node.js
    String signUpData =
        "{'auth':'$auth','cmd':'login','email':'$mail','hash':'$pwd'}";
    // Send data to Node.js
    channel.sink.add(signUpData);
    // listen for data from the server
    channel.stream.listen((event) async {
      event = event.replaceAll(RegExp("'"), '"');
      var loginData = await json.decode(event);
      // Check if the status is successful

      if (loginData["status"] == 'succes') {
        // Close connection.
        channel.sink.close();

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('loggedin', true);
        prefs.setString('mail', mail);
        // Return user to login if successful

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );
      } else {
        channel.sink.close();
        print("Error signing signing up");
      }
    });
  } else {
    print("Password are not equal");
  }
}

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    String? mail;
    String? pwd;

    return Scaffold(
        appBar: AppBar(
            title: const Text(
          "Login",
          style: TextStyle(color: Colors.white),
        )),
        body: Center(
            child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Color.fromRGBO(225, 152, 6, .8),
            boxShadow: [BoxShadow(color: Colors.red, blurRadius: 2)],
            // border: Border.all(),
          ),
          width: 300,
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.email),
                    iconColor: Colors.red,
                    hintText: 'Mail or password..',
                  ),
                  onChanged: (e) => mail = e.toString(),
                ),
              ),
              Center(
                child: TextField(
                  // controller: ,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  selectionWidthStyle: BoxWidthStyle.tight,
                  selectionHeightStyle: BoxHeightStyle.strut,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.password),
                    iconColor: Color.fromARGB(255, 16, 126, 2),
                    hintText: 'Password..',
                  ),
                  onChanged: (e) => {pwd = e.toString()},
                ),
              ),
              Center(
                child: MaterialButton(
                  elevation: 3,
                  textColor: Colors.white,
                  color: const Color.fromRGBO(22, 22, 22, .6),
                  onPressed: (() {
                    login(context, mail, pwd);
                  }),
                  child: const Text("Login"),
                ),
              ),
            ],
          ),
        )));
  }
}
