import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

// Colors

Color black = const Color(0xFF210630);
Color purple = const Color(0xFF78379B);
Color pink = const Color(0xFFF03291);
Color white = const Color(0xFFFFFFFF);
Color red = const Color(0xFFdc3545);
Color blue = const Color(0xFF17a2b8);
Color grey = const Color(0xFF838488);
Color lightGrey = const Color(0xFF9C9C9C);
Color borderColor = const Color(0xFFF8F8F8);

Color success = const Color(0xFF34c38f);
Color warning = const Color(0xFFf1b44c);
Color danger = const Color(0xFFf46a6a);

formatMoney(amount) {
  if (amount != null && amount != "") {
    amount = double.parse(amount.toString());
    return NumberFormat.currency(symbol: '', decimalDigits: 0, locale: 'UZ').format(amount);
  } else {
    return NumberFormat.currency(symbol: '', decimalDigits: 0, locale: 'UZ').format(0);
  }
}

showSuccessToast(message) {
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: const Color(0xFF28a745),
      textColor: Colors.white,
      fontSize: 16.0);
}
