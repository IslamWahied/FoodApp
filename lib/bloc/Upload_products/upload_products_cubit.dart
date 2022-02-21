// @dart=2.9

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elomda/models/category/SupCategory.dart';
import 'package:elomda/models/category/categoryModel.dart';
import 'package:elomda/shared/network/local/helper.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';

import 'upload_products_state.dart';

class UploadProducts extends Cubit<UploadProductsState> {
  UploadProducts() : super(UploadProductsInitState());

  static UploadProducts get(context) => BlocProvider.of(context);

  // ignore: non_constant_identifier_names
  var UploadProduct_formKey = GlobalKey<FormState>();
  var txtUploadTitle = TextEditingController();
  var txtUploadPrice = TextEditingController();
  var txtUploadCategory = TextEditingController();
  var txtUploadDescription = TextEditingController();

  List<DropdownMenuItem<String>> categoryList = [];
  var addCategoryFormKey = GlobalKey<FormState>();
  bool inCategory = false;
  List<String> category = [];
  List<Category> listCategory = [];
  List<SubCategory> listSubCategory = [];



  int selectedTypeItemId = 1;
  int selectedCategoryId = 0;
  int selectedSupCategoryId = 0;



  String categoryValue;
  File finalPickedProductImage;

restAfterUpload(){
  txtUploadTitle.text = '';
  if(selectedTypeItemId == 1)
    {
      listCategory = [];
    }

  isUploadValid  = false;

  selectedCategoryId = 0;
  finalPickedProductImage = null;
  checkIsUploadValid();
  emit(UploadProductsCameraUploadImageState());

}

bool isStartUpload = false;
  uploadCategory(context) {

  if(selectedTypeItemId == 1)
    {
      EasyLoading.show(status: 'Uploading...');

      FirebaseFirestore.instance.collection('Category').get().then((value) {

        listCategory = value.docs.map((x) => Category.fromJson(x.data())).toList();



        bool isNameFind = listCategory.any((element) => element.name == txtUploadTitle.text && element.isDeleted == 0);



        if(isNameFind){
          EasyLoading.showError('تمت الاضافة من قبل');
          // MotionToast.error(
          //   title: const Text("تمت الاضافة من قبل",style:TextStyle(fontWeight: FontWeight.bold)),
          //   width:  300,
          //   description: null,
          // ).show(context);

        }
        else{


          firebase_storage.FirebaseStorage.instance.ref()
              .child('Category/${Uri.file(finalPickedProductImage.path).pathSegments.last}')
              .putFile(finalPickedProductImage)
              .then((value) {

            value.ref.getDownloadURL().then((value) {
              //emit(SocialUploadProfileImageSuccessState());

              Category model =  Category(
                  createdDate: DateTime.now().toString(),
                  id:listCategory.isEmpty ? 1 :listCategory.length + 1 ,
                  image: value,
                  isDeleted:0 ,
                  name:txtUploadTitle.text
              );
              FirebaseFirestore.instance.collection('Category').doc(listCategory.isEmpty ? 1.toString() :(listCategory.length + 1).toString() ).set(model.toMap()).then((value) {

                restAfterUpload();
                EasyLoading.showSuccess('تمت الاضافة بنجاح!');

                // MotionToast.success(
                //   title: const Text("تمت الاضافة بنجاح",style:TextStyle(fontWeight: FontWeight.bold)),
                //   width:  300,
                //   description: null,
                // ).show(context);

               // isStartUpload = false;

              }).catchError((e){

                EasyLoading.dismiss();
              });
            }).catchError((e) {
              EasyLoading.dismiss();
            });
          }).catchError((e) {
            EasyLoading.dismiss();

          });


        }


      }).catchError((onError){

        EasyLoading.dismiss();


      });

    }
  if(selectedTypeItemId == 2)
    {
      EasyLoading.show(status: 'Uploading...');

      FirebaseFirestore.instance.collection('SubCategory').get().then((value) {

        listSubCategory = value.docs.map((x) => SubCategory.fromJson(x.data())).toList();



        bool isNameFind = listSubCategory.any((element) => element.name == txtUploadTitle.text);



        if(isNameFind){

          EasyLoading.showError('تمت الاضافة من قبل');
          // MotionToast.error(
          //   title: const Text("تمت الاضافة من قبل",style:TextStyle(fontWeight: FontWeight.bold)),
          //   width:  300,
          //   description: null,
          // ).show(context);

        }
        else{


          firebase_storage.FirebaseStorage.instance.ref()
              .child('SubCategory/${Uri.file(finalPickedProductImage.path).pathSegments.last}')
              .putFile(finalPickedProductImage)
              .then((value) {

            value.ref.getDownloadURL().then((value) {
              //emit(SocialUploadProfileImageSuccessState());

              SubCategory model =  SubCategory(
                  createdDate: DateTime.now().toString(),
                  categoryId:selectedCategoryId ,
                  supCategoryId: listSubCategory.isEmpty ? 1 :listSubCategory.length + 1 ,
                  image: value,
                  isDeleted:0 ,
                  categoryName: listCategory.firstWhere((element) => element.id == selectedCategoryId && element.isDeleted == 0).name,
                  name:txtUploadTitle.text
              );
              FirebaseFirestore.instance.collection('SubCategory').doc(listSubCategory.isEmpty ? 1.toString() :(listSubCategory.length + 1).toString() ).set(model.toMap()).then((value) {

                restAfterUpload();
              EasyLoading.showSuccess('تمت الاضافة بنجاح!');
                // MotionToast.success(
                //   title: const Text("تمت الاضافة بنجاح",style:TextStyle(fontWeight: FontWeight.bold)),
                //   width:  300,
                //   description: null,
                // ).show(context);
                isStartUpload = false;
              }).catchError((e){
                isStartUpload = false;


              });
            }).catchError((e) {
              EasyLoading.dismiss();

              // emit(SocialUploadProfileImageErrorState());
            });
          }).catchError((e) {
            EasyLoading.dismiss();

            //  emit(SocialUploadProfileImageErrorState());
          });



        }


      }).catchError((onError){

        EasyLoading.dismiss();


      });

    }
  if(selectedTypeItemId == 3)
  {
    EasyLoading.show(status: 'Uploading...');

    FirebaseFirestore.instance.collection('Items').get().then((value) {

      listSubCategory = value.docs.map((x) => SubCategory.fromJson(x.data())).toList();



      bool isNameFind = listSubCategory.any((element) => element.name == txtUploadTitle.text);



      if(isNameFind){

        EasyLoading.showError('تمت الاضافة من قبل');
        // MotionToast.error(
        //   title: const Text("تمت الاضافة من قبل",style:TextStyle(fontWeight: FontWeight.bold)),
        //   width:  300,
        //   description: null,
        // ).show(context);

      }
      else{


        firebase_storage.FirebaseStorage.instance.ref()
            .child('SubCategory/${Uri.file(finalPickedProductImage.path).pathSegments.last}')
            .putFile(finalPickedProductImage)
            .then((value) {

          value.ref.getDownloadURL().then((value) {
            //emit(SocialUploadProfileImageSuccessState());

            SubCategory model =  SubCategory(
                createdDate: DateTime.now().toString(),
                categoryId:selectedCategoryId ,
                supCategoryId: listSubCategory.isEmpty ? 1 :listSubCategory.length + 1 ,
                image: value,
                isDeleted:0 ,
                categoryName: listCategory.firstWhere((element) => element.id == selectedCategoryId && element.isDeleted == 0).name,
                name:txtUploadTitle.text
            );
            FirebaseFirestore.instance.collection('SubCategory').doc(listSubCategory.isEmpty ? 1.toString() :(listSubCategory.length + 1).toString() ).set(model.toMap()).then((value) {

              restAfterUpload();
              EasyLoading.showSuccess('تمت الاضافة بنجاح!');
              // MotionToast.success(
              //   title: const Text("تمت الاضافة بنجاح",style:TextStyle(fontWeight: FontWeight.bold)),
              //   width:  300,
              //   description: null,
              // ).show(context);
              isStartUpload = false;
            }).catchError((e){
              isStartUpload = false;


            });
          }).catchError((e) {
            EasyLoading.dismiss();

            // emit(SocialUploadProfileImageErrorState());
          });
        }).catchError((e) {
          EasyLoading.dismiss();

          //  emit(SocialUploadProfileImageErrorState());
        });



      }


    }).catchError((onError){

      EasyLoading.dismiss();


    });

  }





  }

