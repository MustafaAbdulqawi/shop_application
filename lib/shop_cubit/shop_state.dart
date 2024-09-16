part of 'shop_cubit.dart';

sealed class ShopState {}

final class ShopInitial extends ShopState {}

final class ShopChangeBottomNavState extends ShopState {}

final class ShopLoadingHomeDataState extends ShopState {}

final class ShopSuccessHomeDataState extends ShopState {
  final HomeModel model;
  ShopSuccessHomeDataState(this.model);
}

final class ShopErrorHomeDataState extends ShopState {}

final class ShopLoadingCategoriesState extends ShopState {}

final class ShopSuccessCategoriesState extends ShopState {
  final CategoriesModel model;
  ShopSuccessCategoriesState(this.model);
}

final class ShopErrorCategoriesState extends ShopState {}

final class ShopSuccessFavoritesState extends ShopState {
  final ChangeFavoritesModel model;
  ShopSuccessFavoritesState(this.model);
}

final class ShopFavoritesState extends ShopState {}

final class ShopErrorFavoritesState extends ShopState {}

final class ShopLoadingGetFavoritesState extends ShopState {}

final class ShopSuccessGetFavoritesState extends ShopState {}

final class ShopErrorGetFavoritesState extends ShopState {}

final class ShopSuccessGetFavoritesDataState extends ShopState {
  final ShopLoginModel model;
  ShopSuccessGetFavoritesDataState({required this.model});
}

final class ShopLoadingGetFavoritesDataState extends ShopState {}

final class ShopErrorGetFavoritesDataState extends ShopState {}

///
final class ShopSuccessGetUpdateDataState extends ShopState {
  final ShopLoginModel model;
  ShopSuccessGetUpdateDataState({required this.model});
}

final class ShopLoadingGetUpdateDataState extends ShopState {}

final class ShopErrorGetUpdateDataState extends ShopState {}
