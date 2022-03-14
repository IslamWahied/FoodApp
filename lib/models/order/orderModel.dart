// @dart=2.9
import 'dart:convert';
import 'package:elomda/models/category/itemModel.dart';

class OrderModel {

  String userMobile;
  String adminMobile;
  String userName;


String departMent;
  String createdDate;
  double totalAdditionalPrice;
  double totalDiscountPrice;
  double orderPrice;
  double totalPrice;
  int isDeleted;
  String orderState;
  List<ItemModel> listItemModel;

  OrderModel(
      {
        this.userName,
        this.adminMobile,
        this.orderState,
        this.userMobile,
        this.orderPrice,
      this.createdDate,
      this.isDeleted,
      this.listItemModel,
      this.totalAdditionalPrice,
      this.totalDiscountPrice,
      this.totalPrice,
      this.departMent,
      });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> list = json['AdditionsList'] ?? [];

    var customList = list.map((e) => ItemModel.fromJson(e)).toList();

    return OrderModel(
        userName: json['userName'],
        orderState: json['orderState'],
        adminMobile: json['adminMobile'],
        userMobile: json['userMobile'],
        createdDate: json['createdDate'],
        isDeleted: json['isDeleted'],
        orderPrice: json['orderPrice'],
        departMent: json['departMent'],
        totalAdditionalPrice: json['totalAdditionalPrice'] ?? 0,
        totalDiscountPrice: json['totalDiscountPrice'] ?? 0,
        totalPrice: json['totalPrice'] ?? 0,
        listItemModel: customList);
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'userMobile': userMobile,
      'orderState': orderState,
      'adminMobile': adminMobile,
      'orderPrice': orderPrice,
      'departMent': departMent,
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
