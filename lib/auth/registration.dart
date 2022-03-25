import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/api.dart';
import '../helpers/helper.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
} 

final _formKey = GlobalKey<FormState>();
dynamic sendData = {'username': '998994398808', 'password': '0777'};

login() async {
  final response = await guestPost('/auth/login', sendData);
  print(response);
  if (response['access_token'] != null) {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('access_token', response['access_token'].toString());
    prefs.setString('user', jsonEncode(sendData));
    final user = await get('/services/uaa/api/account');
    final userReport =
        await get('/services/gocashmobile/api/users-main-report');
    print(user);
    print(userReport);
    // for (var i = 0; i < user['authorities'].length; i++) {
    //   if (user['authorities'][i] == 'ROLE_USER') {
    Get.offAllNamed('/');
  }
}

class _RegistrationState extends State<Registration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: white,
        ),
        backgroundColor: white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(left: 20, right: 20),
          color: white,
          child: Stack(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 6),
                  child: Text('Добро пожаловать в',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.w600)),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Text('Cashbek',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.w600)),
                ),
                Container(
                  child: Text('Войдите, чтобы продолжить',
                      style: TextStyle(
                        color: grey,
                        fontSize: 12,
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(top: 120, left: 10, right: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.phone_iphone,
                          color: grey,
                        ),
                        contentPadding: EdgeInsets.all(18),
                        hintText: 'Номер телефона',
                        hintStyle: TextStyle(fontSize: 14)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'required_field'.tr;
                      }
                      return null;
                    },
                    initialValue: sendData['username'],
                    onChanged: (value) {
                      setState(() {
                        sendData['username'] = value;
                      });
                    },
                    keyboardType: TextInputType.number,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30, left: 10, right: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock, color: grey),
                      hintText: 'Пароль',
                      hintStyle: TextStyle(fontSize: 14),
                      contentPadding: EdgeInsets.all(18),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'required_field'.tr;
                      }
                      return null;
                    },
                    initialValue: sendData['password'],
                    onChanged: (value) {
                      setState(() {
                        sendData['password'] = value;
                      });
                    },
                    obscureText: true,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30, left: 10, right: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock, color: grey),
                      hintText: 'Пароль',
                      hintStyle: TextStyle(fontSize: 14),
                      contentPadding: EdgeInsets.all(18),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'required_field'.tr;
                      }
                      return null;
                    },
                    initialValue: sendData['password'],
                    onChanged: (value) {
                      setState(() {
                        sendData['password'] = value;
                      });
                    },
                    obscureText: true,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  alignment: Alignment.bottomCenter,
                  child: Text('Есть учетная запись?',
                      style: TextStyle(color: lightGrey)),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 15, left: 8),
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                      onTap: () {
                        Get.toNamed('/login');
                      },
                      child: Text('Войти',
                          style: TextStyle(color: Colors.black87))),
                ),
              ],
            ),
          ]),
        ),
      ),
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(bottom: 35, left: 32),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            // stops: [0.0, 1.0],
            colors: [
              pink,
              purple,
            ],
          ),
          boxShadow: const [
            BoxShadow(
                color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
          ],
        ),
        child: ElevatedButton(
            onPressed: () {
              login();
            },
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                primary: Colors.transparent,
                elevation: 0,
                shadowColor: null,
                onSurface: Colors.transparent),
            child: const Text(
              'Зарегистрироваться',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            )),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
