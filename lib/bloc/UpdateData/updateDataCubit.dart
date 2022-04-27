// @dart=2.9
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elomda/bloc/UpdateData/updateDataState.dart';
import 'package:elomda/bloc/home_bloc/HomeCubit.dart';
import 'package:elomda/models/category/SupCategory.dart';
import 'package:elomda/models/category/additionsModel.dart';
import 'package:elomda/models/category/categoryModel.dart';
import 'package:elomda/models/category/itemModel.dart';
import 'package:elomda/shared/Global.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:image_picker/image_picker.dart';
 

class UpdateDataCubit extends Cubit<UploadDataState> {
  UpdateDataCubit() : super(UploadDataStateInitState());

  static UpdateDataCubit get(context) => BlocProvider.of(context);




  // ignore: non_constant_identifier_names
  var UploadProduct_formKey = GlobalKey<FormState>();
  var txtUploadTitle = TextEditingController();
  var txtUploadPrice = TextEditingController();
  var txtUploadOldPrice = TextEditingController();
  var txtUploadCategory = TextEditingController();
  var txtUploadDescription = TextEditingController();

  List<DropdownMenuItem<String>> categoryList = [];
  var addCategoryFormKey = GlobalKey<FormState>();
  bool inCategory = false;
  List<String> category = [];

  List<AdditionsModel> listOfSelectedAdditions = [];



  int selectedTypeItemId = 1;
  int selectedCategoryId = 0;
  int selectedSupCategoryId = 0;

  bool isAvailable = true;
  bool isPopular = false;
  bool isDiscount = false;
  double oldPrice = 0;

  String categoryValue;
  File finalPickedProductImage;

  restAfterUpload(context) {
    txtUploadTitle.text = '';
    txtUploadPrice.text = '';
    txtUploadOldPrice.text = '';

    selectedSupCategoryId = 0;
    selectedCategoryId = 0;
    selectAdditionId = 0;
    selectItemId = 0 ;

    txtUploadDescription.text = '';
    finalPickedProductImage = null;
    isDiscount = false;
    isAvailable = false;
    isPopular = false;
    prodeuctImageUrl = '';

    isUploadValid = false;
    listOfSelectedAdditions = [];



    checkIsUploadValid(context);
     emit(refershState());
  }

  changeIsAvailableState({bool value})
  {
    isAvailable = value;
     emit(refershState());
  }

  changeIsPopular({bool value})
  {
    isPopular = value;
      emit(refershState());
  }

  changeIsDiscount({bool value})
  {
    isDiscount = value;
      emit(refershState());
  }


  bool isOldPrice = false;
  changeIsOldPrice({bool value})
  {
    isOldPrice = value;
      emit(refershState());
  }


