import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

const hostUrl = "https://cabinet.cashbek.uz";

BaseOptions options = BaseOptions(
  baseUrl: hostUrl,
  receiveDataWhenStatusError: true,
  connectTimeout: 20 * 1000, // 10 seconds
  receiveTimeout: 20 * 1000, // 10 seconds
);
var dio = Dio(options);

Future get(String url, {payload}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  try {
    final response = await dio.get(hostUrl + url,
        queryParameters: payload,
        options: Options(headers: {
          "authorization": "Bearer ${prefs.getString('access_token')}",
        }));
    return response.data;
  } on DioError catch (e) {
    statuscheker(e);
  }
}

Future post(String url, dynamic payload) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  try {
    final response = await dio.post(hostUrl + url,
        data: payload,
        options: Options(headers: {
          "authorization": "Bearer ${prefs.getString('access_token')}",
        }));
    return response.data;
  } on DioError catch (e) {
    statuscheker(e);
  }
}

Future guestPost(String url, dynamic payload) async {
  try {
    final response = await dio.post(hostUrl + url, data: payload);
    return response.data;
  } on DioError catch (e) {
    statuscheker(e);
  }
}

Future put(String url, dynamic payload) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  try {
    final response = await dio.put(hostUrl + url,
        data: payload,
        options: Options(headers: {
          "authorization": "Bearer ${prefs.getString('access_token')}",
        }));
    return response.data;
  } on DioError catch (e) {
    statuscheker(e);
  }
}

Future delete(String url) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print(url);
  try {
    final response = await dio.delete(hostUrl + url,
        options: Options(headers: {
          "authorization": "Bearer ${prefs.getString('access_token')}",
        }));
    print(response.statusCode);
    print(response.data);
    return response.data;
  } on DioError catch (e) {
    print(e.response?.statusCode);
    statuscheker(e);
  }
}

statuscheker(e) async {
  print(e.response?.statusCode);
  if (e.response?.statusCode == 400) {
    showErrorToast(e.message);
  }
  if (e.response?.statusCode == 401) {
    showErrorToast('???????????????????????? ?????????? ?????? ????????????');
  }
  if (e.response?.statusCode == 403) {}
  if (e.response?.statusCode == 404) {
    showErrorToast('???? ??????????????');
  }
  if (e.response?.statusCode == 415) {
    showErrorToast('????????????');
  }
  if (e.response?.statusCode == 500) {
    showErrorToast(e.message);
  }
}

showErrorToast(message) {
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: const Color(0xFFE32F45),
      textColor: Colors.white,
      fontSize: 16.0);
}
