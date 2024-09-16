import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/login_model.dart';
import '../models/on_boarding_item.dart';
import '../network/remote/dio_helper.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  static RegisterCubit get(context) => BlocProvider.of(context);
  PageController pageController = PageController();
  List<OnBoardingItem> onBoardingItems = [
    OnBoardingItem(
        image: "assets/pic1.png",
        title: "Welcome To Our Shop Register",
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
    emit(RegisterChangeToRight());
  }

  void previousPage(context) {
    if (pageController.page!.toInt() != 0) {
      pageController.previousPage(
          duration: const Duration(seconds: 1), curve: Curves.ease);
    }
    emit(RegisterChangeToLeft());
  }

  ShopLoginModel? loginModel;
  void userRegister({
    required String email,
    required String password,
    required String phone,
    required String name,
  }) async {
    emit(ShopRegisterLoadingState());
    try {
      final data = await DioHelper.postData(
        url: "https://student.valuxapps.com/api/register",
        data: {
          "name": name,
          "password": password,
          "email": email,
          "phone": phone,
        },
      );
      loginModel = ShopLoginModel.fromJson(data.data);
      emit(ShopRegisterSuccessState(registerModel: loginModel!));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    emit(ShopRegisterSuccessState(registerModel: loginModel!));
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
