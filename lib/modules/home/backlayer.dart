// @dart=2.9
// ignore_for_file: must_be_immutable

import 'package:elomda/bloc/home_bloc/HomeCubit.dart';
import 'package:elomda/bloc/home_bloc/HomeState.dart';
import 'package:elomda/modules/upload_products/upload_products.dart';
import 'package:elomda/shared/components/componant.dart';
import 'package:elomda/styles/icons/my_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BackLayerMenu extends StatelessWidget {
  BackLayerMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeScreenState>(
        builder: (context, state) {
      //   var home_layout_bloc = HomeScreenCubit.get(context);
          return Stack(

            fit: StackFit.expand,
            children: [
              Ink(
                decoration: const BoxDecoration(

                  color: Colors.black
                ),
              ),

              SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                       const Center(
                        child: CircleAvatar(
                          radius: 45,

                          backgroundImage: NetworkImage(
                              'https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Unknown_person.jpg/542px-Unknown_person.jpg',
                          )

                        ),




                      ),
                      const SizedBox(height: 5.0),
                      content(context, () {
                       // navigateTo(context, const Feeds());
                      }, 'Feeds', 0),
                      const SizedBox(height: 5.0),
                      content(context, () {
                       // navigateTo(context, const Cart());
                      }, 'Cart', 1),
                      const SizedBox(height: 5.0),
                      content(context, () {
                        //navigateTo(context, const WishList());
                      }, 'Wishlist', 2),
                      const SizedBox(height: 5.0),
                      content(context, () {
                        navigateTo(context, const UploadProductForm());
                      }, 'Upload a new product', 3),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        listener: (context, state) {});
  }

  final List _contentIcons = [
    MyAppIcons.rss,
    MyAppIcons.bag,
    MyAppIcons.wishlist,
    MyAppIcons.upload
  ];

  Widget content(BuildContext ctx, Function fct, String text, int index) {
    return InkWell(
      onTap: fct,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.w700,color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          Icon(_contentIcons[index],color: Colors.deepOrange,)
        ],
      ),
    );
  }
}