  void uploadPickImageCamera(context) async {
    final picker = ImagePicker();

    final pickedImage = await picker.getImage(source: ImageSource.camera);
    final pickedImageFile = File(pickedImage.path);
    finalPickedProductImage = pickedImageFile;
    checkIsUploadValid();
    emit(UploadProductsCameraUploadImageState());
  }


  void uploadPickImageGallery(context) async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    final pickedImageFile = File(pickedImage.path);
    finalPickedProductImage = pickedImageFile;
    checkIsUploadValid();
    emit(UploadProductsGalleryUploadImageState());
  }

  void removeUploadImage(context) {
    finalPickedProductImage = null;
    checkIsUploadValid();
    emit(UploadProductsRemoveUploadImageState());
  }

  void selectCategory(String value) {
    categoryValue = value;
    txtUploadCategory.text = value;
    checkIsUploadValid();
    emit(UploadProductsSelectCategoryState());
  }

bool isUploadValid = false;
void checkIsUploadValid(){

    if(selectedTypeItemId == 1)
      {

        if(txtUploadTitle.text.trim() != '' &&txtUploadTitle.text.trim() != null && finalPickedProductImage != null ){
          isUploadValid = true;
        }
        else{
          isUploadValid = false;
        }

      }

   else if(selectedTypeItemId == 2)
    {

      if(
      txtUploadTitle.text.trim() != '' &&txtUploadTitle.text.trim() != null &&
          selectedCategoryId != 0 && selectedCategoryId != null &&  finalPickedProductImage != null

     ){
        isUploadValid = true;
      }
      else{
        isUploadValid = false;
      }

    }

    else if(selectedTypeItemId == 3)
    {

      if(
      txtUploadTitle.text.trim() != '' &&txtUploadTitle.text.trim() != null &&
          selectedCategoryId != 0 && selectedCategoryId != null && selectedSupCategoryId != 0&& selectedSupCategoryId != null &&
          txtUploadPrice.text.trim() != '' &&txtUploadPrice.text.trim() != null  && finalPickedProductImage != null &&
          listCategory.firstWhere((element) => element.id == selectedCategoryId).name.trim() != '' && listCategory.firstWhere((element) => element.id == selectedCategoryId && element.isDeleted == 0).name.trim() != null&&
          listSubCategory.firstWhere((element) => element.supCategoryId == selectedSupCategoryId).name.trim() != '' && listSubCategory.firstWhere((element) => element.supCategoryId == selectedSupCategoryId && element.isDeleted == 0).name.trim() != null

      ){
        isUploadValid = true;
      }
      else{
        isUploadValid = false;
      }

    }



    emit(UploadProductsSelectCategoryState());
}


