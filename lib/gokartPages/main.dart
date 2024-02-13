import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pocketuse/gokartPages/pages/spashscreen.dart';

import 'AppTheme/my_behaviour.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MyApp());
  });
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GoKart',
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: child,
        );
      },
      theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: const Color(0xFF2874F0),
          // accentColor: const Color(0xFFFDE400),
          accentColor: Colors.blueAccent,
          primaryColorLight: const Color(0xFFFDE400),
          ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  static const routeName = '/MyHomePage';
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SplashScreen(),
    );
  }
}
