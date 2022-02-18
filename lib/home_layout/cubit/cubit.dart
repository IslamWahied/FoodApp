// @dart=2.9
import 'package:elomda/home_layout/cubit/state.dart';
import 'package:elomda/modules/cart/cart_screen.dart';
import 'package:elomda/modules/feeds/feeds_screen.dart';
import 'package:elomda/modules/home/home_screen.dart';
import 'package:elomda/modules/search/search_screen.dart';
import 'package:elomda/modules/user_info/user_info_screen.dart';
import 'package:elomda/shared/network/local.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeLayoutCubit extends Cubit<HomeLayoutState> {
  HomeLayoutCubit() : super(HomeInitialState());

  static HomeLayoutCubit get(BuildContext context) => BlocProvider.of(context);

  int currentIndex = 0;
  List screens = [
    HomeScreen(),
    FeedsScreen(),
    SearchScreen(),
    CartScreen(),
    UserInfoScreen()
  ];

  void changecurrentIndex(int value) {
    currentIndex = value;
    emit(HomeChangeBottmNavState());
  }

  // Change Theme Mode

  bool isDarkTheme = false;

  void mode({bool fromShared}) {
    if (fromShared != null) {
      isDarkTheme = fromShared;
      emit(HomeChangeThemeState());
    } else {
      isDarkTheme = !isDarkTheme;
      Cash_Helpper.saveData(key: 'them', value: isDarkTheme).then((value) {
        emit(HomeChangeThemeState());
      });
    }
  }
}
