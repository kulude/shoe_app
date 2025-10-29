import 'package:flutter/material.dart';

class Utilities {
  void scaffoldMessanger(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text), duration: Duration(seconds: 3)),
    );
  }
}
