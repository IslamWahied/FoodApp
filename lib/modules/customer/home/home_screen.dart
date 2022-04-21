// @dart=2.9
import 'package:backdrop/backdrop.dart';
import 'package:badges/badges.dart';
import 'package:elomda/bloc/home_bloc/HomeCubit.dart';
import 'package:elomda/bloc/home_bloc/HomeState.dart';
import 'package:elomda/home_layout/home_layout.dart';
import 'package:elomda/modules/customer/Userbacklayer.dart';
import 'package:elomda/modules/customer/popularFood/popularFoodDetailScreen.dart';
import 'package:elomda/shared/Global.dart';
import 'package:elomda/shared/components/Componant.dart';
import 'package:elomda/shared/network/local/helper.dart';
import 'package:elomda/styles/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeScreenState>(
      listener: (context, state) => () {},
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
          headerHeight: MediaQuery.of(context).size.height * 0.35,
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
            actions: <Widget>[
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
                              cubit.isShowBackLayer = false;
                              NavigatToAndReplace(context, const HomeLayout());
                              cubit.changeCurrentIndex(4);
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
          frontLayer: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                    const PrimaryText(
                      text: 'رجوع',
                      size: 22,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // const Padding(
                    //   padding: EdgeInsets.only(left: 20),
                    //   child: PrimaryText(
                    //     text: 'Food',
                    //     size: 22,
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: PrimaryText(
                        text: cubit.listProject
                                .firstWhere(
                                    (element) => element.id == Global.projectId)
                                .name ??
                            '',
                        height: 1.1,
                        size: 42,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: PrimaryText(
                              text: 'التصنيفات',
                              fontWeight: FontWeight.w700,
                              size: 22),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 240,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: cubit.listCategory
                                .where((element) =>
                                    element.projectId == Global.projectId)
                                .length ??
                            0,
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.only(left: index == 0 ? 25 : 0),
                          child: foodCategoryCard(
                              cubit.listCategory
                                  .where((element) =>
                                      element.projectId == Global.projectId)
                                  .toList()[index]
                                  .image,
                              cubit.listCategory
                                  .where((element) =>
                                      element.projectId == Global.projectId)
                                  .toList()[index]
                                  .categoryTitle,
                              cubit.listCategory
                                  .where((element) =>
                                      element.projectId == Global.projectId)
                                  .toList()[index]
                                  .categoryId,
                              context),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(right: 20, top: 10),
                          child: PrimaryText(
                              text: 'الاكثر طالبا',
                              fontWeight: FontWeight.w700,
                              size: 22),
                        ),
                      ],
                    ),
                    Column(
                      children: List.generate(
                        cubit.popularList
                            .where((element) =>
                                element.projectId == Global.projectId)
                            .toList()
                            .length,
                        (index) => itemCard(
                          index: index,
                          isFavourite: cubit.listFavourite.isNotEmpty &&
                                  cubit.listFavourite.any((element) =>
                                      element.ItemId ==
                                          cubit.popularList
                                              .where((element) =>
                                                  element.projectId ==
                                                  Global.projectId)
                                              .toList()[index]
                                              .itemId &&
                                      element.isFavourit)
                              ? true
                              : false,
                          // itemId: cubit.popularFoodList
                          //     .where((element) =>
                          //         element.projectId == Global.projectId)
                          //     .toList()[index]
                          //     .itemId,
                          context: context,
                          imagePath: cubit.popularList
                              .where((element) =>
                                  element.projectId == Global.projectId)
                              .toList()[index]
                              .image,
                          itemDescription: cubit.popularList
                              .where((element) =>
                                  element.projectId == Global.projectId)
                              .toList()[index]
                              .description,
                          itemPrice: cubit.popularList
                              .where((element) =>
                                  element.projectId == Global.projectId)
                              .toList()[index]
                              .price,
                          name: cubit.popularList
                              .where((element) =>
                                  element.projectId == Global.projectId)
                              .toList()[index]
                              .itemTitle,
                          star: '5',
                          subCategoryTitle: cubit.popularList
                              .where((element) =>
                                  element.projectId == Global.projectId)
                              .toList()[index]
                              .supCategoryTitle,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 150,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget foodCategoryCard(
      String imagePath, String name, int categoryId, context) {
    return BlocConsumer<HomeCubit, HomeScreenState>(
      listener: (context, state) => {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return GestureDetector(
          onTap: () {
            cubit.selectCategory(categoryId, context);
          },
          child: Container(
            margin: const EdgeInsets.only(right: 20, top: 20, bottom: 20),
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: HomeCubit.get(context).selectedCategoryId == categoryId
                    ? Constants.primary
                    : Constants.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 15,
                  )
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // SvgPicture.asset(imagePath, width: 40),
                Image.network(imagePath, width: 90, height: 70),
                PrimaryText(text: name, fontWeight: FontWeight.w800, size: 16),
                RawMaterialButton(
                    onPressed: null,
                    fillColor: cubit.selectedCategoryId == categoryId
                        ? Constants.white
                        : Constants.tertiary,
                    shape: const CircleBorder(),
                    child: Icon(Icons.chevron_right_rounded,
                        size: 20,
                        color: HomeCubit.get(context).selectedCategoryId ==
                                categoryId
                            ? Constants.black
                            : Constants.white))
              ],
            ),
          ),
        );
      },
    );
  }

  Widget itemCard(
      {String imagePath,
      String subCategoryTitle,
      double itemPrice,
      String name,
      int index,
      String itemDescription,
      String star,
      context,
      isFavourite}) {
    int value = 1;
    return BlocConsumer<HomeCubit, HomeScreenState>(
      listener: (context, state) => {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        var model = cubit.popularList
            .where((element) => element.projectId == Global.projectId)
            .toList()[index];
        return StatefulBuilder(builder: (context, setState) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {
                cubit.selectedItemId = model.itemId;
                cubit.selectedCategoryId = model.categoryId;
                cubit.selectedSubCategoryId = model.supCategoryId;

                if (kDebugMode) {
                  print('itemId');
                }
                if (kDebugMode) {
                  print(model.itemId);
                }
                if (kDebugMode) {
                  print('itemId');
                }

                navigateTo(
                    context,
                    PopularFoodDetailScreen(
                      index: index,
                      orderCount: value ?? 1,
                      oldPrice: model.oldPrice,
                      isDiscount: model.isDiscount,
                      imagePath: model.image,
                      subCategoryTitle: model.supCategoryTitle,
                      itemName: model.itemTitle,
                      itemDescription: model.description ?? '',
                      itemPrice: model.price,
                      itemId: model.itemId,
                    ));
              },
              child: Container(
                margin: const EdgeInsets.only(
                    right: 15, left: 0, top: 25, bottom: 10),
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
                                  const Icon(
                                    Icons.star,
                                    color: Constants.primary,
                                    size: 20,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        HomeCubit.get(context)
                                            .changeItemFavouriteState(
                                                itemId: model.itemId,
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
                          children: [
                            GestureDetector(
                              onTap: () {
                                var cubit = HomeCubit.get(context);
                                cubit.addNewItemToCartFromHomeScreen(
                                    itemId: model.itemId, orderCount: value);
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
                            const SizedBox(width: 15),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      if (HomeCubit.get(context)
                                          .popularList
                                          .firstWhere((element) =>
                                              element.itemId == model.itemId &&
                                              element.projectId ==
                                                  Global.projectId)
                                          .isDiscount)
                                        PrimaryText(
                                          isDiscount: true,
                                          text: HomeCubit.get(context)
                                              .popularList
                                              .firstWhere((element) =>
                                                  element.itemId ==
                                                      model.itemId &&
                                                  element.projectId ==
                                                      Global.projectId &&
                                                  element.isDiscount)
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
                                  // const SizedBox(
                                  //   width: 30,
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
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
                                                  fontSize: 25,
                                                  color: Colors.white),
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
                                            backgroundColor: Colors.blueAccent
                                                .withOpacity(0.9),
                                            child: const Text(
                                              '+',
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
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
            ),
          );
        });
      },
    );
  }
}
