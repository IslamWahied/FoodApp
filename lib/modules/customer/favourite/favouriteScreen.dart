//@dart=2.9
import 'package:backdrop/backdrop.dart';
import 'package:badges/badges.dart';
import 'package:elomda/bloc/home_bloc/HomeCubit.dart';
import 'package:elomda/bloc/home_bloc/HomeState.dart';
import 'package:elomda/home_layout/home_layout.dart';
import 'package:elomda/modules/customer/Userbacklayer.dart';
import 'package:elomda/shared/Global.dart';
import 'package:elomda/shared/components/Componant.dart';
import 'package:elomda/shared/network/local/helper.dart';
import 'package:elomda/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'favouriteScreenDetail.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeScreenState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return BackdropScaffold(
            onBackLayerConcealed: () {
              cubit.isShowBackLayer = true;

              cubit.emit(SelectCategoryState());
            },
            onBackLayerRevealed: () {
              cubit.isShowBackLayer = false;
              cubit.emit(SelectCategoryState());
            },
            frontLayerBackgroundColor: Constants.white,
            headerHeight: MediaQuery.of(context).size.height * 0.45,
            appBar: BackdropAppBar(
              title: Text(cubit.selectedTab),
              leading: const BackdropToggleButton(
                icon: AnimatedIcons.home_menu,
                color: Colors.deepOrange,
              ),
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                ),
              ),
              actions: [
                cubit.isShowBackLayer
                    ? Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              cubit.isShowBackLayer = false;
                              NavigatToAndReplace(context, const HomeLayout());
                              cubit.changeCurrentIndex(3);
                            },
                            child: Badge(
                                badgeContent: Text(
                                  cubit.listOrder.length.toString() ?? '0',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 11),
                                ),
                                child: Image.asset(
                                  'assets/shoppingcart.png',
                                  width: 22,
                                  color: Colors.white,
                                )),
                          ),
                          const SizedBox(width: 20),
                          IconButton(
                              onPressed: () {
                                // navigateTo(context, User_Info());
                              },
                              padding: const EdgeInsets.all(10),
                              icon: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.white,
                                child: Global.imageUrl != null
                                    ? CircleAvatar(
                                        radius: 30.0,
                                        backgroundImage:
                                            NetworkImage(Global.imageUrl),
                                        backgroundColor: Colors.transparent,
                                      )
                                    : const CircleAvatar(
                                        radius: 13,
                                        backgroundImage:
                                            AssetImage('assets/person.jpg'),
                                      ),
                              )),
                        ],
                      )
                    : const SizedBox(
                        width: 1,
                      )
              ],
            ),
            backLayer: UserBackLayerMenu(),
            frontLayer: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     const SizedBox(width: 20),
                //     const Icon(
                //       Icons.search,
                //       color: AppColors.secondary,
                //       size: 25,
                //     ),
                //     const SizedBox(width: 10),
                //     Expanded(
                //         child: TextField(
                //       controller: cubit.txtFavouriteControl,
                //       onChanged: (String value) {
                //         cubit.searchInFavourite(value);
                //       },
                //       decoration: const InputDecoration(
                //         enabledBorder: UnderlineInputBorder(
                //             borderSide: BorderSide(
                //                 width: 2, color: AppColors.lighterGray)),
                //         hintText: 'Search..',
                //         hintStyle: TextStyle(
                //             color: AppColors.lightGray,
                //             fontSize: 20,
                //             fontWeight: FontWeight.w500),
                //       ),
                //     )),
                //     const SizedBox(width: 20),
                //   ],
                // ),
                Visibility(
                  visible: cubit.listFavourite
                      .where((element) => element.UesrMobile == Global.mobile)
                      .toList()
                      .isNotEmpty,
                  replacement: const Expanded(
                      child: Center(child: Text('لايوجد بيانات'))),
                  child: Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: cubit.listFavourite
                                  .where((element) =>
                                      element.isFavourit &&
                                      element.UesrMobile == Global.mobile)
                                  .toList()
                                  .isNotEmpty
                              ? cubit.listFavourite
                                  .where((element) =>
                                      element.isFavourit &&
                                      element.UesrMobile == Global.mobile)
                                  .toList()
                                  .length
                              : 0,
                          itemBuilder: (context, index) {
                            var favModel = cubit.listFavourite
                                .where((element) => element.isFavourit)
                                .toList()[index];
                            var itemModel = cubit.listItems.firstWhere(
                                (element) => element.itemId == favModel.ItemId);

                            return itemCard(
                                isFavourite: favModel.isFavourit,
                                itemId: favModel.ItemId,
                                itemPrice: itemModel.price ?? 0,
                                subCategoryTitle:
                                    itemModel.supCategoryTitle ?? '',
                                name: itemModel.itemTitle ?? '',
                                projectId: favModel.projectId,
                                context: context,
                                imagePath: itemModel.image ?? '',
                                itemsPrice: itemModel.price ?? 0,
                                star: '',
                                itemDescription: itemModel.description ?? '');
                          }),
                    ),
                  ),
                ),
              ],
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
    int projectId,
    String itemDescription,
    String star,
    bool isFavourite,
    context,
    double itemsPrice}) {
  int value = 1;
  return BlocConsumer<HomeCubit, HomeScreenState>(
    builder: (context, state) {
      var cubit = HomeCubit.get(context);
      return StatefulBuilder(builder: (context, setState) {
        return GestureDetector(
          onTap: () {
            cubit.selectedItemId = itemId;
            cubit.selectedCategoryId = cubit.listItems
                .firstWhere((element) =>
                    element.itemId ==
                    cubit.listFavourite
                        .firstWhere((element) =>
                            element.ItemId == itemId &&
                            element.projectId == projectId)
                        .ItemId)
                .categoryId;
            cubit.selectedSubCategoryId = cubit.listItems
                .firstWhere((element) =>
                    element.itemId ==
                    cubit.listFavourite
                        .firstWhere((element) =>
                            element.ItemId == itemId &&
                            element.projectId == projectId)
                        .ItemId)
                .supCategoryId;

            navigateTo(
                context,
                FavouriteScreenDetail(
                  isDiscount: cubit.listItems
                          .firstWhere((element) =>
                              element.itemId == itemId &&
                              element.projectId == projectId)
                          .isDiscount ??
                      false,
                  itemId: cubit.listItems
                      .firstWhere((element) =>
                          element.itemId == itemId &&
                          element.projectId == projectId)
                      .itemId,
                  imagePath: cubit.listItems
                      .firstWhere((element) =>
                          element.itemId == itemId &&
                          element.projectId == projectId)
                      .image,
                  subCategoryTitle: cubit.listItems
                      .firstWhere((element) =>
                          element.itemId == itemId &&
                          element.projectId == projectId)
                      .supCategoryTitle,
                  itemName: cubit.listItems
                      .firstWhere((element) =>
                          element.itemId == itemId &&
                          element.projectId == projectId)
                      .itemTitle,
                  itemDescription: cubit.listItems
                          .firstWhere((element) =>
                              element.itemId == itemId &&
                              element.projectId == projectId)
                          .description ??
                      '',
                  itemPrice: cubit.listItems
                      .firstWhere((element) =>
                          element.itemId == itemId &&
                          element.projectId == projectId)
                      .price,
                  oldPrice: cubit.listItems
                      .firstWhere((element) =>
                          element.itemId == itemId &&
                          element.projectId == projectId)
                      .oldPrice,
                  orderCount: value ?? 1,
                ));
          },
          child: Container(
            margin:
                const EdgeInsets.only(right: 15, left: 0, top: 25, bottom: 10),
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
                      padding: const EdgeInsets.only(top: 20, left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              // const Icon(
                              //   Icons.star,
                              //   color: Constants.primary,
                              //   size: 20,
                              // ),
                              // const SizedBox(width: 10),
                              GestureDetector(
                                  onTap: () {
                                    HomeCubit.get(context)
                                        .changeItemFavouriteState(
                                            itemId: itemId,
                                            isFavourite: isFavourite);
                                  },
                                  child: isFavourite
                                      ? const Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                          size: 25,
                                        )
                                      : const Icon(Icons.favorite_border,
                                          size: 25)),
                              const SizedBox(
                                width: 5,
                              ),
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
                                HomeCubit.get(context)
                                    .addNewItemToCartFromFeedsScreen(
                                        orderCount: value, itemId: itemId);
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
                                if (HomeCubit.get(context)
                                    .listItems
                                    .firstWhere((element) =>
                                        element.itemId == itemId &&
                                        element.projectId == projectId)
                                    .isDiscount)
                                  PrimaryText(
                                    isDiscount: true,
                                    text: HomeCubit.get(context)
                                        .listItems
                                        .firstWhere((element) =>
                                            element.itemId == itemId &&
                                            element.projectId == projectId)
                                        .oldPrice
                                        .toString(),
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
                                        if (value != 1) {
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
    },
    listener: (context, state) => {},
  );
}
