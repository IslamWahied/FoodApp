// @dart=2.9

import 'package:elomda/bloc/home_bloc/HomeCubit.dart';
import 'package:elomda/bloc/home_bloc/HomeState.dart';
import 'package:elomda/home_layout/home_layout.dart';
import 'package:elomda/shared/Global.dart';
import 'package:elomda/shared/components/Componant.dart';
import 'package:elomda/shared/network/local/helper.dart';
import 'package:elomda/styles/icons/my_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'UserAccount/UserAccountScreen.dart';
import 'order/orders.dart';

class UserBackLayerMenu extends StatelessWidget {
  UserBackLayerMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return Stack(
            fit: StackFit.expand,
            children: [
              Ink(
                decoration:   BoxDecoration(color: Colors.black.withOpacity(0.8)),

              ),
              SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Global.imageUrl != null &&
                                Global.imageUrl.trim() != ''
                            ? CircleAvatar(
                                radius: 30.0,
                                backgroundImage: NetworkImage(Global.imageUrl),
                                backgroundColor: Colors.transparent,
                              )
                            : const CircleAvatar(
                                radius: 45,
                                backgroundImage:
                                    AssetImage('assets/person.jpg'),
                              ),
                      ),
                      const SizedBox(height: 5.0),

                      content(context, () {
                        navigateTo(context, const UserAccountScreen());
                      }, 'حسابي', 1),
                      content(context, () {
                        cubit.isShowBackLayer = false;
                        navigateTo(context, const HomeLayout());
                        cubit.changeCurrentIndex(4);
                      }, 'الصفحة الشخصية', 3),

                      content(context, () {
                        cubit.isShowBackLayer = false;
                        navigateTo(context,  OrdersScreen());
                        // cubit.changeCurrentIndex(4);
                      }, 'متابعة الطلبات', 3),
                      const SizedBox(height: 5.0),
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
    MyAppIcons.upload,
    MyAppIcons.upload_cloud,
    MyAppIcons.rss,
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
              style: const TextStyle(
                  fontWeight: FontWeight.w700, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          Icon(
            _contentIcons[index],
            color: Colors.deepOrange,
          )
        ],
      ),
    );
  }
}
