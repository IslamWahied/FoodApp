// @dart=2.9
import 'dart:convert';

import 'package:elomda/models/category/itemModel.dart';
import 'package:elomda/models/noteModel.dart';

class OrderModel {
  int orderId;
  String userMobile;
  String adminMobile;
  String userName;
  int projectId;
  String departMent;
  String createdDate;
  double totalAdditionalPrice;
  double totalDiscountPrice;
  double orderPrice;

  int isDeleted;
  String orderState;
  int orderCount;
  List<ItemModel> listItemModel;
  List<NoteModel> listNoteModel;

  OrderModel(
      {this.orderId,
      this.userName,
      this.adminMobile,
      this.orderState,
      this.userMobile,
      this.orderPrice,
      this.createdDate,
      this.isDeleted,
      this.listItemModel,
      this.listNoteModel,
      this.totalAdditionalPrice,
      this.totalDiscountPrice,
      this.departMent,
      this.orderCount,
      this.projectId});

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> listItemModel = json['listItemModel'] ?? [];
    List<dynamic> listNoteModel = json['listNoteModel'] ?? [];

    var customList = listItemModel.map((e) => ItemModel.fromJson(e)).toList();
    var customNoteList = listNoteModel.map((e) => NoteModel.fromJson(e)).toList();

    return OrderModel(
        orderId: json['orderId'],
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
        projectId: json['projectId'] ?? 1,
        orderCount: json['orderCount'] ?? 0,
        listItemModel: customList,
      listNoteModel: customNoteList
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
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
      'projectId': projectId ?? 1,
      'orderCount': orderCount ?? 0,
      'listItemModel': listItemModel.map((e) => e.toJson())?.toList(),
      'listNoteModel': listNoteModel.map((e) => e.toMap())?.toList(),
    };
  }

  @override
  String toString() {
    return const JsonEncoder.withIndent(' ').convert(this);
  }
}
