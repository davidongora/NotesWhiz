import 'package:flutter/material.dart';
import 'package:notes/Notes/home.dart';
import 'package:notes/onboarding/onboard/onboard.dart';
import 'package:notes/onboarding/splash/splashscreen.dart';
import 'package:notes/profile/edit_profile.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await Hive.openBox('userDetails');
  // showHiveStructure();
  // InspectDb();
  describeBox('userDetails');
  runApp(const MyApp());
}

void showHiveStructure() {
  final boxNames = Hive.box('userDetails'); // List all open boxes
  print("Open Boxes: $boxNames[0]");
}

void InspectDb() {
  var boxes = Hive.box('userDetails');
  print(boxes);

  for (var key in boxes.keys) {
    print("Key: $key, Value: ${boxes.get(key)}");
  }
  ;
}

// void testFirebase() {
//   FirebaseAnalytics analytics = FirebaseAnalytics.instance;
//   analytics.logEvent(name: 'test_event', parameters: {'key': 'value'});
// }

void describeBox(String boxName) {
  var box = Hive.box(boxName);

  print("Box Name: $boxName");
  print("Number of Entries: ${box.length}");
  print("Keys: ${box.keys.toList()}");
  print("Values: ${box.values.toList()}");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NoteWhiz',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        // showde
      ),
      home: const FirstScreen(),
    );
  }
}
