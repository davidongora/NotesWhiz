import 'package:flutter/material.dart';
import 'package:notes/onboarding/Auth/Recover/reset.dart';
import 'package:notes/shared/buttons.dart';

class Successpage extends StatelessWidget {
  const Successpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          const SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50),
                  Image(
                    image: AssetImage('assets/rb_7716.png'),
                  ),
                  SizedBox(height: 18),
                  Text(
                    'Suceess!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 34,
                    ),
                  ),
                  SizedBox(height: 18),
                  Text(
                    'Your account is successfully verified! We hope you to enjoy the adventure of notes-taking with us',
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  SizedBox(height: 22),
                  Text(
                    'Happy productivity!!',
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Buttons(
                buttonText: 'Dive in',
                buttonIcon: Icons.start_rounded,
                onPressed: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ResetPassword()))
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
