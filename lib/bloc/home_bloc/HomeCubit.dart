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
  int selectedFoodCard = 0;
  List  foodCategoryList = [
    {
      'imagePath': 'assets/pizza.svg',
      'name': 'Pizza',
    },
    {
      'imagePath': 'assets/sea-food.svg',
      'name': 'Seafood',
    },
    {
      'imagePath': 'assets/coke.svg',
      'name': 'Soft Drinks',
    },
    {
      'imagePath': 'assets/pizza.svg',
      'name': 'Pizza',
    },
  ];


 List  popularFoodList = [
    {
      'imagePath': 'assets/pizza.png',
      'name': 'Primavera Pizza',
      'weight': 'Weight 540 gr',
      'star': '5.0'
    },
    {
      'imagePath': 'assets/pizza-1.png',
      'name': 'Cheese Pizza',
      'weight': 'Weight 200 gr',
      'star': '4.5'
    },
    {
      'imagePath': 'assets/salad.png',
      'name': 'Healthy Salad',
      'weight': 'Weight 200 gr',
      'star': '4.5'
    },
    {
      'imagePath': 'assets/sandwhich.png',
      'name': 'Grilled Sandwhich',
      'weight': 'Weight 250 gr',
      'star': '4.0'
    },
    {
      'imagePath': 'assets/chowmin.png',
      'name': 'Cheese Chowmin',
      'weight': 'Weight 500 gr',
      'star': '4.0'
    },
  ];

  List  ingredients = [
    {
      'imagePath': 'assets/tomato.png',
    },
    {
      'imagePath': 'assets/onion.png',
    },
    {
      'imagePath': 'assets/tomato.png',
    },
    {
      'imagePath': 'assets/onion.png',
    },
    {
      'imagePath': 'assets/tomato.png',
    },
    {
      'imagePath': 'assets/onion.png',
    },
  ];


}
