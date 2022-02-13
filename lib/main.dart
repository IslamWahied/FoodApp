// @dart=2.9

// ignore_for_file: must_be_immutable, non_constant_identifier_names


import 'package:elomda/bloc/Upload_products/upload_products_cubit.dart';
import 'package:elomda/bloc/home_bloc/HomeCubit.dart';
import 'package:elomda/home_layout/cubit/cubit.dart';
import 'package:elomda/home_layout/home_layout.dart';
import 'package:elomda/modules/upload_products/upload_products.dart';
import 'package:elomda/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




import 'bloc/login_bloc/loginCubit.dart';





Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // await CachHelper.init();
  // DioHelper.intit();
  //
  // String mobile =  CachHelper.GetData(key: 'Mobile');
  // String userName = CachHelper.GetData(key: 'UserName');
  // String userType = CachHelper.GetData(key: 'UserType');


  // bool isUserLogined  = false;
  //
  // bool showOnboarding  = CachHelper.GetData(key: 'showOnboarding') != null || CachHelper.GetData(key: 'showOnboarding') == false ? false :true ;
  //
  //
  //
  // if(
  // mobile != null && mobile.trim() != '' &&
  //     userType != null && userType.trim() != '' &&
  //     userName !=null   && userName.trim() != ''
  // ){
  //
  //   isUserLogined = true;
  //   Global.Mobile = mobile;
  //   Global.userName = userName;
  //   Global.UserType = userType;
  //
  // }
  // else{
  //   isUserLogined = false;
  // }
  //
  //
  // if(showOnboarding == null && showOnboarding != false )
  // {
  //   showOnboarding = true;
  // }
  //
  //
  // print(showOnboarding);

  // runApp(MyApp(userName: userName,Mobile: mobile , UserType: userType ,showOnboarding: showOnboarding,isUserLogined: isUserLogined,));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  String userName;
  String Mobile;
  String UserType;
  bool isUserLogined;
  bool showOnboarding;
  MyApp({Key key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {





    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => LoginCubit()),
          BlocProvider(create: (context) => UploadProducts()),
          BlocProvider(create: (context) => HomeLayoutCubit()),
          BlocProvider(create: (context) => HomeScreenCubit()),
          // BlocProvider(create: (context) => HomeCubit()..getUserFavourit()),
          // BlocProvider(create: (context) => SocialCubit()),
        ],
        child: MaterialApp(
          theme: Constants.lightTheme,
          debugShowCheckedModeBanner: false,
          // home:showOnboarding? FirstHomeScreen(): isUserLogined?  LayOutScreen() : LoginScreen(),
           home:  HomeLayout(),
          // home:VerifiedScreen(),
          // home:RegisterScreen(),
        ));


  }
}
