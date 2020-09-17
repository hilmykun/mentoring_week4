import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_week4/pages/pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => SplashPage()),
        GetPage(name: '/register', page: () => RegisterPage()),
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/main', page: () => MainPage()),
        GetPage(name: '/add', page: () => AddData()),
        GetPage(name: '/edit', page: () => EditData()),
        GetPage(name: '/detail', page: () => DetailData()),
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}
