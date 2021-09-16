import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shareeflabs/contactus/contactus.dart';

import 'aboutus/aboutus.dart';
import 'home/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => MainBody(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/splashscreen.png"),
            fit: BoxFit.cover,
            // fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
  }
}

class MainBody extends StatefulWidget {
  const MainBody({Key key}) : super(key: key);

  @override
  _MainBodyState createState() => _MainBodyState();
}

typedef ExceptionCallback = void Function(dynamic exception);

class _MainBodyState extends State<MainBody> {
  int pageIndex = 0;
  List<Widget> pageList = [
    Home(),
    AboutUs(),
    ContactUs(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false, // <-- HERE
        showUnselectedLabels: false,
        backgroundColor: Color(0xFF025a9a),
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Color(0xFFc4daff),
              ),
              label: ''),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("images/about.png"),
              color: Color(0xFFc4daff),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("images/contact.png"),
              color: Color(0xFFc4daff),
            ),
            label: '',
          ),
        ],
        currentIndex: pageIndex,
        selectedItemColor: Colors.white,
        onTap: (value) {
          setState(() {
            pageIndex = value;
          });
        },
      ),
      body: pageList[pageIndex],
    );
  }
}
