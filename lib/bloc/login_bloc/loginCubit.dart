//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elomda/bloc/home_bloc/HomeCubit.dart';

import 'package:elomda/home_layout/home_layout.dart';
import 'package:elomda/models/user/user_model.dart';
import 'package:elomda/modules/home/home_screen.dart';
import 'package:elomda/modules/login/activationCodeScreen.dart';

import 'package:elomda/modules/login/register_screen.dart';
import 'package:elomda/modules/upload_products/upload_products.dart';
import 'package:elomda/shared/Global.dart';
import 'package:elomda/shared/network/local/helper.dart';
import 'package:elomda/shared/network/local/shared_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'loginState.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitState());
  static LoginCubit get(context) => BlocProvider.of(context);

   bool isValid = false;
   bool verifiedIsValid = false;

    final GlobalKey<ScaffoldState> scaffoldLoginKey = GlobalKey<ScaffoldState>();
   final GlobalKey<ScaffoldState> scaffoldVerifiedKey = GlobalKey<ScaffoldState>();

   RoundedLoadingButtonController loginBtnController = RoundedLoadingButtonController();
    RoundedLoadingButtonController verifiedBtnController = RoundedLoadingButtonController();

    TextEditingController textMobileControl = TextEditingController();
   TextEditingController textVerifiedCodeControl = TextEditingController();
    TextEditingController txtRegisterUserNameControl = TextEditingController();
 //
 //
 //  // var listproduct = products.toList();
 //  String floorSelectedName = '';
 //  int floorSelectedId = 0;
 //
 //
 //  var listUserType = userType.toList();
   String departMentSelectedName = '';




  String verificationCode = '';
  getActivationCode(context) async {

    // navigatTo(context, const ActivationCodeScreen());

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
        navigatTo(context, const ActivationCodeScreen());
        emit(LoginSuccessState());
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );


  }
  activationNumber(context) async {

    //  navigatTo(context, const RegisterScreen());

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
        navigatTo(context, const RegisterScreen());
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
    if(txtRegisterUserNameControl.text.trim() != ''
    //     && txtRegisterUserNameControl.text !=  null
    //  &&
    //
    // departmentId != 0 && departmentId != null

    )
    {
      registerValid = true;
    }
    else
    {
      registerValid = false;
    }
    emit(LoginSuccessState());
  }

  registerAndLogin(context) async {

    // Check If User not Created

    // if true

    // Save User Date
        // 1 - Mobile
        // 2 - UserName
        // 3 - departmentId

   Global.mobile = textMobileControl.text;
   Global.userName = txtRegisterUserNameControl.text;
   Global.departMent = HomeCubit.get(context).departMentList.indexWhere((element) => element == departMentSelectedName);



   await CachHelper.SetData(key: 'mobile', value: Global.mobile);
   await CachHelper.SetData(key: 'userName', value: Global.userName);
   // await CachHelper.SetData(key: 'departmentId', value: Global.departmentId);
   await CachHelper.SetData(key: 'showOnBoarding', value: false);
   await CachHelper.SetData(key: 'isUserLogin', value: true);


   UserModel model =  UserModel(
     image: '',
     isAdmin: false,
     departmentId:0,
     mobile: Global.mobile,
     userName: Global.userName,
     fireBaseToken: Global.fireBaseToken,
   );



   FirebaseFirestore.instance.collection('User').doc(Global.mobile).get().then((value) {

     userModel = UserModel.fromJson(value.data());

     if(userModel.mobile != null)
       {
         restLoginCubit();
         // HomeCubit.get(context).getUserFavourite();
         NavigatToAndReplace(context, const UploadProductForm());
      //   NavigatToAndReplace(context, const HomeLayout());
       }
     else
       {
         FirebaseFirestore.instance.collection('User').doc(Global.mobile).set(model.toMap()).then((value) {
           restLoginCubit();
           NavigatToAndReplace(context, const HomeLayout());

         }).catchError((e){
           if (kDebugMode) {
             print(e);
           }
         });
       }




   }).catchError((error){

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

}






