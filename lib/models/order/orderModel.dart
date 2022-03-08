// @dart=2.9

import 'dart:convert';
import 'package:elomda/models/category/itemModel.dart';

class OrderModel {

  String createdDate;


  int isDeleted;


  List<ItemModel> listItemModel;

  OrderModel( {

    this.createdDate,
    this.isDeleted,
    this.listItemModel,

  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> list = json['AdditionsList'] ?? [];

    var customList = list.map((e) => ItemModel.fromJson(e)).toList();

    return OrderModel(

        createdDate : json['createdDate'],
        isDeleted : json['isDeleted'],




        listItemModel: customList
    );
  }

  Map<String, dynamic> toJson() {
    return {

      'createdDate':createdDate,
      'isDeleted':isDeleted,




      'listItemModel': listItemModel.map((e) => e.toJson())?.toList(),
    };
  }


  @override
  String toString() {
    return const JsonEncoder.withIndent(' ').convert(this);
  }
}

