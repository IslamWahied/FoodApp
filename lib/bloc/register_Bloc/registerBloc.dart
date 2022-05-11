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
import 'package:elomda/shared/Global.dart';
import 'package:elomda/shared/network/local/helper.dart';
import 'package:elomda/shared/network/local/shared_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  bool activationDone = false;
  bool verifiedIsValid = false;


  final formProjectInfoKey = GlobalKey<FormState>();

  int endTime = DateTime.now().millisecondsSinceEpoch + 4000 * 30;
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

  List<UserModel> listUser = [];
  getUsers() async {
    FirebaseFirestore.instance.collection('User').snapshots().listen((event) {
      listUser = event.docs.map((x) => UserModel.fromJson(x.data())).toList();


    }).onError((handleError) {
      if (kDebugMode) {
        print(handleError);
      }
    });
  }

  signInWithPhoneAuthCredential(phoneAuthCredential, context) async {
    try {
      final authCredential = await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
      if (authCredential.user != null) {
        activationDone = true;

        await Future.delayed(const Duration(seconds: 2));

        bool isOldUser =
            listUser.any((element) => element.mobile == Global.mobile);

        if (isOldUser) {
          var userModel = listUser.firstWhere((element) =>
              element.mobile == LoginCubit.get(context).textMobileControl.text);

          Global.userName = userModel.userName;

          Global.mobile = userModel.mobile;

          Global.isAdmin = userModel.isAdmin;

          Global.imageUrl = userModel.image;

          Global.departMent = userModel.departmentId;

          if (userModel.isAdmin) {
            Global.projectId = listProject.firstWhere((element) => element.adminMobile == Global.mobile).id;
            Global.projectImageUrl = listProject.firstWhere((element) => element.id == Global.projectId).image;
            await CachHelper.SetData(key: 'ProjectId', value: Global.projectId);
          }

          if (Global.fireBaseToken != userModel.fireBaseToken) {
            if (userModel.fireBaseToken != Global.fireBaseToken) {
              userModel.fireBaseToken = Global.fireBaseToken;
              FirebaseFirestore.instance
                  .collection('User')
                  .doc(Global.mobile)
                  .update(userModel.toMap())
                  .then((value) async {});
            }
          }

          await CachHelper.SetData(key: 'mobile', value: Global.mobile);
          await CachHelper.SetData(key: 'isUserLogin', value: true);
          await CachHelper.SetData(key: 'isAdmin', value: userModel.isAdmin);
          await CachHelper.SetData(key: 'imageUrl', value: userModel.image);
          await CachHelper.SetData(key: 'imageUrl', value: userModel.image);
          await CachHelper.SetData(key: 'userName', value: userModel.userName);
          await CachHelper.SetData(
              key: 'departmentId', value: userModel.departmentId);

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
      if (e.message ==
          'The verification ID used to create the phone auth credential is invalid.') {
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

  bool isAdmin = false;
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


  void editProjectPickImageGallery(context) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    final pickedImageFile = File(pickedImage.path);
    finalPickedProjectImage = pickedImageFile;
    if(finalPickedProjectImage != null){
      registerValid = true;
    }
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

  registerAndLoginUser2(context) async {
    // Check Image Is Null

    if (finalPickedUserImage != null) {

      rgisterBtnController.start();
      // if not image null  Update User By Image
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
            isAdmin: false,
            departmentId: 0,
            address: txtRegisterUserAddressControl.text,
            mobile: Global.mobile,
            userName: txtRegisterUserNameControl.text,
            fireBaseToken: Global.fireBaseToken,
          );

          Global.imageUrl = value;

          await CachHelper.SetData(key: 'imageUrl', value: Global.imageUrl);

          FirebaseFirestore.instance
              .collection('User')
              .doc(Global.mobile)
              .set(model.toMap());
        }).then((value) async {

          // Save In CashHelper
          await CachHelper.SetData(key: 'mobile', value: Global.mobile);
          await CachHelper.SetData(key: 'userName', value: txtRegisterUserNameControl.text);
          await CachHelper.SetData(key: 'departmentId', value: 0);
          await CachHelper.SetData(key: 'showOnBoarding', value: false);
          await CachHelper.SetData(key: 'isUserLogin', value: true);
          await CachHelper.SetData(key: 'isAdmin', value: false);


          // Save Global
          Global.departMent = 0;
          Global.userName = txtRegisterUserNameControl.text;
          Global.isAdmin = false;
          Global.projectId = 0;

          // Go To Home
          rgisterBtnController.success();
          await Future.delayed(const Duration(seconds: 1));
          rgisterBtnController.reset();
          NavigatToAndReplace(context, const HomeLayout());
        });
      });
    }

    // Else Upload User Without Image
    else {
      rgisterBtnController.start();
      UserModel model = UserModel(
        isActive: false,
        image: '',
        currentBalance: 0,
        createdDate: DateTime.now().toString(),
        isAdmin: false,
        departmentId: 0,
        address: txtRegisterUserAddressControl.text,
        mobile: Global.mobile,
        userName: txtRegisterUserNameControl.text,
        fireBaseToken: Global.fireBaseToken,
      );
      if (kDebugMode) {

      }
      Global.imageUrl = '';
      await CachHelper.SetData(key: 'imageUrl', value: Global.imageUrl);
      if (kDebugMode) {

      }
      FirebaseFirestore.instance
          .collection('User')
          .doc(Global.mobile)
          .set(model.toMap())
          .then((value) async {
        await CachHelper.SetData(key: 'mobile', value: Global.mobile);
        await CachHelper.SetData(
            key: 'userName', value: txtRegisterUserNameControl.text);
        await CachHelper.SetData(key: 'departmentId', value: 0);
        await CachHelper.SetData(key: 'showOnBoarding', value: false);
        await CachHelper.SetData(key: 'isUserLogin', value: true);
        await CachHelper.SetData(key: 'isAdmin', value: false);

        // Save Global
        Global.departMent = 0;
        Global.userName = txtRegisterUserNameControl.text;
        Global.isAdmin = false;
        Global.projectId = 0;

        // Go To Home
        rgisterBtnController.success();
        await Future.delayed(const Duration(seconds: 1));
        rgisterBtnController.reset();
        NavigatToAndReplace(context, const HomeLayout());
      });
    }
  }

  registerAndLoginAdmin(context) async {


    if(listProject.any((element) => element.name.toLowerCase().trim() == txtRegisterProjectNameControl.text.toLowerCase().trim() )){

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'تم استخدام اسم المطعم من قبل',
            textAlign: TextAlign.center,
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
          behavior: SnackBarBehavior.floating,
          padding: EdgeInsets.all(20.0),
          duration: Duration(milliseconds: 4000)));


    }




   else if (isAdmin && registerValid) {
      rgisterBtnController.start();
      Global.userName = txtRegisterUserNameControl.text;
      Global.departMent = 0;
      Global.isAdmin = true;

      await CachHelper.SetData(key: 'mobile', value: Global.mobile);
      await CachHelper.SetData(key: 'userName', value: Global.userName);
      await CachHelper.SetData(key: 'departmentId', value: Global.departMent);
      await CachHelper.SetData(key: 'showOnBoarding', value: false);
      await CachHelper.SetData(key: 'isUserLogin', value: true);
      await CachHelper.SetData(key: 'isAdmin', value: true);

      if (finalPickedUserImage != null) {
        // if not image null  Update User By Image
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

              isAdmin: true,
              departmentId: 0,
              mobile: Global.mobile,

              userName: txtRegisterUserNameControl.text,
              fireBaseToken: Global.fireBaseToken,
            );

            Global.imageUrl = value;

            await CachHelper.SetData(key: 'imageUrl', value: Global.imageUrl);

            FirebaseFirestore.instance
                .collection('User')
                .doc(Global.mobile)
                .set(model.toMap());
          });
        });
      }
      // Else Upload User Without Image
      else {
        UserModel model = UserModel(
          isActive: false,
          image: '',
          currentBalance: 0,
          createdDate: DateTime.now().toString(),
          isAdmin: true,
          departmentId: 0,
          mobile: Global.mobile,
          userName: txtRegisterUserNameControl.text,
          fireBaseToken: Global.fireBaseToken,
        );

        Global.imageUrl = '';
        await CachHelper.SetData(key: 'imageUrl', value: Global.imageUrl);

        FirebaseFirestore.instance
            .collection('User')
            .doc(Global.mobile)
            .set(model.toMap());
      }

      // check if same Project Name
      if(!listProject.any((element) => element.name == txtRegisterProjectNameControl.text || element.projectMobile == txtProjectMobileControl.text)){


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
                address: txtRegisterUserAddressControl.text,
                createdDate: DateTime.now().toString(),
                adminMobile: Global.mobile,
                id: listProject.length + 1,
                name: txtRegisterProjectNameControl.text,
                projectMobile: txtProjectMobileControl.text);
            Global.projectImageUrl = value;
            Global.projectId = listProject.length + 1;
            await CachHelper.SetData(key: 'ProjectId', value: Global.projectId);


            FirebaseFirestore.instance
                .collection('Projects')
                .doc(Global.mobile)
                .set(model.toMap())
                .then((value) async {
              rgisterBtnController.success();
              await Future.delayed(const Duration(seconds: 1));
              rgisterBtnController.reset();
              Global.isAdmin = true;
              NavigatToAndReplace(context, const HomeLayout());
            }).catchError((erorr) async {

              rgisterBtnController.error();
              await Future.delayed(const Duration(seconds: 1));
              rgisterBtnController.reset();
              Global.isAdmin = false;

            });
          });
        });






      }

    }
  }




  updateProjectData({context,Project projectModel}) async {


    if(listProject.any((element) => element.name.toLowerCase().trim() == txtRegisterProjectNameControl.text.toLowerCase().trim() )){

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'تم استخدام اسم المطعم من قبل',
            textAlign: TextAlign.center,
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
          behavior: SnackBarBehavior.floating,
          padding: EdgeInsets.all(20.0),
          duration: Duration(milliseconds: 4000)));


    }

      // check if same Project Name

    if(finalPickedProjectImage != null){

      firebase_storage.FirebaseStorage.instance
          .ref()
          .child(
          'Project/${Uri.file(finalPickedProjectImage.path).pathSegments.last}')
          .putFile(finalPickedProjectImage)
          .then((value) {
        value.ref.getDownloadURL().then((value) async {


          Global.projectImageUrl = value;
          projectModel.image = value;
          projectModel.address = txtRegisterUserAddressControl.text;
          projectModel.name = txtRegisterProjectNameControl.text;


          FirebaseFirestore.instance.collection('Projects').doc(projectModel.adminMobile).update(projectModel.toMap()).then((value) async {

            await Future.delayed(const Duration(seconds: 1));
            rgisterBtnController.reset();
            txtRegisterUserNameControl.clear();
            txtRegisterUserAddressControl.clear();
          txtRegisterProjectNameControl.clear();
          txtProjectMobileControl.clear();

            NavigatToAndReplace(context, const HomeLayout());
          }).catchError((erorr) async {

            rgisterBtnController.error();
            await Future.delayed(const Duration(seconds: 1));
            rgisterBtnController.reset();


          });
        });
      });

    }
    else{

      Global.projectImageUrl = projectModel.image;


      projectModel.address = txtRegisterUserAddressControl.text;
      projectModel.name = txtRegisterProjectNameControl.text;



      await CachHelper.SetData(key: 'ProjectId', value: Global.projectId);


      FirebaseFirestore.instance
          .collection('Projects')
          .doc(Global.mobile)
          .update(projectModel.toMap())
          .then((value) async {

        await Future.delayed(const Duration(seconds: 1));
        rgisterBtnController.reset();
        txtRegisterUserNameControl.clear();
        txtRegisterUserAddressControl.clear();
        txtRegisterProjectNameControl.clear();
        txtProjectMobileControl.clear();
        NavigatToAndReplace(context, const HomeLayout());
      }).catchError((erorr) async {

        rgisterBtnController.error();
        await Future.delayed(const Duration(seconds: 1));
        rgisterBtnController.reset();


      });




    }







  }



  String departMentSelectedName = '';
  TextEditingController txtProjectMobileControl = TextEditingController();

  List<Project> listProject = [];

  getAllProjects() async {
    FirebaseFirestore.instance
        .collection('Projects')
        .snapshots()
        .listen((event) {
      listProject = event.docs.map((x) => Project.fromJson(x.data())).toList();

    });
  }

  RoundedLoadingButtonController rgisterBtnController =   RoundedLoadingButtonController();
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



  void removeEditProjectImage({BuildContext context,String address,String name}) {
    finalPickedProjectImage = null;
 changeUpdateValidState(address:  address,name: name);
    emit(Refersh());
  }

  TextEditingController txtRegisterUserNameControl = TextEditingController();
  TextEditingController txtRegisterUserAddressControl = TextEditingController();
  TextEditingController txtRegisterProjectNameControl = TextEditingController();
  bool registerValid = false;

  changeRegisterValidState() {
    if (isAdmin &&
        txtRegisterUserNameControl.text.trim() != '' &&
        txtRegisterUserAddressControl.text.trim() != '' &&

        finalPickedProjectImage != null &&
        txtProjectMobileControl.text.trim() != '' &&
        txtProjectMobileControl.text != null) {
      registerValid = true;
    } else if (!isAdmin && txtRegisterUserNameControl.text.trim() != '' && txtRegisterUserAddressControl.text.trim() != '') {
      registerValid = true;
    } else {
      registerValid = false;
    }

    emit(Refersh());
  }
  changeUpdateValidState({String name,String address}) {


    if (

        
        (txtRegisterProjectNameControl.text.trim() != '' && txtRegisterProjectNameControl.text.trim() != name.trim() )
        ||
        (txtRegisterUserAddressControl.text.trim() != '' && txtRegisterUserAddressControl.text.trim() != address.trim())
    ) {
      registerValid = true;
    } else if (!isAdmin && txtRegisterUserNameControl.text.trim() != '' && txtRegisterUserAddressControl.text.trim() != '') {
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
