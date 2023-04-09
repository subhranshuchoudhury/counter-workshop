import 'package:counter/src/pages/splash.dart';
import 'package:flutter/material.dart';

class Two extends StatelessWidget {
  const Two({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(MaterialPageRoute(
                  builder: (context) => const SplashScreen()));
            },
            child: const Text("Back")),
      ),
    );
  }
}
