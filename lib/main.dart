import 'package:flutter/material.dart';
import 'package:flutter_app_mydiaryfood/views/splash_screen_ui.dart';

main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashUI(),
      theme: ThemeData(
        fontFamily: 'Kanit',
      ),
    ),
  );
}
