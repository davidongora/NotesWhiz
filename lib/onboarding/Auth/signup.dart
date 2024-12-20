import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes/onboarding/Auth/login.dart';
import 'package:notes/shared/buttons.dart';
import 'package:notes/shared/fields.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;
  String passwordStrength = 'Too weak';
  String emailError = '';
  bool isButtonActive = false;
  final FocusNode emailFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    print('$isButtonActive, you button');

    // Add listeners
    emailController.addListener(() {
      _validateEmail();
      _validateForm();
      print('$isButtonActive, you button state on emai_');
    });

    nameController.addListener(_validateForm);
    passwordController.addListener(() {
      _updatePasswordStrength();
      _validateForm();
      print('$isButtonActive, you button state on pass_');
    });

    // Dispose focus node when the widget is removed
    emailFocusNode.addListener(() {
      setState(() {}); // Rebuild the widget tree when focus changes
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    super.dispose();
  }

  void _validateEmail() {
    final email = emailController.text.trim();
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    setState(() {
      if (email.isEmpty) {
        emailError = 'Email cannot be empty';
      } else if (!emailRegex.hasMatch(email)) {
        emailError = 'Enter a valid email address';
      } else {
        emailError = '';
      }
    });
  }

  void _updatePasswordStrength() {
    int length = passwordController.text.trim().length;

    setState(() {
      if (length == 0) {
        passwordStrength = 'Too weak';
      } else if (length < 6) {
        passwordStrength = 'Weak';
      } else if (length < 10) {
        _validateForm();
        passwordStrength = 'Moderate';
      } else {
        passwordStrength = 'Strong';
      }

      _validateForm();
    });
  }

  void _validateForm() {
    setState(() {
      isButtonActive = nameController.text.trim().isNotEmpty &&
          emailController.text.trim().isNotEmpty &&
          emailError.isEmpty &&
          passwordController.text.trim().length >= 6 &&
          passwordStrength != 'Too weak' &&
          passwordStrength != 'Weak';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Begin your notes taking adventure with us! Sign Up',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 34,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),
                InputField(
                  obscureText: false,
                  labelText: 'Name',
                  hintText: 'Enter your Name',
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  prefixIcon: const Icon(Icons.person),
                ),
                const SizedBox(height: 16),
                InputField(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.email),
                  errorText: emailError.isNotEmpty ? emailError : null,
                  focusNode: emailFocusNode,
                ),
                Text(
                  '$emailError',
                  style: TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 16),
                InputField(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  controller: passwordController,
                  obscureText: _obscureText,
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      // 'password strength $passwordStrength',
                      passwordStrength,
                      style: TextStyle(
                        color: passwordStrength == 'Too weak'
                            ? Colors.red
                            : passwordStrength == 'Weak'
                                ? Colors.orange
                                : passwordStrength == 'Moderate'
                                    ? Colors.orange
                                    : Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: [
                      Buttons(
                        buttonText: 'Sign Up',
                        onPressed: isButtonActive
                            ? () async {
                                var userDetailsBox = Hive.box('userDetails');

                                String email = emailController.text.trim();
                                String password =
                                    passwordController.text.trim();
                                String name = nameController.text.trim();

                                if (userDetailsBox.containsKey(email)) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'User already exists! Try logging in.')),
                                  );
                                  return;
                                }

                                // Add user to 'userDetails' box
                                await userDetailsBox.put(email, {
                                  'name': name,
                                  'email': email,
                                  'password': password,
                                  // 'profileImage': Image.asset('/assets/rb.png'),
                                  'profileImage': '/assets/rb.png',

                                  // 'default_image.png', // DRefault profile image
                                });

                                // Open user's personal boxes
                                var tasksBox =
                                    await Hive.openBox('${email}_tasks');
                                var notesBox =
                                    await Hive.openBox('${email}_notes');

                                // Add sample values to tasks box
                                await tasksBox.put('sampleTask1', {
                                  'title': 'Welcome Task',
                                  'description': 'This is your first task!',
                                  'completed': false,
                                  'createdAt': DateTime.now().toIso8601String(),
                                });

                                // Add sample values to notes box
                                await notesBox.put('sampleNote1', {
                                  'title': 'Welcome Note',
                                  'content': 'This is your first note!',
                                  'createdAt': DateTime.now().toIso8601String(),
                                });

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text('SignUp successful!'),
                                ));

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()),
                                );
                              }
                            : null,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account?",
                            style: TextStyle(color: Colors.white),
                          ),
                          const SizedBox(width: 4),
                          GestureDetector(
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()))
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
      ),
    );
  }
}
