// @dart=2.9

import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elomda/bloc/home_bloc/HomeCubit.dart';
import 'package:elomda/bloc/login_bloc/loginCubit.dart';
import 'package:elomda/bloc/register_Bloc/registerState.dart';
import 'package:elomda/home_layout/home_layout.dart';
import 'package:elomda/models/project/projectModel.dart';
import 'package:elomda/models/user/user_model.dart';
import 'package:elomda/modules/login/chooseAccountTypeScreen.dart';
import 'package:elomda/modules/login/register_screen.dart';
import 'package:elomda/shared/Global.dart';
import 'package:elomda/shared/network/local/helper.dart';
import 'package:elomda/shared/network/local/shared_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  bool activationDone = false;
  bool verifiedIsValid = false;

  int endTime = DateTime.now().millisecondsSinceEpoch + 2000 * 30;
  bool timerEnd = false;
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();

  TextEditingController textVerifiedCodeControl = TextEditingController();
  RoundedLoadingButtonController verifiedBtnController =
      RoundedLoadingButtonController();

  activationNumber(context) async {
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: LoginCubit.get(context).verificationCode,
        smsCode: textVerifiedCodeControl.text);
    signInWithPhoneAuthCredential(phoneAuthCredential, context);
  }

  signInWithPhoneAuthCredential(phoneAuthCredential, context) async {
    try {
      final authCredential =
          await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
      if (authCredential.user != null) {
        activationDone = true;

        await Future.delayed(const Duration(seconds: 2));



        bool isOldUser = HomeCubit.get(context).listUser.any((element) =>
            element.mobile == LoginCubit.get(context).textMobileControl.text);

        if (isOldUser) {
          var userModel = HomeCubit.get(context).listUser.firstWhere(
              (element) =>
                  element.mobile ==
                  LoginCubit.get(context).textMobileControl.text);

          Global.userName = userModel.userName;

          Global.isAdmin = userModel.isAdmin;

          Global.imageUrl = userModel.image;

          Global.departMent = userModel.departmentId;

          await CachHelper.SetData(key: 'mobile', value: Global.mobile);
          await CachHelper.SetData(key: 'isUserLogin', value: true);
          await CachHelper.SetData(key: 'isAdmin', value: userModel.isAdmin);
          await CachHelper.SetData(key: 'imageUrl', value: userModel.image);
          await CachHelper.SetData(key: 'userName', value: userModel.userName);
          await CachHelper.SetData(key: 'departmentId', value: userModel.departmentId);




          HomeCubit.get(context).currentIndex = 0;
          if (Global.isAdmin) {
            HomeCubit.get(context).selectedTab = 'طلبات جديدة';
          } else {
            HomeCubit.get(context).selectedTab = 'القائمة الرئيسية';
          }
          NavigatToAndReplace(context, const HomeLayout());
        } else {
          navigatTo(context, const AccountTypeScreen());
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.message == 'The verification ID used to create the phone auth credential is invalid.') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              '!كود التحقق الذي تم ادخاله غير صحيح',
              textAlign: TextAlign.center,
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))),
            behavior: SnackBarBehavior.floating,
            padding: EdgeInsets.all(10.0),
            duration: Duration(milliseconds: 2000)));
      } else {
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
  }
