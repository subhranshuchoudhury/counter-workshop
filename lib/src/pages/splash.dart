// import 'package:counter/src/pages/two.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final TextEditingController regdNo = TextEditingController();
  final TextEditingController pass = TextEditingController();
  login() async {
    var response = await http.post(
        Uri.parse("http://115.240.101.71:8282/CampusPortalSOA/login"),
        body: jsonEncode({
          "username": regdNo.text,
          "password": pass.text,
          "MemberType": "S"
        }));
    print(response.body);
    // print("Input text: ${regdNo.text} ${pass.text}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: regdNo,
                decoration: const InputDecoration(hintText: "Regd No."),
              ),
              TextField(
                  controller: pass,
                  decoration: const InputDecoration(hintText: "Password")),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      login();
                    },
                    child: const Text("Login")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
