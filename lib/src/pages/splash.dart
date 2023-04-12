// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:counter/src/global.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'home/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  setCookie(response) {
    String rawCookie = response.headers['set-cookie']!;
    int index = rawCookie.indexOf(';');
    String refreshToken =
        (index == -1) ? rawCookie : rawCookie.substring(0, index);
    int idx = refreshToken.indexOf("=");
    if (kDebugMode) {
      print(refreshToken.substring(idx + 1).trim());
    }
    String cookieID = refreshToken.substring(idx + 1).trim();
    sharedPreferences.setString('cookie', cookieID);
  }

  loginUser() async {
    var response = await http.post(
        Uri.parse('http://115.240.101.71:8282/CampusPortalSOA/login'),
        body: json.encode({
          "username": username.text,
          "password": password.text,
          "MemberType": "S"
        }));
    var decoded = jsonDecode(response.body);
    print(decoded);
    if (decoded["status"].toString().contains("success")) {
      //cookie save
      setCookie(response);
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()));
      sharedPreferences.setBool("isAuthenticated", true);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(decoded["message"])));
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(decoded["message"])));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
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
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: username,
                  decoration: const InputDecoration(
                      hintText: "Enter Regd No.",
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: password,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: "Enter Pass.",
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide()),
                    focusedBorder: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      loginUser();
                    },
                    child: const Text("Sign In"),
                  ),
                ),
                const SizedBox(height: 30),
                // Row(
                //   children: [
                //     Expanded(
                //       child: Container(
                //         height: 1,
                //         width: 50,
                //         color: Colors.grey,
                //       ),
                //     ),
                //     const Text('or sign in with'),
                //     Expanded(
                //       child: Container(
                //         height: 1,
                //         width: 50,
                //         color: Colors.grey,
                //       ),
                //     ),
                //     const SizedBox(
                //       height: 10,
                //     ),
                //   ],
                // ),
                // const SizedBox(
                //   height: 20,
                // ),
                // SizedBox(
                //   width: double.infinity,
                //   child: ElevatedButton(
                //     onPressed: () {},
                //     child: const Text("Google"),
                //   ),
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                // SizedBox(
                //   width: double.infinity,
                //   child: ElevatedButton(
                //     onPressed: () {},
                //     child: const Text("Facebook"),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
