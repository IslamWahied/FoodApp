// @dart=2.9
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
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
import 'upload_products_state.dart';

class UploadProducts extends Cubit<UploadProductsState> {
  UploadProducts() : super(UploadProductsInitState());

  static UploadProducts get(context) => BlocProvider.of(context);

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
    selectedCategoryId = 0;
    selectedCategoryId = 0;
    txtUploadDescription.text = '';
    finalPickedProductImage = null;
    isUploadValid = false;
    listOfSelectedAdditions = [];

    // if (selectedTypeItemId == 1) {
    //   listCategory = [];
    //   listSubCategory = [];
    // }

    checkIsUploadValid(context);
    emit(UploadProductsCameraUploadImageState());
  }

  changeIsAvailableState({bool value})
  {
    isAvailable = value;
    emit(RefreshState());
  }

  changeIsPopular({bool value})
  {
    isPopular = value;
    emit(RefreshState());
  }

  changeIsDiscount({bool value})
  {
    isDiscount = value;
    emit(RefreshState());
  }


bool isOldPrice = false;
  changeIsOldPrice({bool value})
  {
    isOldPrice = value;
    emit(RefreshState());
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
    if (selectedTypeItemId == 1 && isUploadValid) {
      EasyLoading.show(status: 'Uploading...');


      bool isNameFind = HomeCubit.get(context).listCategory.any((element) =>
      element.categoryTitle == txtUploadTitle.text && element.isDeleted == 0);

      if (isNameFind) {
        EasyLoading.showError('تمت الاضافة من قبل');
      }
      else {
        firebase_storage.FirebaseStorage.instance
            .ref()
            .child(
            'Category/${Uri.file(finalPickedProductImage.path).pathSegments.last}')
            .putFile(finalPickedProductImage)
            .then((value) {
          value.ref.getDownloadURL().then((value) {
            //emit(SocialUploadProfileImageSuccessState());

            Category model = Category(
                createdDate: DateTime.now().toString(),
                categoryId: HomeCubit.get(context).listCategory.isEmpty ? 1 : HomeCubit.get(context).listCategory.length + 1,
                image: value,
                isDeleted: 0,
                isAvailable: isAvailable,
                categoryTitle:  txtUploadTitle.text
            );
            FirebaseFirestore.instance
                .collection('Category')
                .doc(HomeCubit.get(context).listCategory.isEmpty ? 1.toString() : (HomeCubit.get(context).listCategory.length + 1).toString()).set(model.toMap())
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
      }


    }
    else if (selectedTypeItemId == 2 && isUploadValid) {
      EasyLoading.show(status: 'Uploading...');

      bool isNameFind = HomeCubit.get(context).listSubCategory
          .any((element) => element.subCategoryTitle == txtUploadTitle.text);

      if (isNameFind) {
        EasyLoading.showError('تمت الاضافة من قبل');
        // MotionToast.error(
        //   title: const Text("تمت الاضافة من قبل",style:TextStyle(fontWeight: FontWeight.bold)),
        //   width:  300,
        //   description: null,
        // ).show(context);

      }
      else {
        firebase_storage.FirebaseStorage.instance
            .ref()
            .child(
            'SubCategory/${Uri.file(finalPickedProductImage.path).pathSegments.last}')
            .putFile(finalPickedProductImage)
            .then((value) {
          value.ref.getDownloadURL().then((value) {


            SubCategory model = SubCategory(
                createdDate: DateTime.now().toString(),
                categoryId: selectedCategoryId,
                supCategoryId:
                HomeCubit.get(context).listSubCategory.isEmpty ? 1 : HomeCubit.get(context).listSubCategory.length + 1,
                image: value,
                isDeleted: 0,
                isAvailable: isAvailable,
                categoryTitle: HomeCubit.get(context).listCategory.firstWhere((element) => element.categoryId == selectedCategoryId &&
                    element.isDeleted == 0)
                    .categoryTitle,

                subCategoryTitle: txtUploadTitle.text
            );
            FirebaseFirestore.instance
                .collection('SubCategory')
                .doc(HomeCubit.get(context).listSubCategory.isEmpty
                ? 1.toString()
                : (HomeCubit.get(context).listSubCategory.length + 1).toString())
                .set(model.toMap())
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


    }
    else if (selectedTypeItemId == 3 && isUploadValid) {

      if(selectedSupCategoryId == 0)
        {
          EasyLoading.showError('Please Add SupCategory');
        }
      else{
        EasyLoading.show(status: 'Uploading...');


        bool isNameFind =  HomeCubit.get(context).listItems.any((element) => element.itemTitle == txtUploadTitle.text);

        if (isNameFind) {
          EasyLoading.showError('تمت الاضافة من قبل');

        }
        else {
          firebase_storage.FirebaseStorage.instance
              .ref()
              .child('Items/${Uri.file(finalPickedProductImage.path).pathSegments.last}')
              .putFile(finalPickedProductImage)
              .then((value) {
            value.ref.getDownloadURL().then((value) {
              // emit(SocialUploadProfileImageSuccessState());

              ItemModel model = ItemModel(
                  itemId: HomeCubit.get(context).listItems.isEmpty ? 1: HomeCubit.get(context).listItems.length + 1,
                  createdDate: DateTime.now().toString(),
                  categoryId: selectedCategoryId,
                  supCategoryId: selectedSupCategoryId,
                  image: value,
                  isDeleted: 0,
                  additionsList:  listOfSelectedAdditions.toList(),
                  description: txtUploadDescription.text??'',
                  supCategoryTitle: HomeCubit.get(context).listSubCategory.firstWhere((element) => element.supCategoryId == selectedSupCategoryId && element.isDeleted == 0).subCategoryTitle??'' ,
                  categoryTitle: HomeCubit.get(context).listCategory.firstWhere((element) => element.categoryId == selectedCategoryId && element.isDeleted == 0).categoryTitle??'',
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
                  .doc(HomeCubit.get(context).listItems.isEmpty
                  ? 1.toString() : ( HomeCubit.get(context).listItems.length + 1).toString())
                  .set(model.toJson())
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


      }
      }
    else if (selectedTypeItemId == 4 && isUploadValid) {
      EasyLoading.show(status: 'Uploading...');

      bool isNameFind = HomeCubit.get(context).listAdditions.any((element) =>
      element.itemTitle == txtUploadTitle.text);

      if (isNameFind) {
        EasyLoading.showError('تمت الاضافة من قبل');
      }
      else {
        firebase_storage.FirebaseStorage.instance
            .ref()
            .child('Additions/${Uri
            .file(finalPickedProductImage.path)
            .pathSegments
            .last}')
            .putFile(finalPickedProductImage)
            .then((value) {
          value.ref.getDownloadURL().then((value) {
            //emit(SocialUploadProfileImageSuccessState());

            AdditionsModel model = AdditionsModel(
                createdDate: DateTime.now().toString(),
                itemId: HomeCubit.get(context).listAdditions.isEmpty ? 1: HomeCubit.get(context).listAdditions.length + 1,
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
                oldPrice: oldPrice,
                orderCount: 0,

            );
            FirebaseFirestore.instance
                .collection('Additions')
                .doc(
                HomeCubit.get(context).listAdditions.isEmpty ? 1.toString() : (HomeCubit.get(context).listAdditions.length + 1).toString())
                .set(model.toMap())
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


    }


  }

  void uploadPickImageCamera(context) async {
    final picker = ImagePicker();

    final pickedImage = await picker.pickImage(source: ImageSource.camera);
    final pickedImageFile = File(pickedImage.path);
    finalPickedProductImage = pickedImageFile;
    checkIsUploadValid(context);
    emit(UploadProductsCameraUploadImageState());
  }

  void uploadPickImageGallery(context) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    final pickedImageFile = File(pickedImage.path);
    finalPickedProductImage = pickedImageFile;
    checkIsUploadValid(context);
    emit(UploadProductsGalleryUploadImageState());
  }

  void removeUploadImage(context) {
    finalPickedProductImage = null;
    checkIsUploadValid(context);
    emit(UploadProductsRemoveUploadImageState());
  }

  void selectCategory(String value,context) {
    categoryValue = value;
    txtUploadCategory.text = value;
    checkIsUploadValid(context);
    emit(UploadProductsSelectCategoryState());
  }

  bool isUploadValid = false;

  void checkIsUploadValid(context) {


    if (selectedTypeItemId == 1) {
      if (txtUploadTitle.text.trim() != '' && txtUploadTitle.text.trim() != null &&
          finalPickedProductImage != null)
      {
        isUploadValid = true;
      } else {
        isUploadValid = false;
      }
    }
    else if (selectedTypeItemId == 2)
    {

      if (
           txtUploadTitle.text.trim() != ''
          &&
          txtUploadTitle.text.trim() != null
          &&
          selectedCategoryId != 0
          &&
          selectedCategoryId != null
          &&
          finalPickedProductImage != null
      ) {
        isUploadValid = true;
      } else {
        isUploadValid = false;
      }
    }
    else if (selectedTypeItemId == 3) {
      if (txtUploadTitle.text.trim() != '' &&
          txtUploadTitle.text.trim() != null &&
          selectedCategoryId != 0 &&
          selectedCategoryId != null &&
          selectedSupCategoryId != 0 &&
          selectedSupCategoryId != null &&
          txtUploadPrice.text.trim() != '' &&
          txtUploadPrice.text.trim() != null &&
          txtUploadDescription.text.trim() !=''&&
          txtUploadDescription.text != null &&
          finalPickedProductImage != null &&
          HomeCubit.get(context).listCategory
                  .firstWhere((element) => element.categoryId == selectedCategoryId)
                  .categoryTitle
                  .trim() !=
              '' &&
          HomeCubit.get(context).listCategory
                  .firstWhere((element) =>
                      element.categoryId == selectedCategoryId &&
                      element.isDeleted == 0)
                  .categoryTitle
                  .trim() !=
              null &&
          HomeCubit.get(context).listSubCategory
                  .firstWhere((element) =>
                      element.supCategoryId == selectedSupCategoryId)
                  .subCategoryTitle
                  .trim() !=
              '' &&
          HomeCubit.get(context).listSubCategory
                  .firstWhere((element) =>
                      element.supCategoryId == selectedSupCategoryId &&
                      element.isDeleted == 0)
                  .subCategoryTitle
                  .trim() !=
              null) {
        isUploadValid = true;
      } else {
        isUploadValid = false;
      }
    }

    else  if (selectedTypeItemId == 4) {
      if (
      txtUploadTitle.text.trim() != '' &&
          txtUploadTitle.text.trim() != null &&
          txtUploadPrice.text.trim() != '' &&
          txtUploadPrice.text.trim() != null &&
          finalPickedProductImage != null
      )
      {
        isUploadValid = true;
      } else {
        isUploadValid = false;
      }
    }

    emit(UploadProductsSelectCategoryState());
  }

  List<SubCategory> listSubCategoryMaster;

  getSubCategoryByCategoryId(id)
  {

   selectedCategoryId = id;
   emit(onChangeTypeItemIdState());

  }

  onChangeTypeItemId(int index,context) async {

    selectedCategoryId =0;
    selectedSupCategoryId = 0;

     if(index == 1) {

    selectedTypeItemId = index;
    emit(UploadProductsCameraUploadImageState());

    }


   else if (index == 2 || index == 3 ) {
       selectedTypeItemId = index;

    }

   else if(index == 4){

       selectedTypeItemId = index;
       emit(UploadProductsCameraUploadImageState());

     }



      checkIsUploadValid(context);


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
