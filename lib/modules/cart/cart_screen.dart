//@dart=2.9
import 'package:elomda/bloc/home_bloc/HomeCubit.dart';
import 'package:elomda/bloc/home_bloc/HomeState.dart';
import 'package:elomda/modules/product_details/foodDetail.dart';

import 'package:elomda/shared/components/Componant.dart';
import 'package:elomda/styles/colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';

import 'orderDetail.dart';

class OrderScreen extends StatelessWidget {
  final bool isShowNavBar;

  const OrderScreen({this.isShowNavBar, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeScreenState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return SafeArea(
            child: Scaffold(
              appBar: isShowNavBar != false
                  ? AppBar(
                      elevation: 0,
                      automaticallyImplyLeading: false,
                      backgroundColor: Colors.transparent,
                      centerTitle: false,
                      leadingWidth: 0,
                      iconTheme: const IconThemeData(color: Constants.black),
                      title: customAppBar(context: context, title: ''),
                    )
                  : AppBar(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                    ),
              bottomSheet: Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: checkoutSection(context, 0.0),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              backgroundColor: Constants.white,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: cubit.listOrder.isEmpty
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                children: [
                  Visibility(
                      visible:
                          cubit.listOrder.isNotEmpty && cubit.listOrder != [],
                      replacement: const Center(
                        child: Text(
                          'لايوجد طلبات مضافة',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500),
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
                                isFavourite: cubit.listFavourite.isNotEmpty &&
                                        cubit.listFavourite.any((element) =>
                                            element.ItemId ==
                                                cubit.listOrder[index].itemId &&
                                            element.isFavourit)
                                    ? true
                                    : false,
                                itemPrice: cubit.listOrder[index].price,
                                index: index,
                                subCategoryTitle:
                                    cubit.listOrder[index].supCategoryTitle,
                                name: cubit.listOrder[index].itemTitle,
                                context: context,
                                imagePath: cubit.listOrder[index].image,
                                itemsPrice: cubit.listOrder[index].price,
                                star: '',
                                itemDescription:
                                    cubit.listOrder[index].description ?? ''),
                          ),
                        ),
                      )),
                ],
              ),
            ),
          );
        });
  }
}

Widget checkoutSection(context, double total) {
  return Container(
    decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey, width: 0.5))),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const SizedBox(width: 5,),

          Text(
            'US \$${total.toStringAsFixed(3)}',
            //${HomeLayoutCubit.get(context).totalAmount},
            //textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.blue, fontSize: 20, fontWeight: FontWeight.w500),
          ),

          const Text(
            ' :الاجمالي ',
            style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
       const SizedBox(width: 20,),
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.deepOrange
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    HomeCubit.get(context).sendOrder();
                  },
                  borderRadius: BorderRadius.circular(30),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'تاكيد الطلب',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
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
            label: 'Delete',
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
              label: 'Delete',
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
                            // const Icon(
                            //   Icons.star,
                            //   color: Constants.primary,
                            //   size: 20,
                            // ),
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
                        decoration: const BoxDecoration(
                            color: Constants.primary,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // if (HomeCubit.get(context).listOrder[index].isDiscount)
                            //   PrimaryText(
                            //     isDiscount: true,
                            //     text: HomeCubit.get(context)
                            //         .listOrder[index]
                            //         .oldPrice
                            //         .toString(),
                            //     size: 20,
                            //     fontWeight: FontWeight.w700,
                            //     color: Constants.lighterGray,
                            //     height: 1,
                            //   ),
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
                                      0,
                                  size: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Constants.tertiary,
                                  height: 1,
                                ),
                              ],
                            ),
                          ],
                        ),

                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   children:  [
                        //     Text(
                        //       HomeCubit.get(context).listOrder[index].orderCount.toString()??'1',style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w400,),),
                        //     const Text(' : العدد',style: TextStyle(  fontWeight: FontWeight.w700,
                        //       color: Constants.tertiary, ),),
                        //
                        //   ],
                        // ),
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
                    // key: GlobalKey(debugLabel: index.toString()),
                    tag: imagePath + index.toString(),
                    child: Image.network(imagePath ?? '',
                        width: MediaQuery.of(context).size.width / 2.9),
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
