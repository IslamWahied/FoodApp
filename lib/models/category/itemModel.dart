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
  double price;
  String createdDate;
  int isDeleted;
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
      'AdditionsList': additionsList.map((e) => e.toMap())?.toList(),
    };
  }


  @override
  String toString() {
    return const JsonEncoder.withIndent(' ').convert(this);
  }
}

