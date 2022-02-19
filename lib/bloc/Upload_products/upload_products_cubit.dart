// @dart=2.9

// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elomda/bloc/Upload_products/upload_products_state.dart';
import 'package:elomda/shared/Global.dart';
import 'package:elomda/shared/network/local/helper.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class UploadProducts extends Cubit<UploadProductsState> {
  UploadProducts() : super(UploadProductsInitState());

  static UploadProducts get(context) => BlocProvider.of(context);

  // ignore: non_constant_identifier_names
  var UploadProduct_formKey = GlobalKey<FormState>();
  var txtUploadTitle = TextEditingController();
  var txtUploadPrice = TextEditingController();
  var txtUploadCategory = TextEditingController();
  var txtUploadBrand = TextEditingController();
  var txtUploadDescription = TextEditingController();
  var txtAddCategory = TextEditingController();



  // ignore: non_constant_identifier_names
  String CategoryValue;
  File finalPickedProductImage;

  void uploadPickImageCamera(context) async {
    final picker = ImagePicker();

    final pickedImage = await picker.getImage(source: ImageSource.camera);
    final pickedImageFile = File(pickedImage.path);
    finalPickedProductImage = pickedImageFile;

    emit(UploadProductsCameraUploadImageState());
  }

  // ignore: non_constant_identifier_names
  void UploadPickImageGallery(context) async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    final pickedImageFile = File(pickedImage.path);
    finalPickedProductImage = pickedImageFile;
    emit(UploadProductsGalleryUploadImageState());
  }

  void removeUploadImage(context) {
    finalPickedProductImage = null;

    emit(UploadProductsRemoveUploadImageState());
  }

  void selectCategory(String value) {
    CategoryValue = value;
    txtUploadCategory.text = value;
    emit(UploadProductsSelectCategoryState());
  }

  void uploadProduct() {}

  List<DropdownMenuItem<String>> categoryList = [];
  var addCategoryFormKey = GlobalKey<FormState>();
  bool inCategory = false;
  List<String> category = [];

  void addCategory( String value, context) {



    Category model =  Category(
        id: 1,
        image: '',
        isDeleted: 0,
        name: txtAddCategory.text,
        createdDate: DateTime.now().toString()
    );
    FirebaseFirestore.instance.doc('Categories').set(model.toMap()).then((value) {


      //
      // FirebaseFirestore.instance.collection('Categories').get().then((value) {
      // Category model =  Category(
      //   id: 1,
      //  image: '',
      //  isDeleted: 0,
      //  name: txtAddCategory.text,
      //  createdDate: DateTime.now().toString()
      // );

      // listCategory =   value.docs.map((x) => Category.fromJson(x.data())).toList();
      //
      // if(userModel.mobile != null)
      // {


      // }
      // else
      // {
    //    FirebaseFirestore.instance.collection('Categories').doc(Global.mobile).set(model.toMap()).then((value) {


        // }).catchError((e){
        //   if (kDebugMode) {
        //     print(e);
        //   }
        // });
    //  }




    //  }).catchError((error){
    // //
    // //   FirebaseFirestore.instance.collection('User').doc(Global.mobile).set(model.toMap()).then((value) {
    // //
    // //
    // //   }).catchError((e){
    // //     if (kDebugMode) {
    // //       print(e);
    // //     }
    //   });
      });



    Navigator.pop(context);
    emit(UploadProductsAddCategoryState());
  }

  int selectedTypeItemId = 1;

  int selectedCategoryId = 0;

  onChangeTypeItemId(int index){
    selectedTypeItemId = listItemTypeCategory[index].id;
    emit(onChangeTypeItemIdState());

  }

  List<Category> listCategory = [];


}
List<ListItemTypeCategory> listItemTypeCategory = [
  ListItemTypeCategory(id:1, name: 'Category'),
  ListItemTypeCategory(id:2,name: 'SupCategory'),
  ListItemTypeCategory(id:3,name: 'Product'),

];
class ListItemTypeCategory {
  String name;
  int id;
  ListItemTypeCategory({this.name,this.id});
}


class Category {
  String name;
  int id;
  int isDeleted;
  String createdDate;
  String image;
  Category({this.name,this.id,this.createdDate,this.image,this.isDeleted});

  Category.fromJson(Map<String, dynamic> json)
  {
    name = json['name'];
    id = json['id'];
    createdDate = json['createdDate'];
    image = json['image'];
    isDeleted = json['isDeleted'];
  }

  Map<String, dynamic> toMap()
  {
    return {

      'name':name,
      'id':id,
      'createdDate':createdDate,
      'image':image,
      'isDeleted':isDeleted

    };
  }


}




