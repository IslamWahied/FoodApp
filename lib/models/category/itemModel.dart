// @dart=2.9

import 'dart:convert';

import 'additionsModel.dart';

class ItemModel {
  String itemTitle;
  String userMobile;
  String userName;
  int categoryId;
  int itemId;
  int supCategoryId;
  String categoryTitle;
  String description;
  String supCategoryTitle;
  String image;
  String createdDate;
  double price;
  int isDeleted;
  double oldPrice;
  int orderCount;
  bool isAvailable;
  bool isPopular;
  bool isDiscount;
  bool isFavourite;
  String orderState;
  int projectId;



  List<AdditionsModel> additionsList;

  ItemModel( {
    this.itemTitle,
    this.userMobile,
    this.userName,
    this.itemId,
    this.categoryId,
    this.supCategoryId,
    this.categoryTitle,
    this.description,
    this.supCategoryTitle,
    this.image,
    this.price,
    this.createdDate,
    this.isDeleted,
    this.additionsList,
    this.orderCount,
    this.isAvailable,
    this.isPopular,
    this.isDiscount,
    this.oldPrice,
    this.isFavourite,
    this.orderState,
    this.projectId
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> list = json['AdditionsList'] ?? [];

    var customList = list.map((e) => AdditionsModel.fromJson(e)).toList();

    return ItemModel(

      itemTitle : json['itemTitle'],
        categoryId : json['categoryId'],
        itemId : json['itemId'],
        supCategoryId : json['supCategoryId'],
        categoryTitle : json['categoryTitle'],
        description : json['description']??'',
        supCategoryTitle : json['supCategoryTitle'],
        image : json['image'],
        price : json['price'],
        createdDate : json['createdDate'],
        isDeleted : json['isDeleted'],
        userMobile : json['userMobile']??'',
        userName : json['userName']??'',
        orderState : json['orderState']??'New',
        orderCount : json['orderCount']??0,
        isAvailable : json['isAvailable']??true,
        isPopular : json['isPopular']??false,
        isDiscount : json['isDiscount']??false,
        isFavourite : json['isFavourite']??false,
        oldPrice : json['oldPrice']??0,
        projectId : json['projectId']??1,

      additionsList: customList
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'itemTitle':itemTitle,
      'categoryId':categoryId,
      'itemId':itemId,
      'supCategoryId':supCategoryId,
      'categoryTitle':categoryTitle,
      'description':description??'',
      'supCategoryTitle':supCategoryTitle,
      'image':image,
      'price':price,
      'createdDate':createdDate,
      'isDeleted':isDeleted,
      'userMobile':userMobile??'',
      'userName':userName??'',

      'orderCount':orderCount??0,
      'oldPrice':oldPrice??0,
      'isAvailable':isAvailable??true,
      'isPopular':isPopular??false,
      'isFavourite':isFavourite??false,
      'isDiscount':isDiscount??false,
      'orderState':orderState??'New',
      'projectId':projectId??1,



      'AdditionsList': additionsList.map((e) => e.toMap())?.toList(),
    };
  }


  @override
  String toString() {
    return const JsonEncoder.withIndent(' ').convert(this);
  }
}

