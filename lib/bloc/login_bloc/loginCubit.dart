//@dart=2.9
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elomda/bloc/home_bloc/HomeCubit.dart';

import 'package:elomda/home_layout/home_layout.dart';
import 'package:elomda/models/project/projectModel.dart';
import 'package:elomda/models/user/user_model.dart';
import 'package:elomda/modules/login/activationCodeScreen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:elomda/modules/login/chooseAccountTypeScreen.dart';

import 'package:elomda/modules/login/register_screen.dart';
import 'package:elomda/modules/upload_products/upload_products.dart';
import 'package:elomda/shared/Global.dart';
import 'package:elomda/shared/network/local/helper.dart';
import 'package:elomda/shared/network/local/shared_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'loginState.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitState());
  static LoginCubit get(context) => BlocProvider.of(context);

   bool isValid = false;
   bool verifiedIsValid = false;
   bool isAdmin = false;

    final GlobalKey<ScaffoldState> scaffoldLoginKey = GlobalKey<ScaffoldState>();
   final GlobalKey<ScaffoldState> scaffoldVerifiedKey = GlobalKey<ScaffoldState>();

   RoundedLoadingButtonController loginBtnController = RoundedLoadingButtonController();
    RoundedLoadingButtonController verifiedBtnController = RoundedLoadingButtonController();

    TextEditingController textMobileControl = TextEditingController();
   TextEditingController textVerifiedCodeControl = TextEditingController();
    TextEditingController txtRegisterUserNameControl = TextEditingController();
    TextEditingController txtProjectMobileControl = TextEditingController();
 //
 //
 //  // var listproduct = products.toList();
 //  String floorSelectedName = '';
 //  int floorSelectedId = 0;
 //
 //
 //  var listUserType = userType.toList();
   String departMentSelectedName = '';

  File finalPickedUserImage;


  String verificationCode = '';
  getActivationCode(context) async {



    loginBtnController.start();
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber:'+2'+textMobileControl.text,

      verificationCompleted: (PhoneAuthCredential credential) {

        loginBtnController.success();
        loginBtnController.reset();

        emit(LoginSuccessState());
      },
      verificationFailed: (FirebaseAuthException e) {

        loginBtnController.error();
        loginBtnController.reset();
        emit(LoginErrorState(e.message));
      },
      codeSent: (String verificationId, int resendToken) {

        verificationCode = verificationId;
        loginBtnController.success();
        loginBtnController.reset();

        if(!listProject.any((element) => element.projectMobile == textMobileControl.text))
          {
            navigatTo(context, const ActivationCodeScreen());
          }
        else
          {
            navigatTo(context, const HomeLayout());
          }



        emit(LoginSuccessState());
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );


  }
  activationNumber(context) async {



   // debugPrintThrottled(verificationCode);
   PhoneAuthCredential phoneAuthCredential =
   PhoneAuthProvider.credential(verificationId: verificationCode, smsCode: textVerifiedCodeControl.text);
    signInWithPhoneAuthCredential(phoneAuthCredential,context);
  }

  signInWithPhoneAuthCredential(phoneAuthCredential,context) async {

    try {
      final authCredential = await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
      if(authCredential.user != null){
       await  CachHelper.SetData( key: 'mobile',value: textMobileControl.text);
       navigatTo(context, const AccountTypeScreen());
       // navigatTo(context, const HomeScreen());
      }
    } on FirebaseAuthException catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            e.message.toString(),
            textAlign: TextAlign.center,
          ),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
          behavior: SnackBarBehavior.floating,
          padding: const EdgeInsets.all(10.0),
          duration: const Duration(milliseconds: 2000)));


    }
  }








  verifiedChangValidState() {
    if(textVerifiedCodeControl.text.trim() != '' &&  textVerifiedCodeControl.text !=null )
    {
      verifiedIsValid = true;
    }
    else
    {
      verifiedIsValid = false;
    }
    emit(LoginSuccessState());
  }

  changValidState() {
    if(textMobileControl.text.trim() != '' && textMobileControl.text.length == 11 && textMobileControl.text !=null  )
    {
      isValid = true;
    }
    else
    {
      isValid = false;
    }
    emit(LoginSuccessState());
  }

   bool  registerValid  = false;
  changeRegisterValidState()
  {
    if(isAdmin &&txtRegisterUserNameControl.text.trim() != '' && txtRegisterUserNameControl.text.trim() != '' && finalPickedUserImage != null)
      {
        registerValid = true;
      }
    else if(!isAdmin &&txtRegisterUserNameControl.text.trim() != ''   ){
      registerValid = true;
    }
    else{
      registerValid = false;
    }


    emit(LoginSuccessState());
  }
  List<Project> listProject = [];
  getAllProjects() async {
    FirebaseFirestore.instance.collection('Projects').snapshots().listen((event) {
      listProject = event.docs.map((x) => Project.fromJson(x.data())).toList();
      emit(LoginSuccessState());
    });
  }
  registerAndLoginUser(context) async {

   Global.mobile = textMobileControl.text;
   Global.userName = txtRegisterUserNameControl.text;

   Global.departMent = 0;



   await CachHelper.SetData(key: 'mobile', value: Global.mobile);
   await CachHelper.SetData(key: 'userName', value: Global.userName);
   await CachHelper.SetData(key: 'departmentId', value: Global.departMent);
   await CachHelper.SetData(key: 'showOnBoarding', value: false);
   await CachHelper.SetData(key: 'isUserLogin', value: true);
   await CachHelper.SetData(key: 'isAdmin', value: isAdmin);




   FirebaseFirestore.instance.collection('User').doc(Global.mobile).get().then((value) {

     userModel = UserModel.fromJson(value.data());
     Global.imageUrl = userModel.image;
     if(userModel.mobile != null)
       {
         restLoginCubit();
         // HomeCubit.get(context).getUserFavourite();
         NavigatToAndReplace(context, const HomeLayout());
      //   NavigatToAndReplace(context, const HomeLayout());
       }
     else
       {
         firebase_storage.FirebaseStorage.instance
             .ref()
             .child(
             'User/${Uri.file(finalPickedUserImage.path).pathSegments.last}')
             .putFile(finalPickedUserImage)
             .then((value) {
           value.ref.getDownloadURL().then((value) {
             UserModel model =  UserModel(
               isActive: false,
               image:value,
               currentBalance: 0,
               createdDate: DateTime.now().toString(),
               isAdmin:isAdmin,
               departmentId:0,
               mobile: Global.mobile,
               userName: Global.userName,
               fireBaseToken: Global.fireBaseToken,
             );
             Global.imageUrl = value;

             FirebaseFirestore.instance.collection('User').doc(Global.mobile).set(model.toMap()).then((value) {
               restLoginCubit();
               NavigatToAndReplace(context, const HomeLayout());

             }).catchError((e){
               if (kDebugMode) {
                 print(e);
               }
             });
           });});

       }




   }).catchError((error){

     firebase_storage.FirebaseStorage.instance
         .ref()
         .child(
         'User/${Uri.file(finalPickedUserImage.path).pathSegments.last}')
         .putFile(finalPickedUserImage)
         .then((value) {
       value.ref.getDownloadURL().then((value) {
         UserModel model =  UserModel(
           isActive: false,
           image:value,
           currentBalance: 0,
           createdDate: DateTime.now().toString(),
           isAdmin:isAdmin,
           departmentId:0,
           mobile: Global.mobile,
           userName: Global.userName,
           fireBaseToken: Global.fireBaseToken,
         );
         Global.imageUrl = value;
         FirebaseFirestore.instance.collection('User').doc(Global.mobile).set(model.toMap()).then((value) {
           restLoginCubit();
           NavigatToAndReplace(context, const HomeLayout());

         }).catchError((e){
           if (kDebugMode) {
             print(e);
           }
         });
       });});
   });

  }
  List<UserModel> listUser = [];
  getUsers() async {
    FirebaseFirestore.instance.collection('User').snapshots().listen((event) {
      listUser = event.docs.map((x) => UserModel.fromJson(x.data())).toList();

      emit(LoginSuccessState());
    }).onError((handleError){
      print(handleError);
    });
  }

  registerAndLoginAdmin(context) async {



    Global.mobile = textMobileControl.text;
    Global.userName = txtRegisterUserNameControl.text;
    Global.departMent = HomeCubit.get(context).departMentList.indexWhere((element) => element == departMentSelectedName);



    await CachHelper.SetData(key: 'mobile', value: Global.mobile);
    await CachHelper.SetData(key: 'userName', value: Global.userName);
    await CachHelper.SetData(key: 'departmentId', value: Global.departMent);
    await CachHelper.SetData(key: 'showOnBoarding', value: false);
    await CachHelper.SetData(key: 'isUserLogin', value: true);
    await CachHelper.SetData(key: 'isAdmin', value: isAdmin);






    FirebaseFirestore.instance.collection('Projects').doc(txtProjectMobileControl.text).get().then((value) {

      projectModel = Project.fromJson(value.data());

      if(projectModel.projectMobile != null)
      {
        restLoginCubit();

        NavigatToAndReplace(context, const HomeLayout());

      }
      else
      {
        Project model =  Project(
            isActive: false,
            image: '',
            id: listProject.length + 1,
            createdDate: DateTime.now().toString(),
            name: txtRegisterUserNameControl.text,

            adminMobile: Global.mobile,
            projectMobile: txtProjectMobileControl.text
        );
        FirebaseFirestore.instance.collection('Projects').doc(txtProjectMobileControl.text).set(model.toMap()).then((value) {
          restLoginCubit();
          NavigatToAndReplace(context, const HomeLayout());

        }).catchError((e){
          if (kDebugMode) {
            print(e);
          }
        });
      }




    }).catchError((error){
      Project model =  Project(
          isActive: false,
          image: '',
          id: listProject.length + 1,
          createdDate: DateTime.now().toString(),
          name: txtRegisterUserNameControl.text,

          adminMobile: Global.mobile,
          projectMobile: txtProjectMobileControl.text
      );
      FirebaseFirestore.instance.collection('User').doc(Global.mobile).set(model.toMap()).then((value) {
        restLoginCubit();
        NavigatToAndReplace(context, const HomeLayout());
      }).catchError((e){
        if (kDebugMode) {
          print(e);
        }
      });
    });

  }



  restLoginCubit() {
    txtRegisterUserNameControl.text = '';
    textMobileControl.text = '';
      textVerifiedCodeControl.text = '';
        registerValid = false;
        verifiedIsValid = false;
        isValid = false;
      verificationCode = '';
      departMentSelectedName = '';

    emit(ChangeInScreenState());
  }

   UserModel userModel;
  Project projectModel;
  getUserData() {
    FirebaseFirestore.instance.collection('User').doc(Global.mobile).get().then((value) {

      userModel =   UserModel.fromJson(value.data());

      if (kDebugMode) {
        print(value.data());
      }


    }).catchError((error){
      if (kDebugMode) {
        print(error);
      }
    });


  }

  void uploadPickImageCamera(context) async {
    final picker = ImagePicker();

    final pickedImage = await picker.pickImage(source: ImageSource.camera);
    final pickedImageFile = File(pickedImage.path);
    finalPickedUserImage = pickedImageFile;
    changeRegisterValidState();
    emit(LoginSuccessState());
  }
  void removeUploadImage(context) {
    finalPickedUserImage = null;
    changeRegisterValidState();
    emit(LoginSuccessState());
  }
  void uploadPickImageGallery(context) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    final pickedImageFile = File(pickedImage.path);
    finalPickedUserImage = pickedImageFile;
    changeRegisterValidState();
    emit(LoginSuccessState());
  }


}






