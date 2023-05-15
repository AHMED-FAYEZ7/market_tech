import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_tech/modules/search/cubit/states.dart';

import '../../../models/search_model.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote/dio_helper.dart';

class AppSearchCubit extends Cubit<AppSearchState> {
  AppSearchCubit() : super(AppSearchInitialState());
  static AppSearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;

  void search(String? text) {
    emit(AppSearchLoadingState());
    DioHelper.postData(
      url: SEARCH,
      // token: token,
      data: {
        'text': text,
      },
    ).then((value) {
      model = SearchModel.fromJson(value.data);
      emit(AppSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AppSearchErrorState());
    });
  }
}