bool isAdmin  =false;
  File finalPickedUserImage;
  File finalPickedProjectImage;


  void uploadProjectPickImageCamera(context) async {
    final picker = ImagePicker();

    final pickedImage = await picker.pickImage(source: ImageSource.camera);
    final pickedImageFile = File(pickedImage.path);
    finalPickedProjectImage = pickedImageFile;
    changeRegisterValidState();
    emit(Refersh());
  }

  void uploadProjectPickImageGallery(context) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    final pickedImageFile = File(pickedImage.path);
    finalPickedProjectImage = pickedImageFile;
    changeRegisterValidState();
    emit(Refersh());
  }


  void uploadPickImageCamera(context) async {
    final picker = ImagePicker();

    final pickedImage = await picker.pickImage(source: ImageSource.camera);
    final pickedImageFile = File(pickedImage.path);
    finalPickedUserImage = pickedImageFile;
    changeRegisterValidState();
    emit(Refersh());
  }

  void uploadPickImageGallery(context) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    final pickedImageFile = File(pickedImage.path);
    finalPickedUserImage = pickedImageFile;
    changeRegisterValidState();
    emit(Refersh());
  }



  UserModel userModel;
  Project projectModel;
  registerAndLoginUser(context) async {
    rgisterBtnController.start();
    Global.userName = txtRegisterUserNameControl.text;

    Global.departMent = 0;

    await CachHelper.SetData(key: 'mobile', value: Global.mobile);
    await CachHelper.SetData(key: 'userName', value: Global.userName);
    await CachHelper.SetData(key: 'departmentId', value: Global.departMent);
    await CachHelper.SetData(key: 'showOnBoarding', value: false);
    await CachHelper.SetData(key: 'isUserLogin', value: true);
    await CachHelper.SetData(key: 'isAdmin', value: isAdmin);

    FirebaseFirestore.instance
        .collection('User')
        .doc(Global.mobile)
        .get()
        .then((value) async {
      userModel = UserModel.fromJson(value.data());
      Global.imageUrl = userModel.image;
      await CachHelper.SetData(key: 'imageUrl', value: Global.imageUrl);
      if (userModel.mobile != null) {

        rgisterBtnController.success();
        await Future.delayed(const Duration(seconds: 1));
        rgisterBtnController.reset();
        NavigatToAndReplace(context, const HomeLayout());

      } else {
        firebase_storage.FirebaseStorage.instance
            .ref()
            .child(
            'User/${Uri.file(finalPickedUserImage.path).pathSegments.last}')
            .putFile(finalPickedUserImage)
            .then((value) {
          value.ref.getDownloadURL().then((value) async {
            UserModel model = UserModel(
              isActive: false,
              image: value,
              currentBalance: 0,
              createdDate: DateTime.now().toString(),
              isAdmin: isAdmin,
              departmentId: 0,
              mobile: Global.mobile,
              userName: Global.userName,
              fireBaseToken: Global.fireBaseToken,
            );
            Global.imageUrl = value;
            await CachHelper.SetData(key: 'imageUrl', value: Global.imageUrl);
            FirebaseFirestore.instance
                .collection('User')
                .doc(Global.mobile)
                .set(model.toMap())
                .then((value) async {
              rgisterBtnController.success();
              await Future.delayed(const Duration(seconds: 1));
              rgisterBtnController.reset();
              NavigatToAndReplace(context, const HomeLayout());
            }).catchError((e) async {
              if (kDebugMode) {

                rgisterBtnController.error();
                await Future.delayed(const Duration(seconds: 1));
                rgisterBtnController.reset();
                print(e);
              }
            });
          });
        });
      }
    }).catchError((error) {
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child(
          'User/${Uri.file(finalPickedUserImage.path).pathSegments.last}')
          .putFile(finalPickedUserImage)
          .then((value) {
        value.ref.getDownloadURL().then((value) async {
          UserModel model = UserModel(
            isActive: false,
            image: value,
            currentBalance: 0,
            createdDate: DateTime.now().toString(),
            isAdmin: isAdmin,
            departmentId: 0,
            mobile: Global.mobile,
            userName: Global.userName,
            fireBaseToken: Global.fireBaseToken,
          );
          Global.imageUrl = value;
          await CachHelper.SetData(key: 'imageUrl', value: Global.imageUrl);
          FirebaseFirestore.instance
              .collection('User')
              .doc(Global.mobile)
              .set(model.toMap())
              .then((value) async {
            rgisterBtnController.error();
            await Future.delayed(const Duration(seconds: 1));
            rgisterBtnController.reset();
            NavigatToAndReplace(context, const HomeLayout());
          }).catchError((e) async {
            if (kDebugMode) {
              rgisterBtnController.error();
              await Future.delayed(const Duration(seconds: 1));
              rgisterBtnController.reset();
              print(e);
            }
          });
        });
      });
    });
  }
  //
  // List<UserModel> listUser = [];
  //
  // getUsers() async {
  //   FirebaseFirestore.instance.collection('User').snapshots().listen((event) {
  //     listUser = event.docs.map((x) => UserModel.fromJson(x.data())).toList();
  //
  //     emit(LoginSuccessState());
  //   }).onError((handleError) {
  //     print(handleError);
  //   });
  // }
  String departMentSelectedName = '';
  TextEditingController txtProjectMobileControl = TextEditingController();

  List<Project> listProject = [];

  getAllProjects() async {
    FirebaseFirestore.instance
        .collection('Projects')
        .snapshots()
        .listen((event) {
      listProject = event.docs.map((x) => Project.fromJson(x.data())).toList();
      emit(Refersh());
    });
  }
  registerAndLoginAdmin(context) async {

    Global.userName = txtRegisterUserNameControl.text;
    Global.departMent = HomeCubit.get(context).departMentList.indexWhere((element) => element == departMentSelectedName);


    await CachHelper.SetData(key: 'mobile', value: Global.mobile);
    await CachHelper.SetData(key: 'userName', value: Global.userName);
    await CachHelper.SetData(key: 'departmentId', value: Global.departMent);
    await CachHelper.SetData(key: 'showOnBoarding', value: false);
    await CachHelper.SetData(key: 'isUserLogin', value: true);
    await CachHelper.SetData(key: 'isAdmin', value: true);


    // Upload User


    FirebaseFirestore.instance
        .collection('User')
        .doc(Global.mobile)
        .get()
        .then((value) async {
      userModel = UserModel.fromJson(value.data());
      Global.imageUrl = userModel.image;
      await CachHelper.SetData(key: 'imageUrl', value: Global.imageUrl);
      if (userModel.mobile != null) {

        rgisterBtnController.success();
        await Future.delayed(const Duration(seconds: 1));
        rgisterBtnController.reset();
        // NavigatToAndReplace(context, const HomeLayout());

      } else {
        firebase_storage.FirebaseStorage.instance
            .ref()
            .child(
            'User/${Uri.file(finalPickedUserImage.path).pathSegments.last}')
            .putFile(finalPickedUserImage)
            .then((value) {
          value.ref.getDownloadURL().then((value) async {
            UserModel model = UserModel(
              isActive: false,
              image: value,
              currentBalance: 0,
              createdDate: DateTime.now().toString(),
              isAdmin: isAdmin,
              departmentId: 0,
              mobile: Global.mobile,
              userName: Global.userName,
              fireBaseToken: Global.fireBaseToken,
            );
            Global.imageUrl = value;
            await CachHelper.SetData(key: 'imageUrl', value: Global.imageUrl);
            FirebaseFirestore.instance
                .collection('User')
                .doc(Global.mobile)
                .set(model.toMap())
                .then((value) async {
              rgisterBtnController.success();
              await Future.delayed(const Duration(seconds: 1));
              rgisterBtnController.reset();

            }).catchError((e) async {
              if (kDebugMode) {



                rgisterBtnController.reset();
                print(e);
              }
            });
          });
        });
      }
    }).catchError((error) {
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child(
          'User/${Uri.file(finalPickedUserImage.path).pathSegments.last}')
          .putFile(finalPickedUserImage)
          .then((value) {
        value.ref.getDownloadURL().then((value) async {
          UserModel model = UserModel(
            isActive: false,
            image: value,
            currentBalance: 0,
            createdDate: DateTime.now().toString(),
            isAdmin: isAdmin,
            departmentId: 0,
            mobile: Global.mobile,
            userName: Global.userName,
            fireBaseToken: Global.fireBaseToken,
          );
          Global.imageUrl = value;
          await CachHelper.SetData(key: 'imageUrl', value: Global.imageUrl);
          FirebaseFirestore.instance
              .collection('User')
              .doc(Global.mobile)
              .set(model.toMap())
              .then((value) async {


            rgisterBtnController.reset();
            // NavigatToAndReplace(context, const HomeLayout());
          }).catchError((e) async {
            if (kDebugMode) {
              rgisterBtnController.error();

              rgisterBtnController.reset();
              print(e);
            }
          });
        });
      });
      });



    // Upload Project
    FirebaseFirestore.instance
        .collection('Projects')
        .doc(txtProjectMobileControl.text)
        .get()
        .then((value) async {
          print('1');
          print(value.data());
          print('1');


      if (value.data() != null) {
        projectModel = Project.fromJson(value.data());
        Global.projectImageUrl = projectModel.image;
        await CachHelper.SetData(key: 'ProjectImageUrl', value: Global.projectImageUrl);
        rgisterBtnController.success();
        await Future.delayed(const Duration(seconds: 1));
        rgisterBtnController.reset();
        print('2');
        Global.isAdmin = isAdmin;
        NavigatToAndReplace(context, const HomeLayout());

      } else {
        print('3');
        firebase_storage.FirebaseStorage.instance
            .ref()
            .child(
            'Project/${Uri.file(finalPickedProjectImage.path).pathSegments.last}')
            .putFile(finalPickedProjectImage)
            .then((value) {
          print('4');
          value.ref.getDownloadURL().then((value) async {

            Global.projectImageUrl = value;
            Project model = Project(
              isActive: false,
              image: value,

              createdDate: DateTime.now().toString(),
             adminMobile: Global.mobile,
              id:  1,
              name: txtRegisterProjectNameControl.text,
              projectMobile: txtProjectMobileControl.text
            );
            print('5');
            await CachHelper.SetData(key: 'ProjectImageUrl', value: Global.projectImageUrl);
            print('6');
            FirebaseFirestore.instance
                .collection('Projects')
                .doc(Global.mobile)
                .set(model.toMap())
                .then((value) async {
              rgisterBtnController.success();
              await Future.delayed(const Duration(seconds: 1));
              rgisterBtnController.reset();
              Global.isAdmin = isAdmin;
              NavigatToAndReplace(context, const HomeLayout());
            }).catchError((e) async {
              if (kDebugMode) {

                rgisterBtnController.error();
                await Future.delayed(const Duration(seconds: 1));
                rgisterBtnController.reset();
                Global.isAdmin = isAdmin;
                NavigatToAndReplace(context, const HomeLayout());
                print(e);
              }
            });
          });
        });
      }
    }).catchError((error) {
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child(
          'Project/${Uri.file(finalPickedProjectImage.path).pathSegments.last}')
          .putFile(finalPickedProjectImage)
          .then((value) {
        value.ref.getDownloadURL().then((value) async {
          Project model = Project(
              isActive: false,
              image: value,

              createdDate: DateTime.now().toString(),
              adminMobile: Global.mobile,
              id: listProject.length + 1,
              name: txtRegisterProjectNameControl.text,
              projectMobile: txtProjectMobileControl.text
          );

          await CachHelper.SetData(key: 'ProjectImageUrl', value: Global.projectImageUrl);
          FirebaseFirestore.instance
              .collection('Projects')
              .doc(Global.mobile)
              .set(model.toMap())
              .then((value) async {
            rgisterBtnController.success();
            await Future.delayed(const Duration(seconds: 1));
            rgisterBtnController.reset();
            NavigatToAndReplace(context, const HomeLayout());
          });
        });
      });
      });







  }
  RoundedLoadingButtonController rgisterBtnController = RoundedLoadingButtonController();
  void removeUploadImage(context) {
    finalPickedUserImage = null;
    changeRegisterValidState();
    emit(Refersh());
  }

  void removeUploadProjectImage(context) {
    finalPickedProjectImage = null;
    changeRegisterValidState();
    emit(Refersh());
  }


  TextEditingController txtRegisterUserNameControl = TextEditingController();
  TextEditingController txtRegisterProjectNameControl = TextEditingController();
  bool registerValid = false;

  changeRegisterValidState() {
    if (isAdmin && txtRegisterUserNameControl.text.trim() != '' && txtRegisterUserNameControl.text.trim() != '' &&
        finalPickedUserImage != null &&  finalPickedProjectImage != null
        && txtProjectMobileControl.text.trim() != '' && txtProjectMobileControl.text != null
    ) {
      registerValid = true;
    } else if (!isAdmin && txtRegisterUserNameControl.text.trim() != '') {
      registerValid = true;
    } else {
      registerValid = false;
    }

    emit(Refersh());
  }
  resendActivationCode(context) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+2' + LoginCubit.get(context).textMobileControl.text,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int resendToken) {
        LoginCubit.get(context).verificationCode = verificationId;

        emit(RegisterSuccessState());
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
