// @dart=2.9




import 'package:elomda/shared/network/Dio_Helper/Dio_Helper.dart';
import 'package:elomda/shared/network/local.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_layout/cubit/cubit.dart';
import 'home_layout/cubit/state.dart';

import 'modules/home.dart';

import 'shared/bloc_observer.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 // await Firebase.initializeApp();
//Bloc.observer=MyBlocObserver();

  await Cash_Helpper.init();
  bool themMode = Cash_Helpper.getData(key: 'them');
  DioHelper.init();

  runApp(MyApp(themMode: themMode));
}

class MyApp extends StatelessWidget {
  final bool themMode;

  MyApp({this.themMode});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (BuildContext context) => HomeCubit()),
        ],
        child: BlocConsumer<HomeCubit, HomeState>(
            listener: (BuildContext context, HomeState state) {},
            builder: (BuildContext context, HomeState state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                home: Home(),

              );
            }));
  }
}