// @dart=2.9
// ignore_for_file: must_be_immutable

import 'package:elomda/bloc/UpdateData/updateDataCubit.dart';
import 'package:elomda/bloc/Upload_products/upload_products_cubit.dart';
import 'package:elomda/bloc/home_bloc/HomeCubit.dart';

import 'package:elomda/home_layout/home_layout.dart';
import 'package:elomda/modules/login/login_screen.dart';
import 'package:elomda/styles/colors.dart';
import 'package:elomda/shared/network/Dio_Helper/Dio_Helper.dart';
import 'package:elomda/shared/network/local/shared_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'bloc/login_bloc/loginCubit.dart';

import 'shared/Global.dart';

//  https://flutterawesome.com/an-awesome-flutter-food-delivery-app-ui/

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
   FirebaseMessaging.instance;

   await CachHelper.init();
    DioHelper.init();

   String mobile =  CachHelper.GetData(key: 'mobile');
    String userName = CachHelper.GetData(key: 'userName');
 String departmentId = CachHelper.GetData(key: 'departmentId');
  FirebaseMessaging.onMessage.listen((event) {


  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('A new onMessageOpenedApp event was published!');
    // Navigator.pushNamed(context, '/message',
    //     arguments: MessageArguments(message, true));
  });

  FirebaseMessaging.onBackgroundMessage((message) {

    print('onBackgroundMessage!');

  });

    bool isUserLogin  = false;

   bool showOnBoarding  = CachHelper.GetData(key: 'showOnBoarding') != null || CachHelper.GetData(key: 'showOnBoarding') == false ? false :true ;



  if(
  mobile != null && mobile.trim() != '' &&
      departmentId != null && departmentId.trim() != '' &&
      userName !=null   && userName.trim() != ''
  ){

    isUserLogin = true;
    Global.mobile = mobile;
    Global.userName = userName;
     // Global.departmentId = departmentId;

  }
  else{
    isUserLogin = false;
  }


  if(showOnBoarding == null && showOnBoarding != false )
  {
    showOnBoarding = true;
  }

  String token = await FirebaseMessaging.instance.getToken();
print(token);
   Global.fireBaseToken = token??'';

    runApp(MyApp(userName: userName,mobile: mobile , departmentId: departmentId ,showOnBoarding: showOnBoarding,isUserLogin: isUserLogin,));

}

class MyApp extends StatelessWidget {

  String userName;
  String mobile;
  String departmentId;
  bool isUserLogin;
  bool showOnBoarding;
  MyApp({Key key,
    this.userName,
    this.mobile,
    this.departmentId,
    this.showOnBoarding,
    this.isUserLogin,

}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {





    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => LoginCubit()),
          BlocProvider(create: (context) => UploadProducts()),
          BlocProvider(create: (context) => UpdateDataCubit()),
          BlocProvider(create: (context) => HomeCubit()..getOrders()..getCategory()..getUsers()..getSubCategory()..getItems()..getAdditions()..getFavourite()),
        ],
        child: MaterialApp(
          theme: Constants.lightTheme,
          builder: EasyLoading.init(),
          debugShowCheckedModeBanner: false,
          //home:showOnboarding? FirstHomeScreen(): isUserLogined?  LayOutScreen() : LoginScreen(),
            home:  const HomeLayout(),
          //home:showOnboarding? FirstHomeScreen(): isUserLogined?  LayOutScreen() : LoginScreen(),
          // home:const LoginScreen(),
          // home:VerifiedScreen(),
       //  home:const RegisterScreen(),
        ));


  }
}
