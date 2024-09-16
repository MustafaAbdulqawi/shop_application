part of 'app_cubit.dart';

sealed class AppState {}

final class AppInitial extends AppState {}

final class AppChangeBottomNavBarState extends AppState {}

final class AppChangeToLeft extends AppState {}
final class AppChangeToRight extends AppState {}

final class ShopChangePasswordVisibilityState extends AppState {}

final class ShopLoginLoadingState extends AppState {}

final class ShopLoginSuccessState extends AppState {
  final ShopLoginModel loginModel;
  ShopLoginSuccessState({required this.loginModel});
}



final class ShopLoginErrorState extends AppState {
  final String error;

  ShopLoginErrorState({required this.error});
}
