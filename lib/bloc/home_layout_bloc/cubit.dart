// @dart=2.9


import 'package:elomda/bloc/home_layout_bloc/state.dart';
import 'package:elomda/models/cart_attr_model.dart';
import 'package:elomda/modules/cart/cart.dart';

import 'package:elomda/modules/feeds/feeds_screen.dart';
import 'package:elomda/modules/home/home_screen.dart';
import 'package:elomda/modules/search/search_screen.dart';
import 'package:elomda/modules/user_info/user_info_screen.dart';
import 'package:elomda/shared/network/local/shared_helper.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeLayoutCubit extends Cubit<HomeLayoutState> {
  HomeLayoutCubit() : super(HomeInitialState());

  static HomeLayoutCubit get(BuildContext context) => BlocProvider.of(context);

  int currentIndex = 0;
  List screens = [
    HomeScreen(),

    SearchScreen(),
    Cart(),
    UserInfoScreen()
  ];

  void changecurrentIndex(int value) {
    currentIndex = value;
    emit(HomeChangeBottmNavState());
  }

  // Change Theme Mode

  bool isDarkTheme = false;

  // void mode({bool fromShared}) {
  //   if (fromShared != null) {
  //     isDarkTheme = fromShared;
  //     emit(HomeChangeThemeState());
  //   } else {
  //     isDarkTheme = !isDarkTheme;
  //     CachHelper.saveData(key: 'them', value: isDarkTheme).then((value) {
  //       emit(HomeChangeThemeState());
  //     });
  //   }
  // }


  Map<String, CartAttr> cartItems = {};

  double get totalAmount {
    var total = 0.0;

    cartItems.forEach((key, value) {
      total += value.price * value.quantity;
    });

    return total;
  }

  void addProductToCart(String id, double prise, String title,
      String imageUrl) {
    if (cartItems.containsKey(id)) {
      cartItems.update(id, (exitingCartItem) {
        return CartAttr(
            id: exitingCartItem.id,
            title: exitingCartItem.title,
            price: exitingCartItem.price,
            imageUrl: exitingCartItem.imageUrl,
            quantity: exitingCartItem.quantity + 1);
      });
      emit(HomeAddCartItemState());
    } else {
      cartItems.putIfAbsent(
          id,
              () =>
              CartAttr(
                  id: id,
                  title: title,
                  price: prise,
                  imageUrl: imageUrl,
                  quantity: 1));
      debugPrint(cartItems.toString());
      emit(HomeAddCartItemState());
    }
  }

  void MinseCartQuantity(String id, double prise, String title,
      String imageUrl) {
    if (cartItems.containsKey(id)) {
      cartItems.update(id, (exitingCartItem) {
        return CartAttr(
            id: exitingCartItem.id,
            title: exitingCartItem.title,
            price: exitingCartItem.price,
            imageUrl: exitingCartItem.imageUrl,
            quantity: exitingCartItem.quantity - 1);
      });
      emit(HomeQuantityMinesState());
    }
  }

  void removeCartItem(String id) {
    cartItems.remove(id);
    emit(HomeRemoveCartItemState());
  }

  void deletCarts() {
    cartItems.clear();
    emit(HomeRemoveCartsState());
  }

  double subTotal(double subtotal, int quantity) {
    return subtotal * quantity;
  }










}
