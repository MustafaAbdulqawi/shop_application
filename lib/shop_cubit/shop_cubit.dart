import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shop_application/models/categories_model.dart';
import 'package:shop_application/models/change_favorites_model.dart';
import 'package:shop_application/models/favorites_model.dart';
import 'package:shop_application/models/home_model.dart';
import 'package:shop_application/models/login_model.dart';
import 'package:shop_application/network/end_points.dart';
import 'package:shop_application/network/remote/dio_helper.dart';
import 'package:shop_application/screens/categorey_screen.dart';
import 'package:shop_application/screens/favoriteScreen.dart';
import 'package:shop_application/screens/products_screen.dart';
import 'package:shop_application/screens/settings_screen.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitial());
  int currentIndex = 0;
  List<Widget> productScreens = [
    const ProductScreen(),
    const CategoryScreen(),
    const FavoriteScreen(),
    const SettingsScreen(),
  ];
  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  String isSuccessOne = "Loading";
  HomeModel? homeModel;
  Map<int, bool> favorites = {};
  void getHomeData() async {
    emit(ShopLoadingHomeDataState());
    isSuccessOne = "Loading";
    try {
      final data = await DioHelper.getData(
        url: "https://student.valuxapps.com/api/home",
        lang: "en",
        token: token ?? "",
      );
      ////

      homeModel = HomeModel.fromJson(data.data);
      homeModel!.data!.products?.forEach((element) {
        favorites.addAll(
          {element.id!: element.inFavorites!},
        );
        emit(ShopSuccessHomeDataState(homeModel!));
      });
      isSuccessOne = "Done";
      emit(ShopSuccessHomeDataState(homeModel!));
    } catch (e) {
      isSuccessOne = "Error";
      if (kDebugMode) {
        print(e);
      }
    }
    emit(ShopErrorHomeDataState());
  }

  String isSuccessTwo = "Loading";
  CategoriesModel? categories;
  void getCategories() async {
    isSuccessTwo = "Loading";
    emit(ShopLoadingCategoriesState());
    try {
      final data = await DioHelper.getData(
        url: "https://student.valuxapps.com/api/categories",
        lang: "en",
        token: token ?? "",
      );

      categories = CategoriesModel.fromJson(data.data);
      print(categories!.data.to);
      isSuccessTwo = "Done";
      emit(ShopSuccessCategoriesState(categories!));
    } catch (e) {
      isSuccessTwo = "Error";
      print(e);
    }
    emit(ShopErrorCategoriesState());
  }

  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int? productId) async {
    if (productId == null) {
      if (kDebugMode) {
        print('Product ID is null');
      }
      return;
    }

    try {
      if (favorites.containsKey(productId)) {
        favorites[productId] = !favorites[productId]!;
      } else {
        favorites[productId] = true;
        getFavorites();
        emit(ShopFavoritesState());
      }

      emit(ShopFavoritesState());

      final data = await DioHelper.postData(
        url: "https://student.valuxapps.com/api/favorites",
        data: {
          "product_id": productId,
        },
        token: token ?? "",
      );

      changeFavoritesModel = ChangeFavoritesModel.fromJson(data.data);
      if (changeFavoritesModel!.status == false) {
        favorites[productId] = !favorites[productId]!;
        emit(ShopSuccessFavoritesState(changeFavoritesModel!));
      } else {
        getFavorites();
        emit(ShopSuccessFavoritesState(changeFavoritesModel!));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      favorites[productId] = !favorites[productId]!;
      emit(ShopErrorFavoritesState());
    }
  }


  String isSuccessThree = "Loading";
  FavoritesModel? favoritesModel;
   getFavorites() async {
    isSuccessThree = "Loading";
    emit(ShopLoadingGetFavoritesState());
    try {
      final response = await DioHelper.getData(
        url: "https://student.valuxapps.com/api/favorites",
        lang: "en",
        token: token ?? "",
      );

      favoritesModel = FavoritesModel.fromJson(response.data??0);
      if (kDebugMode) {
        print(
          "is ${favoritesModel!.data?.data.first.product.price.toString()}");
      }
      isSuccessThree = "Done";
      emit(ShopSuccessGetFavoritesState());
    } catch (e) {
      isSuccessThree = "Error";
      if (kDebugMode) {
        print(e);
      }
      emit(ShopErrorGetFavoritesState());
    }
  }

  String isSuccessFour = "Loading";
  ShopLoginModel? shopLoginModel;
  void getUserData() async {
    emit(ShopLoadingGetFavoritesDataState());
    isSuccessFour = "Loading";
    try {
      final response = await DioHelper.getData(
        url: "https://student.valuxapps.com/api/profile",
        lang: "en",
        token: token ?? "",
      );
      shopLoginModel = ShopLoginModel.fromJson(response.data);
      emit(ShopSuccessGetFavoritesDataState(model: shopLoginModel!));
      isSuccessFour = "Done";
    } catch (e) {
      emit(ShopErrorGetFavoritesDataState());
      isSuccessFour = "Error";
      if (kDebugMode) {
        print(e);
      }
    }
  }


  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) async {
    emit(ShopLoadingGetUpdateDataState());
    isSuccessFour = "Loading";
    try {
      final response = await DioHelper.putData(
        url: "https://student.valuxapps.com/api/update-profile",
        lang: "en",
        token: token ?? "",
        data: {
          "name": name,
          "email": email,
          "phone": phone,
        },
      );
      shopLoginModel = ShopLoginModel.fromJson(response.data);
      emit(ShopSuccessGetUpdateDataState(model: shopLoginModel!));
      isSuccessFour = "Done";
    } catch (e) {
      emit(ShopErrorGetUpdateDataState());
      isSuccessFour = "Error";
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
