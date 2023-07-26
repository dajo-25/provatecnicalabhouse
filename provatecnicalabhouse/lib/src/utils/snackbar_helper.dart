
import 'package:flutter/material.dart';

import '../config/app_colors.dart';
import '../config/app_localizations.dart';

class SnackBarHelper{


  static void showSnackBar({required BuildContext context, required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message)));
  }

  static void showErrorSnackBar({required BuildContext context, required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Color(0xFFE14F4D),
        content: Text(message)));
  }

  static void showSuccessSnackBar({required BuildContext context, required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Color(0xFF5EBD4E),
        content: Text(message)));
  }


}
