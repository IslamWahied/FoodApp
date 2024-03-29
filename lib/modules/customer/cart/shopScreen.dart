//@dart=2.9
import 'package:backdrop/backdrop.dart';
import 'package:elomda/bloc/home_bloc/HomeCubit.dart';
import 'package:elomda/bloc/home_bloc/HomeState.dart';
import 'package:elomda/modules/admin/Order/Admin/canceledOrder.dart';
import 'package:elomda/modules/customer/Userbacklayer.dart';
import 'package:elomda/shared/Global.dart';
import 'package:elomda/shared/components/Componant.dart';
import 'package:elomda/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';

import 'orderDetail.dart';

class ShopScreen extends StatelessWidget {
  final bool isShowNavBar;

  const ShopScreen({this.isShowNavBar, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          // var newOrderList = cubit.listAllOrders
          //     .where((element) =>
          //         element.orderState.toLowerCase() != 'New'.toLowerCase() &&
          //         element.userMobile == Global.mobile)
          //     .toList();

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
                            IconButton(
                                onPressed: () {
                                  // navigateTo(context, User_Info());
                                },
                                padding: const EdgeInsets.all(10),
                                icon: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.white,
                                  child: Global.imageUrl != null &&
                                          Global.imageUrl.trim() != ''
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
              bottomSheet: BottomSheet(
                onClosing: () {},
                enableDrag: false,
                builder: (context) {
                  return cubit.tabController == null || cubit.tabController.index == 0
                      ? Padding(
                          padding:   EdgeInsets.only(bottom:MediaQuery.of(context).size.width * 0.15),
                          child: ElevatedButton(

                            onPressed: () {
                              cubit.sendOrder(context);
                            },
                            child: Row(
                              // mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/dollar.svg',
                                        color: Constants.tertiary,
                                        width: 15,
                                      ),
                                      PrimaryText(
                                        text: cubit.getTotalPrice() ?? '0',
                                        size: 30,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.deepOrange[500],
                                        height: 1,
                                      ),
                                    ],
                                  ),
                                ),

                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: const [

                                        PrimaryText(
                                          text: 'تاكيد الطلب',
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                          size: 21,
                                        ),

                                        // Icon(
                                        //   Icons.chevron_right,
                                        //   color: Constants.white,
                                        // ),
                                      ],
                                    ),
                                  ),
                                )

                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: cubit.getTotalPrice() == '0' ||
                                        cubit.getTotalPrice() == null ||
                                        cubit.listOrder.isEmpty
                                    ? Colors.grey[200]
                                    : Constants.primary,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(10.0)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 20),
                                textStyle: const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold)),
                          ),
                        )
                      : const SizedBox();
                },
              ),
              frontLayer:    Padding(
                padding: const EdgeInsets.only(bottom: 100, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: cubit.listOrder.isEmpty
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
                  children: [
                    Visibility(
                        visible: cubit.listOrder.isNotEmpty &&
                            cubit.listOrder != [],
                        replacement: const Center(
                          child: Text(
                            'لايوجد طلبات مضافة',
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.red,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        child: Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: cubit.listOrder.length ?? 0,
                              itemBuilder: (context, index) => itemCard(
                                  itemId: cubit.listOrder[index].itemId,
                                  isFavourite: cubit
                                      .listFavourite.isNotEmpty &&
                                      cubit.listFavourite.any((element) =>
                                      element.ItemId ==
                                          cubit.listOrder[index]
                                              .itemId &&
                                          element.isFavourit)
                                      ? true
                                      : false,
                                  itemPrice: cubit.listOrder[index].price,
                                  index: index,
                                  subCategoryTitle: cubit
                                      .listOrder[index].supCategoryTitle,
                                  name: cubit.listOrder[index].itemTitle,
                                  context: context,
                                  imagePath: cubit.listOrder[index].image,
                                  itemsPrice:
                                  cubit.listOrder[index].price,
                                  star: '',
                                  itemDescription: cubit
                                      .listOrder[index].description ??
                                      ''),
                            ),
                          ),
                        )),

                  ],
                ),
              ));
        });
  }
}

