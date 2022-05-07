// @dart=2.9
import 'package:badges/badges.dart';
import 'package:elomda/bloc/home_bloc/HomeCubit.dart';
import 'package:elomda/bloc/home_bloc/HomeState.dart';
import 'package:elomda/home_layout/home_layout.dart';
import 'package:elomda/shared/Global.dart';
import 'package:elomda/shared/components/Componant.dart';
import 'package:elomda/shared/network/local/helper.dart';
import 'package:elomda/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class FoodDetail extends StatelessWidget {
  final String imagePath;
  final String itemName;
  final String subCategoryTitle;
  final String itemDescription;
  final double itemPrice;
  final int orderCount;
  final bool isDiscount;

  const FoodDetail(
      {this.isDiscount,
      this.orderCount,
      this.imagePath,
      this.itemDescription,
      this.subCategoryTitle,
      this.itemName,
      this.itemPrice,
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            centerTitle: false,
            leadingWidth: 0,
            iconTheme: const IconThemeData(color: Constants.black),
            title: customAppBar(context: context, title: itemName,isYellow: true,isShowCarShop: true,),
          ),
          bottomSheet: BottomSheet(
            enableDrag: false,
            onClosing: () {},
            builder: (context) {
              return SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 62),
                  child: ElevatedButton(
                    onPressed: () {
                      cubit.addNewItemToCartFromFeedsScreen(
                          itemId: cubit.selectedItemId,
                          orderCount: orderCount ?? 1);
                      // cubit.listOrder.add(HomeCubit.get(context).listItemsSearch.firstWhere((element) => element.itemId == cubit.selectedItemId));
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        PrimaryText(
                          text: 'اضافة الي طلباتي',
                          fontWeight: FontWeight.w600,
                          size: 18,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.chevron_right)
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Constants.primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 20),
                        textStyle: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                  ),
                ),
              );
            },
          ),
          body: ListView(
            children: [
              // customAppBar(context),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Hero(
                          tag: imagePath,
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey[400], blurRadius: 30),
                              ],
                              borderRadius: BorderRadius.circular(100),
                            ),
                            height: 200,
                            width: 170,
                            child: Image.network(imagePath, fit: BoxFit.cover),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 160,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  if (isDiscount)
                                    PrimaryText(
                                      isDiscount: true,
                                      text: HomeCubit.get(context)
                                          .listItemsSearch
                                          .firstWhere((element) =>
                                              element.itemId ==
                                                  cubit.selectedItemId &&
                                              element.projectId ==
                                                  Global.projectId)
                                          .oldPrice
                                          .toString(),
                                      size: 25,
                                      fontWeight: FontWeight.w700,
                                      color: Constants.lighterGray,
                                      height: 1,
                                    ),
                                  SvgPicture.asset(
                                    'assets/dollar.svg',
                                    color: Constants.tertiary,
                                    width: 15,
                                  ),
                                  PrimaryText(
                                    text: itemPrice.toString(),
                                    size: 40,
                                    fontWeight: FontWeight.w700,
                                    color: Constants.tertiary,
                                    height: 1,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const PrimaryText(
                                text: 'التوصيل في',
                                fontWeight: FontWeight.w700,
                                size: 22),
                            const SizedBox(
                              height: 8,
                            ),
                            const PrimaryText(
                              text: '30 دقيقة',
                              color: Constants.secondary,
                              size: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 40,
                    ),
                    if (itemDescription != null && itemDescription.trim() != '')
                      const PrimaryText(
                          text: 'الوصف', fontWeight: FontWeight.w700, size: 22),
                    const SizedBox(
                      height: 10,
                    ),

                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      child: SingleChildScrollView(
                        child: Text(
                          itemDescription ?? '',
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            color: Constants.secondary,
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    if (cubit.listItemsSearch
                        .firstWhere((element) =>
                            element.itemId == cubit.selectedItemId &&
                            element.projectId == Global.projectId)
                        .additionsList
                        .isNotEmpty)
                      const SizedBox(
                        height: 50,
                      ),
                    if (cubit.listItemsSearch
                        .firstWhere((element) =>
                            element.itemId == cubit.selectedItemId &&
                            element.projectId == Global.projectId)
                        .additionsList
                        .isNotEmpty)
                      const PrimaryText(
                          text: 'الاضافات',
                          fontWeight: FontWeight.w700,
                          size: 22),
                    // if(cubit.listItemsSearch.firstWhere((element) => element.itemId == cubit.selectedItemId).additionsList.isNotEmpty)
                    // const SizedBox(
                    //   height: 15,
                    // ),
                  ],
                ),
              ),

              if (cubit.listItemsSearch
                  .firstWhere((element) =>
                      element.itemId == cubit.selectedItemId &&
                      element.projectId == Global.projectId)
                  .additionsList
                  .isNotEmpty)
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: cubit.listItemsSearch
                            .firstWhere((element) =>
                                element.itemId == cubit.selectedItemId &&
                                element.projectId == Global.projectId)
                            .additionsList
                            .length ??
                        0,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(
                          left: index == 0 ? 20 : 0, top: 10, bottom: 20),
                      child: additionCard(
                          imagePath: cubit.listItemsSearch
                              .firstWhere((element) =>
                                  element.itemId == cubit.selectedItemId &&
                                  element.projectId == Global.projectId)
                              .additionsList[index]
                              .image,
                          context: context,
                          cubit: cubit,
                          additionId: cubit.listItemsSearch
                              .firstWhere((element) =>
                                  element.itemId == cubit.selectedItemId &&
                                  element.projectId == Global.projectId)
                              .additionsList[index]
                              .itemId),
                    ),
                  ),
                ),
              // if(cubit.listItemsSearch.firstWhere((element) => element.itemId == cubit.selectedItemId).additionsList.isNotEmpty)
              // const SizedBox(
              //   height: 100,
              // )
            ],
          ),
        );
      },
    );
  }

  GestureDetector additionCard(
      {String imagePath, int additionId, HomeCubit cubit, context}) {
    return GestureDetector(
      onTap: () {
        if (cubit.listOfSelectedAdditions.any((element) =>
            element.itemId == additionId &&
            element.projectId == Global.projectId)) {
          cubit.listOfSelectedAdditions.removeWhere((element) =>
              element.itemId == additionId &&
              element.projectId == Global.projectId);
        } else {
          cubit.listOfSelectedAdditions.add(HomeCubit.get(context)
              .listAdditions
              .firstWhere((element) =>
                  element.itemId == additionId &&
                  element.projectId == Global.projectId));
        }
        cubit.emit(SelectCategoryState());
      },
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topRight,
        children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 9),
              margin: const EdgeInsets.only(
                right: 20,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: const Radius.circular(20),
                    bottomRight: const Radius.circular(20),
                    topLeft: const Radius.circular(20),
                    topRight: cubit.listOfSelectedAdditions
                            .any((element) => element.itemId == additionId)
                        ? const Radius.circular(0)
                        : const Radius.circular(20),
                  ),
                  color: Constants.white,
                  boxShadow: [
                    BoxShadow(blurRadius: 10, color: Colors.grey[300]),
                  ]),
              child: Column(
                children: [
                  Image.network(
                    imagePath,
                    width: 110,
                    height: 50,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        'assets/dollar.svg',
                        color: Constants.tertiary,
                        width: 10,
                        height: 10,
                      ),
                      PrimaryText(
                        text: HomeCubit.get(context)
                                .listAdditions
                                .firstWhere((element) =>
                                    element.itemId == additionId &&
                                    element.projectId == Global.projectId)
                                .price
                                .toString() ??
                            0.toString(),
                        size: 10,
                        fontWeight: FontWeight.w700,
                        color: Constants.tertiary,
                        height: 1,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  PrimaryText(
                    text: HomeCubit.get(context)
                            .listAdditions
                            .firstWhere((element) =>
                                element.itemId == additionId &&
                                element.projectId == Global.projectId)
                            .itemTitle
                            .toString() ??
                        ''.toString(),
                    size: 12,
                    fontWeight: FontWeight.w700,
                    color: Constants.darkBG,
                    height: 1,
                  ),
                ],
              )),
          if (cubit.listOfSelectedAdditions
              .any((element) => element.itemId == additionId))
            const Positioned(
                top: -10,
                right: 10,
                child: Icon(
                  Icons.check_circle,
                  color: Colors.green,
                )),
        ],
      ),
    );
  }
}

