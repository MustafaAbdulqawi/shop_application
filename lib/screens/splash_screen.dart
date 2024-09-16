import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shop_application/modules/on_boarding_screen/on_boarding_screen.dart';
import 'package:shop_application/network/local/cache_helper.dart';
import 'shop_login_screen.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
   await CacheHelper.init();
  bool ? isLoggedIn =  CacheHelper.getData(key: "isLoggedIn");

    Future.delayed(const Duration(seconds: 3), () {
      if (isLoggedIn == null || !isLoggedIn) {
        Navigator.pushNamedAndRemoveUntil(
            context, OnBoardingScreen.routeName, (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, ShopLoginScreen.routeName, (route) => false);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 6.w,
              ),
              Image.asset(
                'assets/pic_splash.png',
              ),
            ],
          ),
          SizedBox(
            height: 4.h,
          ),
          Text(
            "Shop App",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
