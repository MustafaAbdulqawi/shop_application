import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/models/login_model.dart';
import 'package:shop_application/network/remote/dio_helper.dart';

import '../models/on_boarding_item.dart';
part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  static AppCubit get(context) => BlocProvider.of(context);
  PageController pageController = PageController();
  List<OnBoardingItem> onBoardingItems = [
    OnBoardingItem(
        image:
            "assets/3d-casual-life-mirror-selfie-with-shopping-bags-and-new-jacket.png",
        title: "Welcome To Our Shop App",
        subTitle:
            "Browse through thousands of top-quality items at unbeatable prices."),
    OnBoardingItem(
      image: "assets/pic2.png",
      title: "Stay Connected Anywhere",
      subTitle:
          "Enjoy a seamless shopping experience from the comfort of your home.",
    ),
    OnBoardingItem(
        image: "assets/pic3.png",
        title: "Get Started with Us",
        subTitle: "Fast and secure payment options with doorstep delivery."),
  ];
  void nextPage(Function onDone, context) {
    if (pageController.page!.toInt() == 2) {
      onDone();
    } else {
      pageController.nextPage(
          duration: const Duration(seconds: 1), curve: Curves.ease);
    }
    emit(AppChangeToRight());
  }

  void previousPage(context) {
    if (pageController.page!.toInt() != 0) {
      pageController.previousPage(
          duration: const Duration(seconds: 1), curve: Curves.ease);
    }
    emit(AppChangeToLeft());
  }

  void userLogin({required String email, required String password}) async {
    emit(ShopLoginLoadingState());
    try {
      final response = await DioHelper.postData(
        url: "https://student.valuxapps.com/api/login",
        data: {
          "email": email,
          "password": password,
        },
      );
      ShopLoginModel shopLoginModel = ShopLoginModel.fromJson(response.data);
      emit(ShopLoginSuccessState(loginModel: shopLoginModel));
      if (kDebugMode) {
        print(shopLoginModel);
      }
    } catch (e) {
      emit(ShopLoginErrorState(error: e.toString()));
    }
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPasswordShow = true;
  void changePasswordVisibility() {
    isPasswordShow = !isPasswordShow;
    suffix = isPasswordShow
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;

    emit(ShopChangePasswordVisibilityState());
  }
}
