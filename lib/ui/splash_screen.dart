import 'package:e_commerce_app/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
              Text('E-commerce App', style: TextStyle(color: Color.fromARGB(255, 255, 255, 255),fontWeight: FontWeight.bold, fontSize: 32.sp),),
              SizedBox(height: 16.sp),
              Text('Loading...', style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 18.sp),),
              SizedBox(height: 20.sp),
              CircularProgressIndicator(color: Colors.white,)
            ],
          ),
        ),
      ),
    );
  }
}