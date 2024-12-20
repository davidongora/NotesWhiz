import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes/Notes/home.dart';
import 'package:notes/onboarding/Auth/Recover/forgot.dart';
import 'package:notes/onboarding/Auth/signup.dart';
import 'package:notes/shared/buttons.dart';
import 'package:notes/shared/fields.dart'; // Assuming InputField is defined in fields.dart

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;
  bool isButtonActive = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
 Hive.openBox('userDetails');
    // Add listeners
    emailController.addListener(() {
      // _validateEmail();
      _validateForm();
    });

    // nameController.addListener(_validateForm);
    passwordController.addListener(() {
      // _updatePasswordStrength();
      _validateForm();
    });
  }

  void _validateForm() {
    setState(() {
      isButtonActive = emailController.text.trim().isNotEmpty &&
          passwordController.text.trim().length >= 6;
    });
  }

  void login(String email, String password) async {
    var userDetailsBox = Hive.box('UserDetails');

    print(userDetailsBox.values);
    if (!userDetailsBox.containsKey(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User Not Found!! Sign Up')));
    } else {
      // var user = userDetailsBox.get(email);
      var user = Map<String, dynamic>.from(userDetailsBox.get(email));
      print(user);
      if (user['password'] == password) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('login Succesfull')));
        // Hive.openBox(email)
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home(user: user)));
        // print(user[1]);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid Password!')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Text
              const Text(
                'Ready to get productive? Login',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 34,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 60),

              // Input Fields
              InputField(
                labelText: 'Email',
                hintText: 'Enter your email',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(Icons.email),
              ),
              const SizedBox(height: 16),
              InputField(
                labelText: 'Password',
                hintText: 'Enter your password',
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
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ForgotPasswordScreen()))
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
                      buttonText: 'Login',
                      onPressed: isButtonActive
                          ? () {
                              String email = emailController.text.trim();
                              String password = passwordController.text.trim();
                              login(email, password);
                              // Handle form submission

                              // print('Email: ${emailController.text}');
                              // print('Password: ${passwordController.text}');
                            }
                          : null,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignupScreen()))
                          },
                        ),
                      ],
                    ),
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