Widget itemCard(
    {int itemId,
    int index,
    bool isFavourite,
    String imagePath,
    String subCategoryTitle,
    double itemPrice,
    String name,
    String itemDescription,
    String star,
    context,
    double itemsPrice}) {
  int value = HomeCubit.get(context).listOrder[index].orderCount ?? 1;
  return StatefulBuilder(builder: (context, setState) {
    return Slidable(
      closeOnScroll: false,

      key: const ValueKey(0),

      // The start action pane is the one at the left or the top side.
      startActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),

        dismissible: DismissiblePane(onDismissed: () {}),

        // All actions are defined in the children parameter.
        children: [
          SlidableAction(
            autoClose: true,
            onPressed: (context) {},
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'حذف',
          ),
        ],
      ),

      // The end action pane is the one at the right or the bottom side.
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SizedBox(
            height: 150,
            width: 80,
            child: SlidableAction(
              // An action can be bigger than the others.
              flex: 1,
              onPressed: (context) {
                HomeCubit.get(context).listOrder.removeWhere(
                    (item) => item == HomeCubit.get(context).listOrder[index]);
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.archive,
              label: 'حذف',
            ),
          ),
        ],
      ),

      // component is not dragged.
      child: GestureDetector(
        onTap: () {
          var cubit = HomeCubit.get(context);
          cubit.selectedItemId = itemId;
          cubit.selectedCategoryId = cubit.listOrder[index].categoryId;
          cubit.selectedSubCategoryId = cubit.listOrder[index].supCategoryId;

          navigateTo(
              context,
              OrderDetailScreen(
                orderCount: cubit.listOrder[index].orderCount,
                additionsList: cubit.listOrder[index].additionsList ?? [],
                isDiscount: cubit.listOrder[index].isDiscount,
                oldPrice: cubit.listOrder[index].oldPrice,
                imagePath: cubit.listOrder[index].image,
                subCategoryTitle: cubit.listOrder[index].supCategoryTitle,
                itemName: cubit.listOrder[index].itemTitle,
                itemDescription: cubit.listOrder[index].description ?? '',
                index: index,
                itemPrice: cubit.listOrder[index].price,
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
            alignment: Alignment.centerRight,
            //   crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [

                            GestureDetector(
                                onTap: () {
                                  HomeCubit.get(context)
                                      .changeItemFavouriteState(
                                          itemModel: HomeCubit.get(context)
                                              .listOrder[index],
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 45, vertical: 20),
                        decoration:   BoxDecoration(
                            color: Constants.primary,
                            borderRadius: const BorderRadius.only(
                              bottomLeft:Radius.circular(20),
                              topRight:Radius.circular(20),
                            )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [

                            SvgPicture.asset(
                              'assets/dollar.svg',
                              color: Constants.tertiary,
                              width: 15,
                            ),
                            Row(
                              children: [
                                PrimaryText(
                                  text: HomeCubit.get(context)
                                          .getTotalPriceForItem(index: index) ??
                                      '0',
                                  size: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Constants.tertiary,
                                  height: 1,
                                ),
                              ],
                            ),
                          ],
                        ),


                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (value != 1) {
                                    value = value - 1;
                                    HomeCubit.get(context)
                                        .listOrder[index]
                                        .orderCount = value;
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
                                    HomeCubit.get(context)
                                        .listOrder[index]
                                        .orderCount = value;
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
              Positioned(
                top: -30,
                right: 10,
                child: Container(
                  height: 100,
                  width: 100,
                  transform: Matrix4.translationValues(
                    20.0,
                    0.0,
                    0.0,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[300],
                            blurRadius: 20,
                            spreadRadius: 2)
                      ]),
                  child: Hero(

                    tag: imagePath + index.toString(),
                    child: CircleAvatar(backgroundImage: NetworkImage(imagePath ?? '')),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  });
}