  bool isStartUpload = false;
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
  uploadCategory(context) {

    if(finalPickedProductImage != null){
      if (selectedTypeItemId == 1 && isUploadValid) {
        EasyLoading.show(status: 'Uploading...');



        firebase_storage.FirebaseStorage.instance
            .ref()
            .child(
            'Category/${Uri.file(finalPickedProductImage.path).pathSegments.last}')
            .putFile(finalPickedProductImage)
            .then((value) {
          value.ref.getDownloadURL().then((value) {
            emit(refershState());

            CategoryModel model = CategoryModel(
                createdDate: DateTime.now().toString(),
                categoryId: selectedCategoryId,
                image: value,
                isDeleted: 0,
                isAvailable: isAvailable,
                categoryTitle:  txtUploadTitle.text
            );
            FirebaseFirestore.instance.collection('Category').doc(selectedCategoryId.toString()).update(model.toMap())
                .then((value) {
              restAfterUpload(context);
              EasyLoading.showSuccess('تمت الاضافة بنجاح!');

            }).catchError((e) {
              EasyLoading.dismiss();
            });
          }).catchError((e) {
            EasyLoading.dismiss();
          });
        }).catchError((e) {
          EasyLoading.dismiss();
        });
        // }


      }
      else if (selectedTypeItemId == 2 && isUploadValid) {
        EasyLoading.show(status: 'Uploading...');



        firebase_storage.FirebaseStorage.instance
            .ref()
            .child(
            'SubCategory/${Uri.file(finalPickedProductImage.path).pathSegments.last}')
            .putFile(finalPickedProductImage)
            .then((value) {
          value.ref.getDownloadURL().then((value) {


            SubCategory model = SubCategory(
                createdDate: DateTime.now().toString(),
                categoryId: HomeCubit.get(context).listSubCategory.firstWhere((element) => element.supCategoryId == selectedSupCategoryId && element.isDeleted == 0).categoryId,
                supCategoryId: selectedSupCategoryId,
                image: value,
                isDeleted: 0,
                isAvailable: isAvailable,
                categoryTitle:  HomeCubit.get(context).listSubCategory.firstWhere((element) => element.supCategoryId == selectedSupCategoryId && element.isDeleted == 0).categoryTitle,

                subCategoryTitle: txtUploadTitle.text
            );
            FirebaseFirestore.instance
                .collection('SubCategory')
                .doc(selectedSupCategoryId.toString())
                .update(model.toMap())
                .then((value) {
              restAfterUpload(context);
              EasyLoading.showSuccess('تمت الاضافة بنجاح!');

              isStartUpload = false;
            }).catchError((e) {
              isStartUpload = false;
            });
          }).catchError((e) {
            EasyLoading.dismiss();


          });
        }).catchError((e) {
          EasyLoading.dismiss();


        });



      }
      else if (selectedTypeItemId == 3 && isUploadValid) {



        EasyLoading.show(status: 'Uploading...');



        firebase_storage.FirebaseStorage.instance
            .ref()
            .child('Items/${Uri.file(finalPickedProductImage.path).pathSegments.last}')
            .putFile(finalPickedProductImage)
            .then((value) {
          value.ref.getDownloadURL().then((value) {
            emit(refershState());

            ItemModel model = ItemModel(
                itemId: HomeCubit.get(context).listItems.isEmpty ? 1: HomeCubit.get(context).listItems.length + 1,
                createdDate: DateTime.now().toString(),
                categoryId:  HomeCubit.get(context).listItems.firstWhere((element) => element.itemId == selectedTypeItemId && element.isDeleted == 0).categoryId,
                supCategoryId:  HomeCubit.get(context).listItems.firstWhere((element) => element.itemId == selectedTypeItemId && element.isDeleted == 0).supCategoryId,
                image: value,
                isDeleted: 0,
                additionsList:  listOfSelectedAdditions.toList(),
                description: txtUploadDescription.text??'',
                supCategoryTitle: HomeCubit.get(context).listItems.firstWhere((element) => element.itemId == selectedTypeItemId && element.isDeleted == 0).supCategoryTitle??'' ,
                categoryTitle: HomeCubit.get(context).listItems.firstWhere((element) => element.itemId == selectedTypeItemId && element.isDeleted == 0).categoryTitle??'',
                price: double.parse(txtUploadPrice.text)??0,
                itemTitle: txtUploadTitle.text??'',
                isAvailable: isAvailable,

                isDiscount: isDiscount,
                isPopular: isPopular,
                oldPrice: oldPrice,
                orderCount: 0,
                userMobile: Global.mobile??'',
                userName: Global.userName??''
            );
            FirebaseFirestore.instance
                .collection('Items')
                .doc(selectItemId.toString())
                .update(model.toJson())
                .then((value) {
              //   if(listOfSelectedAdditions.isNotEmpty){
              //     for (var element in listOfSelectedAdditions) {
              //       ItemModel additionsModel = ItemModel(
              //           itemId: element.itemId,
              //           createdDate: DateTime.now().toString(),
              //           categoryId: 0,
              //           supCategoryId: 0,
              //           image: element.image,
              //           isDeleted: 0,
              //           description: element.description??'',
              //           supCategoryTitle: element.supCategoryTitle??'' ,
              //           categoryTitle:element.categoryTitle??'',
              //           price: element.price??0,
              //           itemTitle: element.itemTitle??''
              //       );
              //       FirebaseFirestore.instance
              //           .collection('Items')
              //           .doc(HomeCubit.get(context).listItems.isEmpty
              //           ? 1.toString() : ( HomeCubit.get(context).listItems.length + 1).toString())
              //           .collection('Additions').doc(element.itemId.toString()).set(additionsModel.toMap()).then((value) {
              //
              //       });
              //
              //     }
              //   }


              restAfterUpload(context);
              EasyLoading.showSuccess('تمت الاضافة بنجاح!');

              isStartUpload = false;
            }).catchError((e) {
              isStartUpload = false;
            });
          }).catchError((e) {
            EasyLoading.dismiss();


          });
        }).catchError((e) {
          EasyLoading.dismiss();


        });




      }
      else if (selectedTypeItemId == 4 && isUploadValid) {
        EasyLoading.show(status: 'Uploading...');


        firebase_storage.FirebaseStorage.instance.ref().child('Additions/${Uri.file(finalPickedProductImage.path).pathSegments.last}').putFile(finalPickedProductImage).then((value) {
          value.ref.getDownloadURL().then((value) {
            emit(refershState());

            AdditionsModel model = AdditionsModel(
              createdDate: DateTime.now().toString(),
              itemId: selectAdditionId,
              categoryId: 0,
              supCategoryId: 0,
              image: value,
              isDeleted: 0,
              description: '',

              supCategoryTitle: '',
              categoryTitle:  '',
              price: double.parse(txtUploadPrice.text) ?? 0,
              itemTitle: txtUploadTitle.text ?? '',
              isDiscount: isDiscount,
              isPopular: isPopular,
              oldPrice: oldPrice.toInt(),
              orderCount: 0,

            );
            FirebaseFirestore.instance.collection('Additions').doc(selectAdditionId.toString()).update(model.toMap()).then((value) {
              restAfterUpload(context);
              EasyLoading.showSuccess('تمت الاضافة بنجاح!');

              isStartUpload = false;
            }).catchError((e) {
              isStartUpload = false;
            });
          }).catchError((e) {
            EasyLoading.dismiss();
          });
        }).catchError((e) {
          EasyLoading.dismiss();

        });



      }
    }else{

      if (selectedTypeItemId == 1 && isUploadValid) {
        EasyLoading.show(status: 'Uploading...');






        CategoryModel model = CategoryModel(
                createdDate: DateTime.now().toString(),
                categoryId: selectedCategoryId,
                image: prodeuctImageUrl??'',
                isDeleted: 0,
                isAvailable: isAvailable,
                categoryTitle:  txtUploadTitle.text
            );
            FirebaseFirestore.instance.collection('Category').doc(selectedCategoryId.toString()).update(model.toMap())
                .then((value) {
              restAfterUpload(context);
              EasyLoading.showSuccess('تمت الاضافة بنجاح!');

            }).catchError((e) {
              EasyLoading.dismiss();
            });





      }
      else if (selectedTypeItemId == 2 && isUploadValid) {
        EasyLoading.show(status: 'Uploading...');





            SubCategory model = SubCategory(
                createdDate: DateTime.now().toString(),
                categoryId: HomeCubit.get(context).listSubCategory.firstWhere((element) => element.supCategoryId == selectedSupCategoryId && element.isDeleted == 0).categoryId,
                supCategoryId: selectedSupCategoryId,
                image: prodeuctImageUrl??'',
                isDeleted: 0,
                isAvailable: isAvailable,
                categoryTitle:  HomeCubit.get(context).listSubCategory.firstWhere((element) => element.supCategoryId == selectedSupCategoryId && element.isDeleted == 0).categoryTitle,

                subCategoryTitle: txtUploadTitle.text
            );
            FirebaseFirestore.instance
                .collection('SubCategory')
                .doc(selectedSupCategoryId.toString())
                .update(model.toMap())
                .then((value) {
              restAfterUpload(context);
              EasyLoading.showSuccess('تمت الاضافة بنجاح!');

              isStartUpload = false;
            }).catchError((e) {
              isStartUpload = false;
            });



      }
      else if (selectedTypeItemId == 3 && isUploadValid) {



        EasyLoading.show(status: 'Uploading...');



            ItemModel model = ItemModel(
                itemId: HomeCubit.get(context).listItems.isEmpty ? 1: HomeCubit.get(context).listItems.length + 1,
                createdDate: DateTime.now().toString(),
                categoryId:  HomeCubit.get(context).listItems.firstWhere((element) => element.itemId == selectItemId && element.isDeleted == 0).categoryId,
                supCategoryId:  HomeCubit.get(context).listItems.firstWhere((element) => element.itemId == selectItemId && element.isDeleted == 0).supCategoryId,
                image: prodeuctImageUrl??'',
                isDeleted: 0,
                additionsList:  listOfSelectedAdditions.toList(),
                description: txtUploadDescription.text??'',
                supCategoryTitle: HomeCubit.get(context).listItems.firstWhere((element) => element.itemId == selectItemId && element.isDeleted == 0).supCategoryTitle??'' ,
                categoryTitle: HomeCubit.get(context).listItems.firstWhere((element) => element.itemId == selectItemId && element.isDeleted == 0).categoryTitle??'',
                price: double.parse(txtUploadPrice.text)??0,
                itemTitle: txtUploadTitle.text??'',
                isAvailable: isAvailable,

                isDiscount: isDiscount,
                isPopular: isPopular,
                oldPrice: oldPrice,
                orderCount: 0,
                userMobile: Global.mobile??'',
                userName: Global.userName??''
            );
            FirebaseFirestore.instance
                .collection('Items')
                .doc(selectItemId.toString())
                .update(model.toJson())
                .then((value) {
              //   if(listOfSelectedAdditions.isNotEmpty){
              //     for (var element in listOfSelectedAdditions) {
              //       ItemModel additionsModel = ItemModel(
              //           itemId: element.itemId,
              //           createdDate: DateTime.now().toString(),
              //           categoryId: 0,
              //           supCategoryId: 0,
              //           image: element.image,
              //           isDeleted: 0,
              //           description: element.description??'',
              //           supCategoryTitle: element.supCategoryTitle??'' ,
              //           categoryTitle:element.categoryTitle??'',
              //           price: element.price??0,
              //           itemTitle: element.itemTitle??''
              //       );
              //       FirebaseFirestore.instance
              //           .collection('Items')
              //           .doc(HomeCubit.get(context).listItems.isEmpty
              //           ? 1.toString() : ( HomeCubit.get(context).listItems.length + 1).toString())
              //           .collection('Additions').doc(element.itemId.toString()).set(additionsModel.toMap()).then((value) {
              //
              //       });
              //
              //     }
              //   }


              restAfterUpload(context);
              EasyLoading.showSuccess('تمت الاضافة بنجاح!');

              isStartUpload = false;
            }).catchError((e) {
              isStartUpload = false;
            });





      }
      else if (selectedTypeItemId == 4 && isUploadValid) {
        EasyLoading.show(status: 'Uploading...');




            AdditionsModel model = AdditionsModel(
              createdDate: DateTime.now().toString(),
              itemId: selectAdditionId,
              categoryId: 0,
              supCategoryId: 0,
              image: prodeuctImageUrl??'',
              isDeleted: 0,
              description: '',

              supCategoryTitle: '',
              categoryTitle:  '',
              price: double.parse(txtUploadPrice.text) ?? 0,
              itemTitle: txtUploadTitle.text ?? '',
              isDiscount: isDiscount,
              isPopular: isPopular,
              oldPrice: oldPrice.toInt(),
              orderCount: 0,

            );
            FirebaseFirestore.instance.collection('Additions').doc(selectAdditionId.toString()).update(model.toMap()).then((value) {
              restAfterUpload(context);
              EasyLoading.showSuccess('تمت الاضافة بنجاح!');

              isStartUpload = false;
            }).catchError((e) {
              isStartUpload = false;
            });



      }


    }




  }

