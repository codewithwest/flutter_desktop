import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import './login.dart';

signUp(context, mail, user, pwd, cpwd) async {
  // Check if email is valid.
  bool isValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(mail);
  String auth = "chatappauthkey231r4";
  // Check if email is valid
  if (isValid == true) {
    if (pwd == cpwd) {
      late IOWebSocketChannel channel;
      try {
        // Create connection.
        channel = IOWebSocketChannel.connect('ws://localhost:3000/signup$mail');
      } catch (e) {
        print("Error on connecting to websocket: $e");
      }
      // Data that will be sended to Node.js
      String signUpData =
          "{'auth':'$auth','cmd':'signup','email':'$mail','username':'$user','hash':'$cpwd'}";
      // Send data to Node.js
      channel.sink.add(signUpData);
      // listen for data from the server
      channel.stream.listen((event) async {
        event = event.replaceAll(RegExp("'"), '"');
        var signupData = json.decode(event);
        // Check if the status is successful
        if (signupData["status"] == 'succes') {
          // Close connection.
          channel.sink.close();
          // Return user to login if succesfull
          () {
            return Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const Login();
                },
              ),
            );
          };
        } else {
          channel.sink.close();
          print("Error signing signing up");
        }
      });
    } else {
      print("Password are not equal");
    }
  } else {
    print("email is false");
  }
}

class Signup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String? mail;
    String? user;
    String? pwd;
    String? cpwd;

    return Scaffold(
      appBar: AppBar(title: const Text("Signup.")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'Mail...',
              ),
              onChanged: (e) => mail = e,
            ),
          ),
          Center(
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Username..',
              ),
              onChanged: (e) => user = e,
            ),
          ),
          Center(
            child: TextField(
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                hintText: 'Password',
              ),
              onChanged: (e) => pwd = e,
            ),
          ),
          Center(
            child: TextField(
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                hintText: 'Confirm password',
              ),
              onChanged: (e) => cpwd = e,
            ),
          ),
          Center(
            child: MaterialButton(
              onPressed: (() {
                signUp(context, mail, user, pwd, cpwd);
              }),
              child: const Text("Sign up"),
            ),
          ),
        ],
      ),
    );
  }
}
