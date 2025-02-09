import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'landing_page.dart';
import 'login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('userBox');
  
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  Widget? _defaultHome;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    try {
      var box = Hive.box('userBox');
      bool isLoggedIn = box.get('loggedInUser') != null;

      setState(() {
        _defaultHome = isLoggedIn ? const LandingPage() : const LoginPage();
      });
    } catch (e) {
      debugPrint('Error accessing Hive box: $e');
      setState(() {
        _defaultHome = const LoginPage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _defaultHome ?? const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}