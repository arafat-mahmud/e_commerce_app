import 'dart:async';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:e_commerce_app/const/AppColors.dart';
import 'package:e_commerce_app/ui/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:e_commerce_app/const/AppColors.dart';
// import 'package:e_commerce_app/ui/login_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int currentIndexPage = 0;
  final int pageLength = 5;
  Timer? timer;

  @override
  void initState() {
    super.initState(); // Call super.initState() first

    // Initialize the timer
    timer = Timer.periodic(Duration(milliseconds: 500), (Timer timer) {
      setState(() {
        if (currentIndexPage < pageLength - 3) {
          currentIndexPage++;
        } else {
          timer.cancel(); // Stop the timer when reaching the last page
          Navigator.pushReplacement(
              context, CupertinoPageRoute(builder: (_) => LoginScreen()));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deep_orange,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "E-Commerce",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 32.sp),
              ),
              DotsIndicator(
                dotsCount: pageLength,
                position: currentIndexPage,
                decorator: DotsDecorator(
                  spacing: const EdgeInsets.all(12.0),
                  size: const Size.square(12.0),
                  activeSize: const Size(30.0, 12.0),
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
