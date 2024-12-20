import 'package:flutter/material.dart';
import 'package:notes/onboarding/Auth/Recover/reset.dart';
import 'package:notes/shared/buttons.dart';

class errorPage extends StatelessWidget {
  const errorPage({super.key});

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
                    'Oops!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 34,
                    ),
                  ),
                  SizedBox(height: 18),
                  Text(
                    'You fall into an error',
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  SizedBox(height: 22),
                  Text(
                    'we are working hard to sort you out ',
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
                buttonText: 'Try again',
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