  void uploadPickImageCamera(context) async {
    final picker = ImagePicker();

    final pickedImage = await picker.pickImage(source: ImageSource.camera);
    final pickedImageFile = File(pickedImage.path);
    finalPickedProductImage = pickedImageFile;
    checkIsUploadValid(context);
     emit(refershState());
  }

  void uploadPickImageGallery(context) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    final pickedImageFile = File(pickedImage.path);
    finalPickedProductImage = pickedImageFile;
    checkIsUploadValid(context);
    emit(refershState());
  }

  void removeUploadImage(context) {
    finalPickedProductImage = null;
    prodeuctImageUrl = '';
    checkIsUploadValid(context);
     emit(refershState());
  }

  void selectCategory(String value,context) {
    categoryValue = value;
    txtUploadCategory.text = value;
    checkIsUploadValid(context);
    ////emit(UploadProductsGalleryUploadImageState());
  }

  bool isUploadValid = false;

  void checkIsUploadValid(context) {


      if (selectedTypeItemId == 1 && txtUploadTitle.text.trim() != '' && selectedCategoryId != 0  && txtUploadTitle.text.trim() != null && (finalPickedProductImage != null ||prodeuctImageUrl.trim() != '' ))
      {
        isUploadValid = true;

    }
    else if ( selectedTypeItemId == 2 &&txtUploadTitle.text.trim() != '' &&   txtUploadTitle.text.trim() != null && selectedSupCategoryId != 0 && (finalPickedProductImage != null ||prodeuctImageUrl.trim() != '' ))
    {
        isUploadValid = true;
    }

      else if (selectedTypeItemId == 3 && txtUploadTitle.text.trim() != '' && txtUploadTitle.text.trim() != null && selectItemId != 0 && txtUploadPrice.text.trim() != '' && txtUploadPrice.text.trim() != null && txtUploadDescription.text.trim() !=''&& txtUploadDescription.text != null && (finalPickedProductImage != null ||prodeuctImageUrl.trim() != '' ))
      {
        if(
        isDiscount && ( txtUploadPrice.text.trim() == ''
            ||
            txtUploadPrice.text.trim() == null || txtUploadOldPrice.text.trim() == ''
            ||
            txtUploadOldPrice.text.trim() == null)
        ){
          isUploadValid = false;
        }else{
          isUploadValid = true;
        }


    }


      else if  (selectedTypeItemId == 4 && selectAdditionId != 0 && txtUploadTitle.text.trim() != '' && txtUploadTitle.text.trim() != null && txtUploadPrice.text.trim() != '' && txtUploadPrice.text.trim() != null && (finalPickedProductImage != null ||prodeuctImageUrl.trim() != '' ))
      {
        isUploadValid = true;
      }
      else
      {
        isUploadValid = false;
      }




    emit(refershState());
  }

  List<SubCategory> listSubCategoryMaster;
  String selectedSupCategory = '';
  getSubCategoryByCategoryId(id,context)
  {


    listSubCategoryMaster = HomeCubit.get(context).listSubCategory.where((element) => element.categoryId == id).toList();
    selectedSupCategory = '';
    selectedSupCategoryId = 0;
     emit(refershState());

  }

  onChangeTypeItemId(int index,context) async {

    restAfterUpload(context);
    if(index == 1) {

      selectedTypeItemId = index;
      emit(refershState());

    }


    else if (index == 2 || index == 3 ) {
      selectedTypeItemId = index;

    }

    else if(index == 4){

      selectedTypeItemId = index;
      emit(refershState());

    }



    checkIsUploadValid(context);


  }
  FocusNode uploadTitleNode = FocusNode();


   String prodeuctImageUrl = '';

  onChangeCategory(context,value){
    selectedSupCategoryId = 0;
    selectedSupCategory = '';

    txtUploadTitle.text = value??'';

    selectedCategoryId = HomeCubit.get(context).listCategory.firstWhere((element) => element.categoryTitle == value && element.isDeleted == 0).categoryId;

     if( selectedTypeItemId == 1){
       selectedSupCategoryId = 0;
       txtUploadTitle.text = value??'';

       selectedCategoryId = HomeCubit.get(context).listCategory.firstWhere((element) => element.categoryTitle == value && element.isDeleted == 0).categoryId;
       prodeuctImageUrl = HomeCubit.get(context).listCategory.firstWhere((element) => element.categoryTitle == value && element.isDeleted == 0).image;
        isAvailable = HomeCubit.get(context).listCategory.firstWhere((element) => element.categoryTitle == value && element.isDeleted == 0).isAvailable;
       FocusScope.of(context).requestFocus(uploadTitleNode);
       txtUploadTitle.selection = TextSelection(
         baseOffset: 0,
         extentOffset: txtUploadTitle.text.length,
       );
     }


  }
  onChangeSupCategory({context, value}){
    if( selectedTypeItemId == 2){

      txtUploadTitle.text = HomeCubit.get(context).listSubCategory.firstWhere((element) => element.subCategoryTitle == value && element.isDeleted == 0&&  element.projectId == Global.projectId).subCategoryTitle;
      selectedSupCategoryId = HomeCubit.get(context).listSubCategory.firstWhere((element) => element.subCategoryTitle == value && element.isDeleted == 0&&  element.projectId == Global.projectId).supCategoryId;
      prodeuctImageUrl = HomeCubit.get(context).listSubCategory.firstWhere((element) => element.subCategoryTitle == value && element.isDeleted == 0&&  element.projectId == Global.projectId).image;
      isAvailable = HomeCubit.get(context).listSubCategory.firstWhere((element) => element.subCategoryTitle == value && element.isDeleted == 0&&  element.projectId == Global.projectId).isAvailable;
      FocusScope.of(context).requestFocus(uploadTitleNode);
      txtUploadTitle.selection = TextSelection(
        baseOffset: 0,
        extentOffset: txtUploadTitle.text.length,
      );
    }
  }



  int selectItemId = 0;
  onChangeItems ({context, value}){
    if( selectedTypeItemId == 3){
      selectItemId = HomeCubit.get(context).listItems.firstWhere((element) => element.itemTitle == value && element.isDeleted == 0 &&  element.projectId == Global.projectId).itemId;
      txtUploadTitle.text = value??'';
      txtUploadDescription.text = HomeCubit.get(context).listItems.firstWhere((element) => element.itemTitle == value && element.isDeleted == 0&&  element.projectId == Global.projectId).description??'';
      txtUploadPrice.text = HomeCubit.get(context).listItems.firstWhere((element) => element.itemTitle == value && element.isDeleted == 0&&  element.projectId == Global.projectId).price.toString()??'0';
      txtUploadOldPrice.text = HomeCubit.get(context).listItems.firstWhere((element) => element.itemTitle == value && element.isDeleted == 0&&  element.projectId == Global.projectId).oldPrice.toString()??'0';
      isPopular = HomeCubit.get(context).listItems.firstWhere((element) => element.itemTitle == value && element.isDeleted == 0&&  element.projectId == Global.projectId).isPopular;
      isDiscount = HomeCubit.get(context).listItems.firstWhere((element) => element.itemTitle == value && element.isDeleted == 0&&  element.projectId == Global.projectId).isDiscount;

      prodeuctImageUrl = HomeCubit.get(context).listItems.firstWhere((element) => element.itemTitle == value && element.isDeleted == 0&&  element.projectId == Global.projectId).image;
      isAvailable = HomeCubit.get(context).listItems.firstWhere((element) => element.itemTitle == value && element.isDeleted == 0&&  element.projectId == Global.projectId).isAvailable;
      FocusScope.of(context).requestFocus(uploadTitleNode);
      txtUploadTitle.selection = TextSelection(
        baseOffset: 0,
        extentOffset: txtUploadTitle.text.length,
      );
    }

    emit(refershState());


  }

