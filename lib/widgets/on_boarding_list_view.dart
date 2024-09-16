import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shop_application/widgets/widgets.dart';

import '../app_cubit/app_cubit.dart';

class OnBoardingListView extends StatelessWidget {
  const OnBoardingListView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AppCubit>(context);
    return Expanded(
      flex: 5,
      child: PageView.builder(
        controller: cubit.pageController,
        itemCount: cubit.onBoardingItems.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 4.h,
              ),
              Text(
                cubit.onBoardingItems[index].title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 21.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Expanded(
                child: Image.asset(
                  cubit.onBoardingItems[index].image,
                  width: 80.w,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              subTitleText(context, cubit.onBoardingItems[index].subTitle)
            ],
          );
        },
      ),
    );
  }
}
