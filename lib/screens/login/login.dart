import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:risk_surveyor_app/screens/svy/home_svy.dart';
import 'package:risk_surveyor_app/utils/app_colors.dart';
import 'package:sizer/sizer.dart';
import '../../model/pdf.dart';
import '../mkt/home_mkt.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String _userID;
  //late String _password;
  //var a = 200.w;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: 100.w,
          height: 100.h,
          padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Image.asset(
                    'assets/images/oona logo-horizontal with Insurance- oona purple on transparent.png',
                    width: (kIsWeb) ? 20.w : 50.w),
              ),
              //Text("Risk Surveyor Apps", style: TextStyle(fontSize: 5 * AppDimension.blockSizeHorizontal, color: AppColors.oonaPurple)),
              SizedBox(
                height: (kIsWeb) ? 15.h : 5.h,
                child: TextFormField(
                  style: TextStyle(fontSize: 11.sp),
                  decoration: const InputDecoration(
                      labelText: 'User ID',
                      labelStyle: TextStyle(color: AppColors.oonaPurple),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.oonaPurple, width: 2.0))),
                  onChanged: (value) {
                    setState(() {
                      _userID = value.trim();
                    });
                  },
                ),
              ),
              Gap(5.h),
              SizedBox(
                height: (kIsWeb) ? 15.h : 5.h,
                child: TextFormField(
                  style: TextStyle(fontSize: 11.sp),
                  decoration: const InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: AppColors.oonaPurple),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.oonaPurple, width: 2.0))),
                  obscureText: false,
                  onChanged: (value) {
                    setState(() {
                      //_password = value.trim();
                    });
                  },
                ),
              ),
              SizedBox(height: 2.h),
              SizedBox(
                height: (kIsWeb) ? 10.h : 5.h,
                width: 20.w,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.oonaPurple,
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 11.sp),
                  ),
                  onPressed: () async {
                    if (_userID == "marketing") {
                      Get.to(const Home());
                    } else if (_userID == "surveyor") {
                      //await pdf().generateExampleDocument();
                      Get.to(const HomeSVY());
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
