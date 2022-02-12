// @dart=2.9

// Eslam22
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




import 'bloc/SocialCubit/SocialCubit.dart';
import 'bloc/home_bloc/HomeCubit.dart';
import 'bloc/login_bloc/loginCubit.dart';


import 'modules/login/login_screen.dart';



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
  MyApp();


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    // print(showOnboarding);
    // print(isUserLogined);



    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => LoginCubit()),
          // BlocProvider(create: (context) => HomeCubit()..getUserFavourit()),
          // BlocProvider(create: (context) => SocialCubit()),
        ],
        child: MaterialApp(
          theme: ThemeData(visualDensity: VisualDensity.adaptivePlatformDensity,),
          debugShowCheckedModeBanner: false,
          // home:showOnboarding? FirstHomeScreen(): isUserLogined?  LayOutScreen() : LoginScreen(),
           home:LoginScreen(),
          // home:VerifiedScreen(),
          // home:RegisterScreen(),
        ));


  }
}
