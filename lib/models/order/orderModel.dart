// @dart=2.9
import 'dart:convert';
import 'package:elomda/models/category/itemModel.dart';

class OrderModel {

  String createdDate;
  double totalAdditionalPrice;
  double totalDiscountPrice;
  double orderPrice;
  double totalPrice;
  int isDeleted;
  List<ItemModel> listItemModel;

  OrderModel(
      {
        this.orderPrice,
      this.createdDate,
      this.isDeleted,
      this.listItemModel,
      this.totalAdditionalPrice,
      this.totalDiscountPrice,
      this.totalPrice,
      });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> list = json['AdditionsList'] ?? [];

    var customList = list.map((e) => ItemModel.fromJson(e)).toList();

    return OrderModel(
        createdDate: json['createdDate'],
        isDeleted: json['isDeleted'],
        orderPrice: json['orderPrice'],
        totalAdditionalPrice: json['totalAdditionalPrice'] ?? 0,
        totalDiscountPrice: json['totalDiscountPrice'] ?? 0,
        totalPrice: json['totalPrice'] ?? 0,
        listItemModel: customList);
  }

  Map<String, dynamic> toJson() {
    return {
      'orderPrice': orderPrice,
      'createdDate': createdDate,
      'isDeleted': isDeleted,
      'totalAdditionalPrice': totalAdditionalPrice ?? 0,
      'totalDiscountPrice': totalDiscountPrice ?? 0,
      'totalPrice': totalPrice ?? 0,
      'listItemModel': listItemModel.map((e) => e.toJson())?.toList(),
    };
  }

  @override
  String toString() {
    return const JsonEncoder.withIndent(' ').convert(this);
  }
}
