// @dart=2.9



import 'package:elomda/home_layout/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());


  static HomeCubit get(BuildContext context) => BlocProvider.of(context);
}