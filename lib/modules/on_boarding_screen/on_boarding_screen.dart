import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shop_application/network/local/cache_helper.dart';
import 'package:shop_application/screens/shop_login_screen.dart';
import 'package:shop_application/widgets/on_boarding_list_view.dart';
import 'package:shop_application/widgets/widgets.dart';
import '../../app_cubit/app_cubit.dart';
import '../../screens/shop_layout.dart';

class OnBoardingScreen extends StatefulWidget {
  static String routeName = "/onBoardingScreen";
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    void submit() async {
      await CacheHelper.saveData(key: "onBoarding", value: true)
          .then((value) => {
                if (value)
                  {
                    navigationAndRemove(
                      context,
                      ShopLoginScreen.routeName,
                    )
                  }
                else
                  {
                    navigationAndRemove(
                      context,
                      ShopLayout.routeName,
                    )
                  }
              });
    }

    final cubit = BlocProvider.of<AppCubit>(context);
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            actions: [
              TextButton(
                onPressed: submit,
                child: Text(
                  "Skip",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.sp,
                  ),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const OnBoardingListView(),
                Row(
                  children: [
                    changeTo(
                      context,
                      () async {
                        cubit.previousPage(context);
                      },
                      Icons.arrow_back_ios,
                    ),
                    const Spacer(),
                    indicatorWidget(
                      cubit.pageController,
                      cubit.onBoardingItems.length,
                    ),
                    const Spacer(),
                    changeTo(
                      context,
                      () {
                        cubit.nextPage(submit, context);
                      },
                      Icons.arrow_forward_ios_outlined,
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.4.h,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
