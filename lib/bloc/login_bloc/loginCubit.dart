// @dart=2.9


import 'package:elomda/modules/login/login_screen.dart';
import 'package:elomda/shared/network/local/helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';


import 'loginState.dart';



class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitState());
  static LoginCubit get(context) => BlocProvider.of(context);

   bool isVaild = false;
   bool VerifiedisVaild = false;
 //
 //  final GlobalKey<ScaffoldState> scaffoldLoginKey = GlobalKey<ScaffoldState>();
 //  final GlobalKey<ScaffoldState> scaffoldVerifiedKey = GlobalKey<ScaffoldState>();
 //
 //
 //  final GlobalKey<FormState> loginFormGlobalKey = GlobalKey<FormState>();
 //  final GlobalKey<FormState> VerifiedFormGlobalKey = GlobalKey<FormState>();
 //
   RoundedLoadingButtonController loginbtnController = RoundedLoadingButtonController();
 //  RoundedLoadingButtonController VerifiedbtnController = RoundedLoadingButtonController();
 //
    TextEditingController textMobileControl = TextEditingController();
   TextEditingController textVerifiedCodeControl = TextEditingController();
 //  TextEditingController txtRegisterUserNameControl = TextEditingController();
 //
 //
 //  // var listproduct = products.toList();
 //  String floorSelectedName = '';
 //  int floorSelectedId = 0;
 //
 //
 //  var listUserType = userType.toList();
 //  String userTypeSelectedName = '';
 //  int userTypeSelectedId = 0;
 //
  getActivationCode(context) async {
    loginbtnController.start();
    emit(LoginLoadingState());

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber:'+2'+textMobileControl.text,

      verificationCompleted: (PhoneAuthCredential credential) {
         ;

         loginbtnController.success();
         loginbtnController.reset();

        emit(LoginSuccessState());
      },
      verificationFailed: (FirebaseAuthException e) {

        loginbtnController.error();
        loginbtnController.reset();
        emit(LoginErorrState(e.message));
      },
      codeSent: (String verificationId, int resendToken) {

        VerificationCode = verificationId;
        loginbtnController.success();
        navigatTo(context, const ActivationCodeScreen());
        emit(LoginSuccessState());
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
    // loginbtnController.reset();
    // NavigatTo(context, VerifiedScreen());

  }
 //
    String VerificationCode = '';
 //
 //  activationNumber(context) async {
 //
 //    // NavigatToAndReplace(context, RegisterScreen());
 //
 //   debugPrintThrottled(VerificationCode);PhoneAuthCredential phoneAuthCredential =
 //   await PhoneAuthProvider.credential(verificationId: VerificationCode, smsCode: textVerifiedCodeControl.text);
 //    signInWithPhoneAuthCredential(phoneAuthCredential,context);
 //  }
 //
 //
 //  void signInWithPhoneAuthCredential(phoneAuthCredential,context) async {
 //
 //    try {
 //      final authCredential = await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
 //
 //
 //      if(authCredential.user != null){
 //
 //
 //       await  CachHelper.SetData( key: 'Mobile',value: textMobileControl.text);
 //
 //          NavigatTo(context, RegisterScreen());
 //      }
 //
 //    } on FirebaseAuthException catch (e) {
 //
 //
 //      scaffoldVerifiedKey.currentState.showSnackBar(SnackBar(
 //          backgroundColor: Colors.red,
 //          content: Text(
 //            e.message.toString(),
 //            textAlign: TextAlign.center,
 //          ),
 //          shape: RoundedRectangleBorder(
 //              borderRadius: BorderRadius.all(Radius.circular(30))),
 //          behavior: SnackBarBehavior.floating,
 //          padding: EdgeInsets.all(10.0),
 //          duration: Duration(milliseconds: 2000)));
 //
 //
 //    }
 //  }
  VerifiedchangVaildState() {
    if(textVerifiedCodeControl.text.trim() != '' &&  textVerifiedCodeControl.text !=null )
    {
      VerifiedisVaild = true;
    }
    else
    {
      VerifiedisVaild = false;
    }
    emit(LoginSuccessState());
  }
 //
  changVaildState() {
    if(textMobileControl.text.trim() != '' && textMobileControl.text.length == 11 && textMobileControl.text !=null  )
    {
      isVaild = true;
    }
    else
    {
      isVaild = false;
    }
    emit(LoginSuccessState());
  }
 //
 //
 //
 //  bool  RegisterVaild  = false;
 //  changeRegisterVaildState()
 //  {
 //    if(txtRegisterUserNameControl.text.trim() != '' && txtRegisterUserNameControl.text !=  null &&
 //
 //        floorSelectedId != 0 && floorSelectedId != null &&
 //        userTypeSelectedId != 0 && userTypeSelectedId != null
 //
 //    )
 //    {
 //      RegisterVaild = true;
 //    }
 //    else
 //    {
 //      RegisterVaild = false;
 //    }
 //    emit(LoginSuccessState());
 //  }
 //
 //
 //
 //
 //  registerAndLogin(context) async {
 //
 //    // Check If User not Created
 //
 //    // if true
 //
 //    // Save User Date
 //        // 1 - Mobile
 //        // 2 - UserName
 //        // 3 - TitlJop
 //        // 4 - TitlJop
 //
 //   Global.Mobile = textMobileControl.text;
 //   Global.userName = txtRegisterUserNameControl.text;
 //   Global.UserType = userTypeSelectedId.toString();
 //
 //
 //
 //   await CachHelper.SetData(key: 'Mobile', value: Global.Mobile);
 //   await CachHelper.SetData(key: 'UserName', value: Global.userName);
 //   await CachHelper.SetData(key: 'UserType', value: Global.UserType);
 //   await CachHelper.SetData(key: 'showOnboarding', value: false);
 //   await CachHelper.SetData(key: 'isUserLogined', value: true);
 //
 //   UserModel model =  UserModel(
 //     floorId: floorSelectedId,
 //     image: '',
 //     isAdmin: false,
 //     jopTypeId:userTypeSelectedId ,
 //     mobile: Global.Mobile,
 //     userName: Global.userName
 //   );
 //
 //
 //
 //   FirebaseFirestore.instance.collection('User').doc(Global.Mobile).get().then((value) {
 //
 //     userModel =   UserModel.fromJson(value.data());
 //
 //     if(userModel.mobile != null)
 //       {
 //         restLoginCubit();
 //         HomeCubit.get(context).getUserFavourit();
 //         NavigatToAndReplace(context, LayOutScreen());
 //       }
 //     else
 //       {
 //         FirebaseFirestore.instance.collection('User').doc(Global.Mobile).set(model.toMap()).then((value) {
 //           restLoginCubit();
 //           NavigatToAndReplace(context, LayOutScreen());
 //
 //         }).catchError((e){
 //           print(e);
 //         });
 //       }
 //
 //
 //
 //
 //   }).catchError((erorr){
 //
 //     FirebaseFirestore.instance.collection('User').doc(Global.Mobile).set(model.toMap()).then((value) {
 //       restLoginCubit();
 //       NavigatToAndReplace(context, LayOutScreen());
 //     }).catchError((e){
 //       print(e);
 //     });
 //   });
 //
 //  }
 //
 //
 //
 //
 //
 //
 // Future restLoginCubit() {
 //    txtRegisterUserNameControl.text = '';
 //    textMobileControl.text = '';
 //      textVerifiedCodeControl.text = '';
 //        RegisterVaild = false;
 //        VerifiedisVaild = false;
 //        isVaild = false;
     //  VerificationCode = '';
 //      floorSelectedName = '';
 //      floorSelectedId = 0;
 //      userTypeSelectedName = '';
 //      userTypeSelectedId = 0;
 //    emit(ChangeInScreenState());
 //  }
 //
 //  UserModel userModel;
 //
 //  getUserData() {
 //    FirebaseFirestore.instance.collection('User').doc(Global.Mobile).get().then((value) {
 //
 //      userModel =   UserModel.fromJson(value.data());
 //
 //      print(value.data());
 //
 //
 //    }).catchError((erorr){
 //      print(erorr);
 //    });
 //
 //
 //  }

}






