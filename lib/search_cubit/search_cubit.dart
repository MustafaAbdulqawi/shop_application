import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:shop_application/models/search_model.dart';
import 'package:shop_application/network/remote/dio_helper.dart';

import '../network/end_points.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
  SearchModel? searchModel;
  void search(String text) async {
    emit(SearchLoadingState());
    try {
      final date = await DioHelper.postData(
        url: "https://student.valuxapps.com/api/products/search",
        token: token,
        data: {
          "text": text,
        },
      );
      searchModel = SearchModel.fromJson(date.data);
      if (kDebugMode) {
        print(searchModel!.data.data.first.name);
      }
      emit(SearchSuccessState());
      if (kDebugMode) {
        print("OK");
      }
    } catch (e) {
      emit(SearchErrorState());
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
