// @dart=2.9

// ignore_for_file: deprecated_member_use

import 'package:elomda/bloc/home_layout_bloc/cubit.dart';
import 'package:elomda/bloc/home_layout_bloc/state.dart';
import 'package:elomda/shared/components/componant.dart';
import 'package:elomda/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'cart_empty.dart';

class Cart extends StatelessWidget {
  const Cart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, HomeLayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeLayoutCubit.get(context);

        return cubit.cartItems.isNotEmpty
            ? const Scaffold(
                body: Cart_Empty(),
              )
            : Scaffold(
                body: Container(
                  margin: const EdgeInsets.only(bottom: 60),
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return cartWidget(
                            context,
                            cubit.cartItems.values.toList()[index].id,
                            cubit.cartItems.values.toList()[index].price,
                            cubit.cartItems.values.toList()[index].quantity,
                            cubit.cartItems.values.toList()[index].title,
                            cubit.cartItems.values.toList()[index].imageUrl);
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 5,
                          ),
                      itemCount: cubit.cartItems.length),
                ),
                bottomSheet: Padding(
                  padding: const EdgeInsets.only(bottom: 70),
                  child: checkoutSection(
                      context, HomeLayoutCubit.get(context).totalAmount),
                ),
              );
      },
    );
  }

  Widget cartWidget(context, String id, double price, int quantity,
          String title, String imageUrl) =>
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: HomeLayoutCubit.get(context).isDarkTheme == false
                    ? Colors.white
                    : Constants.backgroundColor,
              ),
              child: Row(
                children: [
                  Container(
                    width: 130,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(16.0),
                            topLeft: Radius.circular(16.0)),
                        image: DecorationImage(
                            image: NetworkImage(
                              imageUrl,
                            ),
                            fit: BoxFit.contain)),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                            ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(32.0),
                                onTap: () {
                                  showDialogAlairt(context, 'Remove item!',
                                      'Product will be removed from the cart!',
                                      () {
                                    HomeLayoutCubit.get(context)
                                        .removeCartItem(id);
                                    Navigator.pop(context);
                                  });
                                },
                                child: const SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: Icon(
                                    Entypo.cross,
                                    color: Colors.red,
                                    size: 22,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              'Price: ',
                              style: TextStyle(color: Colors.black),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '$price\$',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: HomeLayoutCubit.get(context)
                                              .isDarkTheme ==
                                          false
                                      ? Colors.brown.shade900
                                      : Theme.of(context)
                                          .colorScheme
                                          .secondary),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              'Sub Total:',
                              style: TextStyle(color: Colors.black),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            FittedBox(
                              child: Text(
                                '${HomeLayoutCubit.get(context).subTotal(price, quantity).toStringAsFixed(2)}\$',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: HomeLayoutCubit.get(context)
                                                .isDarkTheme ==
                                            false
                                        ? Colors.brown.shade900
                                        : Theme.of(context)
                                            .colorScheme
                                            .secondary),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Ships Free',
                              style: TextStyle(
                                  color: HomeLayoutCubit.get(context)
                                              .isDarkTheme ==
                                          false
                                      ? Colors.brown.shade900
                                      : Theme.of(context)
                                          .colorScheme
                                          .secondary),
                            ),
                            const Spacer(),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(4.0),
                                onTap: () {
                                  if (quantity < 2) {
                                    () {};
                                  } else {
                                    HomeLayoutCubit.get(context)
                                        .MinseCartQuantity(
                                            id, price, title, imageUrl);
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(5.0),
                                  child: const Icon(
                                    Entypo.minus,
                                    color: Colors.red,
                                    size: 22,
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              elevation: 12,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.12,
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    Constants.gradiendLStart,
                                    Constants.gradiendLEnd,
                                  ], stops: const [
                                    0.0,
                                    0.7
                                  ]),
                                ),
                                child: Text(
                                  quantity.toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(4.0),
                                onTap: () {
                                  HomeLayoutCubit.get(context).addProductToCart(
                                      id, price, title, imageUrl);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(5.0),
                                  child: const Icon(
                                    Entypo.plus,
                                    color: Colors.green,
                                    size: 22,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      );

  Widget checkoutSection(context, double total) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey, width: 0.5))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(colors: [
                    Constants.gradiendLStart,
                    Constants.gradiendLEnd,
                  ], stops: const [
                    0.0,
                    0.7
                  ]),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(30),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Checkout',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Theme.of(context).textSelectionColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            Text(
              'Total: ',
              style: TextStyle(
                  color: Theme.of(context).textSelectionColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              'US \$${total.toStringAsFixed(3)}',
              //${HomeLayoutCubit.get(context).totalAmount},
              //textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