List<SubCategory> listSubCategoryMaster;
getSubCategoryByCategoryId(id)
{
  listSubCategory = [];
  print(id);
  FirebaseFirestore.instance.collection('SubCategory').get().then((value) {

    listSubCategory = value.docs.map((x) => SubCategory.fromJson(x.data())).toList();

    listSubCategory = listSubCategory.where((element) => element.categoryId.toString() == id);

    emit(onChangeTypeItemIdState());
  });
}


  onChangeTypeItemId(int index){

    if(index == 1){
      FirebaseFirestore.instance.collection('Category').get().then((value) {

        listCategory = value.docs.map((x) => Category.fromJson(x.data())).toList();
        checkIsUploadValid();
        selectedTypeItemId = listItemTypeCategory[index].id;
        emit(onChangeTypeItemIdState());
      });



    }

    else if(index  == 2){

      FirebaseFirestore.instance.collection('Category').get().then((value) {

        listCategory = value.docs.map((x) => Category.fromJson(x.data())).toList();
        checkIsUploadValid();
        selectedTypeItemId = listItemTypeCategory[index].id;
        emit(onChangeTypeItemIdState());
      });
    }

    else{
      checkIsUploadValid();
      selectedTypeItemId = listItemTypeCategory[index].id;
      emit(onChangeTypeItemIdState());
    }
  }





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









