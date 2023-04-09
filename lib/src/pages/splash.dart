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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.teal,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            child: Column(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  // color: Colors.blue,
                  decoration: const BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.all(Radius.circular(5.8))),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Sign In",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Text(
                  "Access your account",
                  style: TextStyle(fontSize: 11),
                ),
                const TextField(
                  decoration: InputDecoration(hintText: "Enter Regd No."),
                ),
                const SizedBox(
                  height: 10,
                ),
                const TextField(
                  decoration: InputDecoration(hintText: "Enter Pass."),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {}, child: const Text("Sign In")))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
