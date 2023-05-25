import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:risk_surveyor_app/screens/login/login.dart';
import 'package:risk_surveyor_app/utils/app_colors.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          title: 'OONA RISK SURVEYOR APPS',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primaryColor: AppColors.oonaPurple,
            fontFamily: 'OpenSans',
            colorScheme: const ColorScheme.light(
              primary: AppColors.oonaPurple, // <-- SEE HERE
              onPrimary: Colors.white, // <-- SEE HERE
              onSurface: Colors.black,
              onSecondary: Colors.white,
            ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: LoginPage(),
        );
      }
    );
  }
}
