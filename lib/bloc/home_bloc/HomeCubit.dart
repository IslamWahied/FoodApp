// // @dart=2.9
//
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import 'package:flutter/material.dart';
//
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:glccoffe/model/favourit/favouritModel.dart';
// import 'package:glccoffe/modules/favourit/favourit_Screen.dart';
// import 'package:glccoffe/modules/home/home_screen.dart';
// import 'package:glccoffe/modules/profile/profile_Screen.dart';
// import 'package:glccoffe/modules/social_app/chats/chats_screen.dart';
// import 'package:glccoffe/product.dart';
// import 'package:glccoffe/share/Global.dart';
//
// import 'HomeState.dart';
//
// class HomeCubit extends Cubit<HomeState> {
//   HomeCubit() : super(HomeInitState());
//
//   static HomeCubit get(context) => BlocProvider.of(context);
//
// int bottomNavSelected = 0;
// int productSelectedIndex = 0;
//
//   int sugercount = 0;
//   int cupsize = 1;
//
//   double width = 0;
//  double height = 0;
//
// List<Widget> screens = [
//   HomeScreen(),
//   FavoriteScreen(),
//   // NotesScreen(),
//   ChatsScreen(),
//   ProfileScreen()
// ];
//
//
//   var listproduct = products.toList();
//   String floorSelectedName = '';
//   int floorSelectedId = 0;
//
// var searchControl = TextEditingController();
//   changeCupSize(int size)
//   {
//     cupsize = size;
//     emit(changeCupSizeSelectedState());
//   }
//  bool isShowSearch = false;
//   changeIsShowSearch( )
//   {
//     isShowSearch = !isShowSearch;
//
//     emit(changeisShowSearchState());
//   }
//
//
//
//   search(value)
//   {
//     if(value == '')
//       {
//         listproduct = products.toList();
//       }
//     else
//       {
//         listproduct = products.where((element) => element.name.contains(value)).toList();
//       }
//
//
//     emit(changeCupSizeSelectedState());
//   }
//   changeCupSuger(int count)
//   {
//     sugercount = count;
//     emit(changeCupSizeSelectedState());
//   }
//
// changeBottomNavSelected(index)
// {
//   bottomNavSelected = index;
//
//   emit(changeBottomNavSelectedState());
// }
//
//
// List<FavouritModel> listFavourit;
//   getUserFavourit() async {
//     listFavourit = [];
//
//     if(Global.Mobile != '' && Global.Mobile != null)
//       {
//
//         FirebaseFirestore.instance.collection('Favourit').doc(Global.Mobile).collection('ItemModel').get().then((value) {
//
//
//           listFavourit =  value.docs.map((x) => FavouritModel.fromJson(x.data())).toList();
//
//
//
//           listFavourit.forEach((element2) {
//
//
//             listproduct.firstWhere((element1) => element1.Id == element2.ItemId ).isFavourit = element2.isFavourit;
//
//
//           });
//
//           listFavourit.forEach((element) {print(element.isFavourit);});
//
//           emit(changeBottomNavSelectedState());
//         }).catchError((erorr){
//
//           print(erorr);
//         });
//       }
//
//
//   }
//
//
//
//
// changeItemFavouritState(bool isFavourit,int ItemId)
// {
//
//   listproduct.firstWhere((element) => element.Id == ItemId).isFavourit  = !isFavourit;
//
//   emit(changeBottomNavSelectedState());
//   FavouritModel model =  FavouritModel(
//      isFavourit: !isFavourit,
//     ItemId: ItemId,
//     UesrMobile: Global.Mobile
//   );
//
//   print(model);
//
//   FirebaseFirestore.instance.collection('Favourit').doc(Global.Mobile).collection('ItemModel').doc(ItemId.toString()).update(model.toMap()).then((value){
//
//     print('updated');
//
//   }).catchError((onError){
//
//
//
//     FirebaseFirestore.instance.collection('Favourit').doc(Global.Mobile).collection('ItemModel').doc(ItemId.toString()).set(model.toMap()).then((value) {
//
//       print('inserted');
//
//
//     }).catchError(onError);
//
//
//
//   });
//
//
//
//
// }
//
// }