int  selectAdditionId = 0;
  onChangeAddition ({context, value}){

      if( selectedTypeItemId == 4){

      txtUploadTitle.text =  HomeCubit.get(context).listAdditions.firstWhere((element) => element.itemTitle == value && element.isDeleted == 0 &&  element.projectId == Global.projectId).itemTitle;

txtUploadPrice.text = HomeCubit.get(context).listAdditions.firstWhere((element) => element.itemTitle == value && element.isDeleted == 0 &&  element.projectId == Global.projectId).price.toString()??'0';
      selectAdditionId = HomeCubit.get(context).listAdditions.firstWhere((element) => element.itemTitle == value && element.isDeleted == 0&&  element.projectId == Global.projectId).itemId;
      prodeuctImageUrl = HomeCubit.get(context).listAdditions.firstWhere((element) => element.itemTitle == value && element.isDeleted == 0&&  element.projectId == Global.projectId).image;
      isAvailable = HomeCubit.get(context).listAdditions.firstWhere((element) => element.itemTitle == value && element.isDeleted == 0&&  element.projectId == Global.projectId).isAvailable;
      FocusScope.of(context).requestFocus(uploadTitleNode);
      
      txtUploadTitle.selection = TextSelection(
        baseOffset: 0,
        extentOffset: txtUploadTitle.text.length,
      );
     }




  }

}

List<ListItemTypeCategory> listItemTypeCategory = [
  ListItemTypeCategory(id: 1, name: 'Category'),
  ListItemTypeCategory(id: 2, name: 'SupCategory'),
  ListItemTypeCategory(id: 3, name: 'Product'),
  ListItemTypeCategory(id: 4, name: 'Additions'),
];

class ListItemTypeCategory {
  String name;
  int id;

  ListItemTypeCategory({this.name, this.id});
}
