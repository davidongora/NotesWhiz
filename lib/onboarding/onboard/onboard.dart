import 'dart:async';
import 'package:flutter/material.dart';
import 'package:notes/onboarding/Auth/login.dart';
import 'package:notes/shared/buttons.dart';
// import 'package:in_app_update/in_app_update.dart';


class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  late final PageController _pageController;
  int _currentPage = 0;
  // AppUpdateInfo? _updateInfo;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    // checkForUpdates();
    // Automatically switch pages every 3 seconds
  }

  // Future<void> checkForUpdates() async {
  //   try {
  //     _updateInfo = await inAppUpdate.checkForUpdate();

  //     if (_updateInfo.updateAvailability ==
  //         updateAvailability.updateAvailable) {
  //       await inAppUpdate.performImmediateUpdate();
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Failed to fetch updates')));
  //   }
  // }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Onboard',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        // leading: IconButton(
        //   icon: const Icon(
        //     Icons.arrow_back,
        //     color: Colors.white,
        //   ),
        //   onPressed: () {
        //     Navigator.pop(
        //         context); // This will pop the current screen and go back to the previous one
        //   },
        // ),
      ),
      // backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: const [
                FirstScreen(),
                SecondScreen(),
              ],
            ),
          ),
          //   Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: List.generate(
          //       2, // Number of screens
          //       (index) => AnimatedContainer(
          //         duration: const Duration(milliseconds: 300),
          //         margin: const EdgeInsets.symmetric(horizontal: 5),
          //         width: _currentPage == index ? 12 : 8,
          //         height: _currentPage == index ? 12 : 8,
          //         decoration: BoxDecoration(
          //           color: _currentPage == index ? Colors.blue : Colors.grey,
          //           shape: BoxShape.circle,
          //         ),
          //       ),
          //     ),
          //   ),
          //   const SizedBox(height: 16), // Add some spacing below the circles
        ],
      ),
    );
  }
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(
      //     'Dashboard',
      //     style: TextStyle(color: Colors.white),
      //   ),
      //   backgroundColor: Colors.black,
      //   leading: IconButton(
      //     icon: const Icon(
      //       Icons.arrow_back,
      //       color: Colors.white,
      //     ),
      //     onPressed: () {
      //       Navigator.pop(
      //           context); // This will pop the current screen and go back to the previous one
      //     },
      //   ),
      // ),
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
                    image: AssetImage('assets/rb.png'),
                  ),
                  SizedBox(height: 18),
                  Text(
                    'Plan your everyday tasks',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 34,
                    ),
                  ),
                  SizedBox(height: 18),
                  Text(
                    'Effortlessly organize your daily life and stay on top of tasks',
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
                buttonText: 'Next',
                buttonIcon: Icons.start_rounded,
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SecondScreen()),
                  ),
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Onboard',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        // leading: IconButton(
        //   icon: const Icon(
        //     Icons.arrow_back,
        //     color: Colors.white,
        //   ),
        //   onPressed: () {
        //     Navigator.pop(
        //         context); // This will pop the current screen and go back to the previous one
        //   },
        // ),
      ),
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
                    image: AssetImage('assets/rb_377.png'),
                  ),
                  SizedBox(height: 18),
                  Text(
                    'Capture & Organize notes in a seamless way',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 34,
                    ),
                  ),
                  SizedBox(height: 18),
                  Text(
                    'streamline your productivity by effortlessly capturing and organizing your ideas, thoughts into notes',
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
                buttonText: 'Get Started',
                buttonIcon: Icons.start_rounded,
                onPressed: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()))
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
