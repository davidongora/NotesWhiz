import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notes/onboarding/onboard/onboard.dart';
import 'package:notes/shared/buttons.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    // Set a timer to navigate to the next page after 3 seconds.
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const MyWidget()), // Replace with the next page.
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue,
              Colors.black,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: const Center(
          child: Splashtext(),
        ),
      ),
    );
  }
}

class Splashtext extends StatelessWidget {
  const Splashtext({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text(
        'NoteWhiz',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      const SizedBox(
        height: 8,
      ),
      Container(
        height: 6,
        width: MediaQuery.of(context).size.width * 0.5,
      ),
      const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Divider(
            height: 12,
          )
        ],
      ),
      SizedBox(
        height: 64,
      ),
      // Buttons(
      //   buttonText: 'Get Started',
      //   // buttonIcon: Icons.start_rounded,
      //   onPressed: () => {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => const MyWidget()),
      //     ),
      //   },
      // )
    ]);
  }
}
