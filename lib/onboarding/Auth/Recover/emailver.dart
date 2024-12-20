import 'package:flutter/material.dart';
import 'package:notes/onboarding/Auth/Recover/reset.dart';
import 'package:notes/shared/buttons.dart';

class emailverification extends StatelessWidget {
  const emailverification({super.key});

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
                  SizedBox(height: 50), // For spacing at the top
                  Image(
                    image: AssetImage('assets/rb_2148530846.png'),
                  ),
                  SizedBox(height: 18),
                  Text(
                    'Access Confirmation',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 34,
                    ),
                  ),
                  SizedBox(height: 18),
                  Text(
                    'we have set a confirmation mail to username@email.com',
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  SizedBox(height: 22),
                  Text(
                    'Kindly check your inbox and click on the link to reset your password',
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
                buttonText: 'Reset Password',
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
