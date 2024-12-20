import 'package:flutter/material.dart';
import 'package:notes/onboarding/Auth/Recover/forgot.dart';
import 'package:notes/shared/buttons.dart';
import 'package:notes/shared/fields.dart'; // Assuming InputField is defined in fields.dart

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(
                context); // This will pop the current screen and go back to the previous one
          },
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Text
              const Text(
                'Reset Password',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 34,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Create a new secure password',
                style: TextStyle(
                  // fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
 const SizedBox(height: 20),
              // Input Fields
              InputField(
                labelText: 'New Password',
                hintText: 'Enter your new password',
                obscureText: _obscureText,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(Icons.lock),
                                // onChanged: () {},

                suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText
                          ? Icons.visibility_off
                          : Icons.visibility, // Toggle icon
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText =
                            !_obscureText; // Toggle the obscureText state
                      });
                    }),
              ),
              // ),
              const SizedBox(height: 16),
              InputField(
                labelText: 'confirm Password',
                hintText: 'Enter your confirm password',
                controller: passwordController,
                obscureText: _obscureText,
                prefixIcon: const Icon(Icons.lock),
                                // onChanged: () {},

                suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText
                          ? Icons.visibility_off
                          : Icons.visibility, // Toggle icon
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText =
                            !_obscureText; // Toggle the obscureText state
                      });
                    }),
              ),
              const SizedBox(height: 32), // Add spacing before the button

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPasswordScreen()))
                    },
                  )
                ],
              ),
              // Bottom Login Button
              const Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    Buttons(
                      buttonText: 'Reset Password',
                      onPressed: () {
                        // Handle form submission
                        print('Email: ${emailController.text}');
                        print('Password: ${passwordController.text}');
                      },
                    ),
                    const SizedBox(height: 16),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     const Text(
                    //       "Don't have an account?",
                    //       style: TextStyle(color: Colors.white),
                    //     ),
                    //     const SizedBox(width: 4),
                    //     GestureDetector(
                    //       child: const Text(
                    //         'Sign Up',
                    //         style: TextStyle(
                    //           color: Colors.blue,
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //       ),
                    //       onTap: () => {
                    //         Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //                 builder: (context) => const SignupScreen()))
                    //       },
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
