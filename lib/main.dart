import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cashbek_client/auth/login.dart';
import 'package:cashbek_client/auth/registration.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF78379B)),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
            selectedItemColor: Color(0xFF78379B),
            unselectedItemColor: Color.fromRGBO(33, 6, 48, 0.35),
          ),
        ),
        initialRoute: '/login',
        getPages: [
          GetPage(
              name: '/login', page: () => Login(), transition: Transition.fade),
          GetPage(
              name: '/registration',
              page: () => Registration(),
              transition: Transition.fade),
        ]);
  }
}
