// @dart=2.9

// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:elomda/bloc/Upload_products/upload_products_state.dart';
import 'package:elomda/bloc/home_bloc/HomeState.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  HomeScreenCubit() : super(HomeScreenStateInitState());

  static HomeScreenCubit get(context) => BlocProvider.of(context);

  List<String> carouselImage = [
    'assets/food3.jpeg',

  ];

}