Padding customAppBar(
    {@required BuildContext context,@required String title,@required bool isShowCarShop,@required bool isYellow }) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 0,
      vertical: 10,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: isYellow?Constants.primary :  Constants.primary,
                borderRadius: BorderRadius.circular(15),

            ),
            child: const Icon(Icons.chevron_left,color: AppColors.white,),
          ),
        ),

        Text(
          title ?? '',
          style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
              overflow: TextOverflow.ellipsis),
        ),
        if (isShowCarShop)
        InkWell(
          onTap: () {
            NavigatToAndReplace(context, const HomeLayout());
            HomeCubit.get(context).changeCurrentIndex(3);
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 10, top: 15),
            child: Badge(
                badgeContent: Text(
                  HomeCubit.get(context)
                          .listOrder
                          .where((element) =>
                              element.projectId == Global.projectId)
                          .toList()
                          .length
                          .toString() ??
                      '0',
                  style: const TextStyle(color: Colors.white, fontSize: 11),
                ),
                child: Image.asset('assets/shoppingcart.png', width: 30)),
          ),
        ),
        if (!isShowCarShop)
            SizedBox(
            width:MediaQuery.of(context).size.width * .10,
          )
        // Container(
        //   padding: const EdgeInsets.all(10),
        //   decoration: BoxDecoration(
        //     color: Constants.primary,
        //     borderRadius: BorderRadius.circular(15),
        //   ),
        //   child: const Icon(Icons.star, color: Constants.white),
        // ),
      ],
    ),
  );
}
