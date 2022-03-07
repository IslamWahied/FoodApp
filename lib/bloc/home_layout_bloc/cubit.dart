// @dart=2.9


import 'package:elomda/bloc/home_layout_bloc/state.dart';
import 'package:elomda/modules/cart/cart_screen.dart';
import 'package:elomda/modules/feeds/feeds_screen.dart';
import 'package:elomda/modules/home/home_screen.dart';
import 'package:elomda/modules/search/search_screen.dart';
import 'package:elomda/modules/user_info/user_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeLayoutCubit extends Cubit<HomeLayoutState> {
  HomeLayoutCubit() : super(HomeInitialState());

  static HomeLayoutCubit get(BuildContext context) => BlocProvider.of(context);



}
