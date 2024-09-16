import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shop_application/app_cubit/app_cubit.dart';
import 'package:shop_application/network/end_points.dart';
import 'package:shop_application/register_cubit/register_cubit.dart';
import 'package:shop_application/screens/search_screen.dart';
import 'package:shop_application/screens/shop_layout.dart';
import 'package:shop_application/screens/shop_register_screen.dart';
import 'package:shop_application/search_cubit/search_cubit.dart';
import 'package:shop_application/shop_cubit/shop_cubit.dart';

import 'network/local/cache_helper.dart';
import 'screens/shop_login_screen.dart';
import 'modules/on_boarding_screen/on_boarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  Widget? widget;
  bool onBoarding = CacheHelper.getData(key: EndPoints.onBoarding) ?? false;
  token = CacheHelper.getData(key: EndPoints.token) ?? "";

  if (onBoarding) {
    if (token != false && token != "") {
      widget = const ShopLayout();
    } else {
      widget = const ShopLoginScreen();
    }
  } else {
    widget = const OnBoardingScreen();
  }
  if (kDebugMode) {
    print(onBoarding);
  }
  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.startWidget});
  final Widget startWidget;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit(),
        ),
        BlocProvider(
          create: (context) => ShopCubit()
            ..getHomeData()
            ..getCategories()
            ..getFavorites()
            ..getUserData(),
        ),
        BlocProvider(
          create: (context) => RegisterCubit(),
        ),
        BlocProvider(
          create: (context) => SearchCubit(),
        ),
      ],
      child: ResponsiveSizer(
        builder: (context, orientation, screenType) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Shop App',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            initialRoute: "/",
            routes: {
              "/": (context) => startWidget,
              "/onBoardingScreen": (context) => const OnBoardingScreen(),
              "/shop_login_screen": (context) => const ShopLoginScreen(),
              "/shop_register_screen": (context) => const ShopRegisterScreen(),
              "/shop_layout": (context) => const ShopLayout(),
              "/search_screen": (context) => const SearchScreen(),
            },
          );
        },
      ),
    );
  }
}
