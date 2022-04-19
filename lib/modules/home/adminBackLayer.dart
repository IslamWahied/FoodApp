// @dart=2.9
import 'package:elomda/bloc/UpdateData/updateDataCubit.dart';
import 'package:elomda/bloc/home_bloc/HomeCubit.dart';
import 'package:elomda/bloc/home_bloc/HomeState.dart';
import 'package:elomda/home_layout/home_layout.dart';
import 'package:elomda/modules/Update_Data/UpdateData.dart';
import 'package:elomda/modules/adminBackLayerOpations/customerAccount/customerAccount.dart';
import 'package:elomda/modules/adminBackLayerOpations/sendNotifacation.dart';
import 'package:elomda/modules/cart/cart_screen.dart';
import 'package:elomda/modules/favourite/feeds_screen.dart';
import 'package:elomda/modules/upload_products/upload_products.dart';
import 'package:elomda/shared/Global.dart';
import 'package:elomda/shared/components/componant.dart';
import 'package:elomda/shared/network/local/helper.dart';
import 'package:elomda/styles/icons/my_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminBackLayerMenu extends StatelessWidget {
  AdminBackLayerMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeScreenState>(
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return Stack(
            fit: StackFit.expand,
            children: [
              Ink(
                decoration: const BoxDecoration(color: Colors.black),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                Global.imageUrl != null?    Center(
                  child: CircleAvatar(
                    radius: 60.0,
                    backgroundImage:
                    NetworkImage(Global.imageUrl),
                    backgroundColor: Colors.transparent,
                  ),
                )   : const Center(
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage('assets/person.jpg'),

                      ),
                    ),
                    const SizedBox(height: 5.0),

                    content(context, () {
                      navigateTo(context,  const SendNotifacationScreen());
                      // HomeCubit.get(context).changeCurrentIndex(3);
                    }, 'ارسال عرض', 0),
                    const SizedBox(height: 5.0),

                    content(context, () {
                      navigateTo(context,  const UploadProductForm());
                      // HomeCubit.get(context).changeCurrentIndex(3);
                    }, 'اضافة منتج', 0),
                    const SizedBox(height: 5.0),


                    content(context, () {

                      navigateTo(context,  const UpdateDataScreen());
                      HomeCubit.get(context).changeCurrentIndex(1);
                    }, 'تعديل منتجات', 1),
                    const SizedBox(height: 5.0),

                    // content(context, () {
                    //   UpdateDataCubit.get(context).restAfterUpload(context);
                    //   UpdateDataCubit.get(context).selectedTypeItemId = 1;
                    //   navigateTo(context, const UpdateDataScreen());
                    // }, 'حذف منتج', 2),
                    //
                    // const SizedBox(height: 5.0),
                    content(context, () {
                      cubit.selectedUserId = '';

                      navigateTo(context, const CustomerAccountScreen());
                    }, 'حسابات العملاء',3),


                    const SizedBox(height: 5.0),
                    content(context, () {
                      navigateTo(context, const UploadProductForm());
                    }, 'كشف حسابي',4),


                  ],
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
  ];
  final List  admincontentIcons = [
    MyAppIcons.sendNotifacation,
    MyAppIcons.edit,
    MyAppIcons.delete,
    MyAppIcons.customerAcount,
    MyAppIcons.myAcount,
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
            Global.isAdmin?admincontentIcons[index] : _contentIcons[index],
            color: Colors.deepOrange,
          )
        ],
      ),
    );
  }
}
