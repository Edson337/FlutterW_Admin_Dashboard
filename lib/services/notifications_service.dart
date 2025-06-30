import 'package:flutter/material.dart';

class NotificationsService {
  static GlobalKey<ScaffoldMessengerState> messengerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackBarError(String message) {
    final snackBar = SnackBar(
      backgroundColor: Colors.red.withOpacity(0.8),
      content: Text(message, style: const TextStyle(color: Colors.white, fontSize: 20))
    );
    messengerKey.currentState!.showSnackBar(snackBar);
  }

  static showSnackBarSuccess(String message) {
    final snackBar = SnackBar(
      backgroundColor: Colors.green.withOpacity(0.8),
      content: Text(message, style: const TextStyle(color: Colors.black, fontSize: 20))
    );
    messengerKey.currentState!.showSnackBar(snackBar);
  }

  static showBusyIndicator(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.3),
      builder: (_) => const Center(
        child: CircularProgressIndicator(
          color: Colors.indigo,
          strokeWidth: 3.0,
        ),
      ),
    );
  }
}