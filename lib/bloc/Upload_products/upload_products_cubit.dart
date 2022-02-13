// @dart=2.9

// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:elomda/bloc/Upload_products/upload_products_state.dart';

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

  void addCategory(String title, String value, context) {
    txtAddCategory.text = '';
    categoryList.add(
      DropdownMenuItem(
        child: Text(title.toUpperCase()),
        value: value,
      ),
    );
    category = [];
    for (var element in categoryList) {
      category.add(element.value);
    }

    Navigator.pop(context);
    emit(UploadProductsAddCategoryState());
  }
}
