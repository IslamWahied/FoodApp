// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elomda/bloc/Upload_products/upload_products_cubit.dart';
import 'package:elomda/bloc/Upload_products/upload_products_state.dart';
import 'package:elomda/bloc/home_bloc/HomeState.dart';
import 'package:elomda/models/category/SupCategory.dart';
import 'package:elomda/models/category/additionsModel.dart';

import 'package:elomda/models/category/categoryModel.dart';
import 'package:elomda/models/category/itemModel.dart';
import 'package:elomda/modules/cart/cart_screen.dart';

import 'package:elomda/modules/category/subCategoryScreen.dart';
import 'package:elomda/modules/feeds/feeds_screen.dart';
import 'package:elomda/modules/home/home_screen.dart';
import 'package:elomda/modules/item/items.dart';
import 'package:elomda/modules/search/search_screen.dart';
import 'package:elomda/modules/user_info/user_info_screen.dart';
import 'package:elomda/shared/Global.dart';
import 'package:elomda/shared/components/Componant.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class HomeCubit extends Cubit<HomeScreenState> {
  HomeCubit() : super(HomeScreenStateInitState());


  int currentIndex = 0;
  List screens = [
    const HomeScreen(),
    const FeedScreen(),
    SearchScreen(),
    const OrderScreen(isShowNavBar: false),
    UserInfoScreen()
  ];

  void changeCurrentIndex(int value) {
    currentIndex = value;

    emit(SearchSubCategoryState());
  }

  // Change Theme Mode

  bool isDarkTheme = false;

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
  List<ItemModel> popularFoodList = [];
  List<ItemModel> listItemsSearch = [];

  List<ItemModel> listFeedsSearch = [];
  List<ItemModel> listOrder = [];

  List<AdditionsModel> listAdditions = [];



  TextEditingController txtSubCategoryControl = TextEditingController();
  TextEditingController txtItemControl = TextEditingController();
  TextEditingController txtFeedControl = TextEditingController();

  getTotalPrice(){
  double orderPrice = 0;
  // for (var element in listOrder) {
  //   orderPrice += element.price;
  //   for (var element in element.additionsList) {
  //     orderPrice += element.price;
  //   }
  //   return orderPrice.toString();
  // }


  for (var element in listOrder) {
    for( int i = 0 ; i < element.orderCount; i++ ) {
      orderPrice += element.price;
      for (var element2 in element.additionsList) {
        orderPrice += element2.price;

      }
    }

  }

  return orderPrice.toString();

  }

 addNewItemToCartFromItemScreen({itemId,orderCount}){
    var newlist = listItemsSearch.firstWhere((element) => element.itemId == itemId);
    var model = ItemModel(
      orderCount:orderCount ,
      oldPrice:newlist.oldPrice ,
      itemTitle:newlist.itemTitle ,
      itemId: newlist.itemId,
      isPopular: newlist.isPopular,
      isDiscount:newlist.isDiscount ,
      isDeleted: newlist.isDeleted,
      isAvailable: newlist.isAvailable,
      image:newlist.image ,
      description:newlist.description ,
      createdDate:newlist.createdDate ,
      categoryTitle: newlist.categoryTitle,
      categoryId:newlist.categoryId ,
      additionsList: listOfSelectedAdditions.toList(),
      price:newlist.price ,
        supCategoryId:newlist.supCategoryId,

      supCategoryTitle:newlist.supCategoryTitle ,
      userMobile:newlist.userMobile ,
      userName: newlist.userName
    );
    listOrder.add(model);
    listOfSelectedAdditions = [];
   emit(SearchSubCategoryState());
 }

  addNewItemToCartFromHomeScreen({itemId,orderCount}){
    var newlist = popularFoodList.firstWhere((element) => element.itemId == itemId);
    var model = ItemModel(
        orderCount:orderCount ,
        oldPrice:newlist.oldPrice ,
        itemTitle:newlist.itemTitle ,
        itemId: newlist.itemId,
        isPopular: newlist.isPopular,
        isDiscount:newlist.isDiscount ,
        isDeleted: newlist.isDeleted,
        isAvailable: newlist.isAvailable,
        image:newlist.image ,
        description:newlist.description ,
        createdDate:newlist.createdDate ,
        categoryTitle: newlist.categoryTitle,
        categoryId:newlist.categoryId ,
        additionsList: listOfSelectedAdditions.toList(),
        price:newlist.price ,
        supCategoryId:newlist.supCategoryId,

        supCategoryTitle:newlist.supCategoryTitle ,
        userMobile:newlist.userMobile ,
        userName: newlist.userName
    );
    listOrder.add(model);
    listOfSelectedAdditions = [];
    emit(SearchSubCategoryState());
  }

  addNewItemToCartFromFeedsScreen({itemId,orderCount}){
    var newlist = listFeedsSearch.firstWhere((element) => element.itemId == itemId);
    var model = ItemModel(
        orderCount:orderCount ,
        oldPrice:newlist.oldPrice ,
        itemTitle:newlist.itemTitle ,
        itemId: newlist.itemId,
        isPopular: newlist.isPopular,
        isDiscount:newlist.isDiscount ,
        isDeleted: newlist.isDeleted,
        isAvailable: newlist.isAvailable,
        image:newlist.image ,
        description:newlist.description ,
        createdDate:newlist.createdDate ,
        categoryTitle: newlist.categoryTitle,
        categoryId:newlist.categoryId ,
        additionsList: listOfSelectedAdditions.toList(),
        price:newlist.price ,
        supCategoryId:newlist.supCategoryId,

        supCategoryTitle:newlist.supCategoryTitle ,
        userMobile:newlist.userMobile ,
        userName: newlist.userName
    );

    listOrder.add(model);
    listOfSelectedAdditions = [];
    emit(SearchSubCategoryState());
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
      popularFoodList = listItems.where((element) => element.isPopular).toList();
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

  addFavorite({int itemId}){
    // FirebaseFirestore.instance.collection('favorite').doc(Global.mobile).set(model.toMap()).then((value) {
    //
    //
    //
    // }).catchError((e){
    //   if (kDebugMode) {
    //     print(e);
    //   }
    // });


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
