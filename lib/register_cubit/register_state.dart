part of 'register_cubit.dart';


sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterChangeBottomNavBarState extends RegisterState {}

final class RegisterChangeToLeft extends RegisterState {}
final class RegisterChangeToRight extends RegisterState {}

final class ShopChangePasswordVisibilityState extends RegisterState {}

final class ShopRegisterLoadingState extends RegisterState {}

final class ShopRegisterSuccessState extends RegisterState {
  final ShopLoginModel registerModel;
  ShopRegisterSuccessState({required this.registerModel});
}


final class ShopRegisterErrorState extends RegisterState {
  final String error;

  ShopRegisterErrorState({required this.error});
}

final class ShopLoginErrorState extends RegisterState {
  final String error;

  ShopLoginErrorState({required this.error});
}
