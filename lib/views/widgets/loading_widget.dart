 import 'package:flutter/material.dart';

Future<dynamic> loadingWidget(BuildContext context) {
    return showDialog(
          context: context,
          barrierDismissible: false, // Prevents dismissing the modal
          builder: (context) {
            return WillPopScope(
              onWillPop: () async => false,
              child: Center(
                child: CircularProgressIndicator(), // Loading indicator
              ),
            );
          },
        );
  }