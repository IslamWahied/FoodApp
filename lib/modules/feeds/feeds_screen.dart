//@dart=2.9
import 'package:badges/badges.dart';
import 'package:cart_stepper/cart_stepper.dart';
import 'package:elomda/bloc/home_bloc/HomeCubit.dart';
import 'package:elomda/bloc/home_bloc/HomeState.dart';
import 'package:elomda/shared/components/Componant.dart';
import 'package:elomda/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'FeedFoodDetail.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeScreenState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return SafeArea(
            child: Scaffold(
              backgroundColor: Constants.white,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20, top: 15),
                    child: Badge(
                        badgeContent: Text(
                          cubit.listOrder.length.toString() ?? '0',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 11),
                        ),
                        child:
                            Image.asset('assets/shoppingcart.png', width: 30)),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 20),
                      const Icon(
                        Icons.search,
                        color: AppColors.secondary,
                        size: 25,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                          child: TextField(
                        controller: cubit.txtFeedControl,
                        onChanged: (String value) {
                          cubit.searchInFeeds(value);
                        },
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2, color: AppColors.lighterGray)),
                          hintText: 'Search..',
                          hintStyle: TextStyle(
                              color: AppColors.lightGray,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      )),
                      const SizedBox(width: 20),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: cubit.listFeedsSearch.length ?? 0,
                        itemBuilder: (context, index) => itemCard(
                            itemId: cubit.listFeedsSearch[index].itemId,
                            itemPrice: cubit.listFeedsSearch[index].price,
                            subCategoryTitle:
                                cubit.listFeedsSearch[index].supCategoryTitle,
                            name: cubit.listFeedsSearch[index].itemTitle,
                            context: context,
                            imagePath: cubit.listFeedsSearch[index].image,
                            itemsPrice: cubit.listFeedsSearch[index].price,
                            star: '',
                            itemDescription:
                                cubit.listFeedsSearch[index].description ?? ''),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

Widget itemCard(
    {int itemId,
    String imagePath,
    String subCategoryTitle,
    double itemPrice,
    String name,
    String itemDescription,
    String star,
    context,
    double itemsPrice}) {
  int value = 1;
  return StatefulBuilder(builder: (context, setState) {
    return GestureDetector(
      onTap: () {
        HomeCubit.get(context).selectedItemId = itemId;
        HomeCubit.get(context).selectedCategoryId = HomeCubit.get(context)
            .listFeedsSearch
            .firstWhere((element) => element.itemId == itemId)
            .categoryId;
        HomeCubit.get(context).selectedSubCategoryId = HomeCubit.get(context)
            .listFeedsSearch
            .firstWhere((element) => element.itemId == itemId)
            .supCategoryId;

        navigateTo(
            context,
            FeedFoodDetailScreen(
              imagePath: HomeCubit.get(context)
                  .listFeedsSearch
                  .firstWhere((element) => element.itemId == itemId)
                  .image,
              subCategoryTitle: HomeCubit.get(context)
                  .listFeedsSearch
                  .firstWhere((element) => element.itemId == itemId)
                  .supCategoryTitle,
              itemName: HomeCubit.get(context)
                  .listFeedsSearch
                  .firstWhere((element) => element.itemId == itemId)
                  .itemTitle,
              itemDescription: HomeCubit.get(context)
                      .listFeedsSearch
                      .firstWhere((element) => element.itemId == itemId)
                      .description ??
                  '',
              itemPrice: HomeCubit.get(context)
                  .listFeedsSearch
                  .firstWhere((element) => element.itemId == itemId)
                  .price,
            ));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 15, left: 0, top: 25, bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(blurRadius: 10, color: Constants.lighterGray)
          ],
          color: Constants.white,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topRight,
          //   crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25, left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Constants.primary,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            // width: MediaQuery.of(context).size.width / 2.2,
                            height: 33,
                            child: PrimaryText(
                                text: name,
                                size: 22,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {


                            HomeCubit.get(context).addNewItemToCartFromFeedsScreen(orderCount: value,itemId:itemId );


                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 45, vertical: 20),
                            decoration: const BoxDecoration(
                                color: Constants.primary,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                )),
                            child: const Icon(Icons.add, size: 20),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Row(
                          children: [


                            if(HomeCubit.get(context).listFeedsSearch.firstWhere((element) => element.itemId == itemId).isDiscount)
                              PrimaryText(
                                isDiscount: true,
                                text: HomeCubit.get(context).listFeedsSearch.firstWhere((element) => element.itemId == itemId).oldPrice.toString(),
                                size: 20,
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
                              size: 20,
                              fontWeight: FontWeight.w700,
                              color: Constants.tertiary,
                              height: 1,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (value != 0) {
                                      value = value - 1;
                                    }
                                  });
                                },
                                child: const CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.blueAccent,
                                  child: Text(
                                    '-',
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(value.toString() ?? '1'),
                              const SizedBox(width: 10),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (value != 50) {
                                      value = value + 1;
                                    }
                                  });
                                },
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor:
                                      Colors.blueAccent.withOpacity(0.9),
                                  child: const Text(
                                    '+',
                                    style: TextStyle(
                                        fontSize: 22, color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Container(
              height: 100,
              width: 100,
              transform: Matrix4.translationValues(
                15.0,
                -20.0,
                0.0,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey[300],
                        blurRadius: 20,
                        spreadRadius: 5)
                  ]),
              child: Hero(
                tag: imagePath,
                child: Image.network(imagePath,
                    width: MediaQuery.of(context).size.width / 2.9),
              ),
            ),
          ],
        ),
      ),
    );
  });
}
