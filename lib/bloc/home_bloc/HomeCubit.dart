// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elomda/bloc/Upload_products/upload_products_cubit.dart';
import 'package:elomda/bloc/Upload_products/upload_products_state.dart';
import 'package:elomda/bloc/home_bloc/HomeState.dart';
import 'package:elomda/models/category/SupCategory.dart';
import 'package:elomda/models/category/additionsModel.dart';

import 'package:elomda/models/category/categoryModel.dart';
import 'package:elomda/models/category/itemModel.dart';

import 'package:elomda/modules/category/subCategoryScreen.dart';
import 'package:elomda/modules/item/items.dart';
import 'package:elomda/shared/components/Componant.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class HomeCubit extends Cubit<HomeScreenState> {
  HomeCubit() : super(HomeScreenStateInitState());

  static HomeCubit get(context) => BlocProvider.of(context);
  int selectedCategoryId = 0;
  int selectedSubCategoryId = 0;
  int selectedItemId = 0;
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

  List<Category> listCategory = [];

   List<SubCategory> listSubCategory = [];
  List<SubCategory> listSubCategorySearch = [];

  List<ItemModel> listItems = [];
  List<ItemModel> listItemsSearch = [];

  List<ItemModel> listFeedsSearch = [];
  List<ItemModel> listOrder = [];

  List<AdditionsModel> listAdditions = [];



  TextEditingController txtSubCategoryControl = TextEditingController();
  TextEditingController txtItemControl = TextEditingController();
  TextEditingController txtFeedControl = TextEditingController();

String  getSumPrice(){
  double orderPrice = 0;
  for (var element in listOrder) {
    orderPrice += element.price;
    for (var element in element.additionsList) {
      orderPrice += element.price;
    }
    return orderPrice.toString();
  }






  }



  getCategory() async {
    FirebaseFirestore.instance.collection('Category').snapshots().listen((event) {
    listCategory = event.docs.map((x) => Category.fromJson(x.data())).toList();

    emit(SelectCategoryState());
  });
  }


  getSubCategory() async {
    FirebaseFirestore.instance.collection('SubCategory').snapshots().listen((event) {
      listSubCategory = event.docs.map((x) => SubCategory.fromJson(x.data())).toList();


      emit(SelectCategoryState());
    });
  }



  getItems() async {
    FirebaseFirestore.instance.collection('Items').snapshots().listen((event) {

      listItems = event.docs.map((x) => ItemModel.fromJson(x.data())).toList();
      listFeedsSearch = listItems;
      emit(SelectCategoryState());
    });
  }
 List<AdditionsModel> listOfSelectedAdditions = [];
  getAdditions() async {
    FirebaseFirestore.instance.collection('Additions').snapshots().listen((event) {

      listAdditions = event.docs.map((x) => AdditionsModel.fromJson(x.data())).toList();
      emit(SelectCategoryState());

    });
  }



  selectCategory(categoryId,context) async {
selectedSubCategoryId = 0;
selectedItemId = 0;
    selectedCategoryId = categoryId;

    listSubCategorySearch = listSubCategory.where((element) => element.categoryId == categoryId).toList();

    if(listSubCategorySearch.isNotEmpty){
      navigateTo(context,   subCategoryScreen(categoryTitle: listCategory.firstWhere((element) => element.categoryId == selectedCategoryId).categoryTitle,));
    }
    else{
      EasyLoading.showError('لا يوجد بيانات');
    }


    emit(SelectCategoryState());

  }

  selectSubCategory({supCategoryId,context}) async {


    selectedItemId = 0;
    selectedSubCategoryId = supCategoryId;


    listItemsSearch = listItems.where((element) => element.supCategoryId == supCategoryId).toList();
    emit(SelectCategoryState());
    if(listItemsSearch.isNotEmpty){
      txtSubCategoryControl.clear();
      listSubCategorySearch = listSubCategory.where((element) => element.categoryId == selectedCategoryId).toList();
      navigateTo(context,ItemsScreen(subcategoryTitle:listItems.firstWhere((element) => element.supCategoryId == supCategoryId).supCategoryTitle??''));
    }
    else{
      EasyLoading.showError('لا يوجد بيانات');
    }


    emit(SelectCategoryState());
  }

  searchInSupCategory(String value){
  
    if(value.trim() != ''){
      listSubCategorySearch = listSubCategory.where((element) =>   element.categoryId == selectedCategoryId   && element.subCategoryTitle.toLowerCase().contains(value.toLowerCase())).toList();
    }
    else{
      listSubCategorySearch = listSubCategory.where((element) => element.categoryId == selectedCategoryId).toList();
    }

    emit(SearchSubCategoryState());
  }
  searchInItems(String value){
    if(value.trim() != ''){
      listItemsSearch = listItems.where((element) =>   element.supCategoryId == selectedSubCategoryId  && element.itemTitle.toLowerCase().contains(value.toLowerCase())).toList();
    }
    else{
      listItemsSearch = listItems.where((element) => element.supCategoryId == selectedSubCategoryId).toList();
    }
    emit(SearchSubCategoryState());
  }


  searchInFeeds(String value){
    if(value.trim() != ''){
      listFeedsSearch = listItems.where((element) =>   element.itemTitle.toLowerCase().contains(value.toLowerCase())).toList();
    }
    else{
      listFeedsSearch = listItems.toList();
    }
    emit(SearchSubCategoryState());
  }


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
