// @dart=2.9

import 'package:backdrop/backdrop.dart';
import 'package:elomda/bloc/home_bloc/HomeCubit.dart';
import 'package:elomda/bloc/home_bloc/HomeState.dart';
import 'package:elomda/models/category/itemModel.dart';
import 'package:elomda/modules/admin/adminBackLayer.dart';
import 'package:elomda/modules/user_info/user_info_screen.dart';
import 'package:elomda/shared/Global.dart';
import 'package:elomda/shared/components/Componant.dart';
import 'package:elomda/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class DoneOrderScreen extends StatelessWidget {
  const DoneOrderScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeScreenState>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        var newOrderList = cubit.listAllOrders
            .where((element) =>
                element.orderState.toLowerCase() == 'Done'.toLowerCase() &&
                element.projectId == Global.projectId)
            .toList();
        return Scaffold(
          body: Center(
            child: BackdropScaffold(
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
                actions: [
                  cubit.isShowBackLayer
                      ? IconButton(
                          onPressed: () {
                            navigateTo(
                              context,
                              const UserInformationScreen(),
                            );
                          },
                          padding: const EdgeInsets.all(10),
                          icon: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.white,
                            child: Global.imageUrl != null &&
                                    Global.imageUrl.trim() != ''
                                ? SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: FadeInImage(
                                        height: 50,
                                        width: 50,
                                        fadeInDuration:
                                            const Duration(milliseconds: 500),
                                        fadeInCurve: Curves.easeInExpo,
                                        fadeOutCurve: Curves.easeOutExpo,
                                        placeholder: const AssetImage(
                                            "assets/person.jpg"),
                                        image: NetworkImage(Global.imageUrl),
                                        imageErrorBuilder:
                                            (context, error, stackTrace) {
                                          return const CircleAvatar(
                                            radius: 13,
                                            backgroundImage:
                                                AssetImage('assets/person.jpg'),
                                          );
                                        },
                                        fit: BoxFit.cover),
                                  )
                                : const CircleAvatar(
                                    radius: 13,
                                    backgroundImage:
                                        AssetImage('assets/person.jpg'),
                                  ),
                          ))
                      : const SizedBox(
                          width: 1,
                        )
                ],
              ),
              backLayer: AdminBackLayerMenu(),
              frontLayer: Conditional.single(
                context: context,
                conditionBuilder: (BuildContext context) => cubit.listAllOrders
                    .where((element) =>
                        element.orderState.toLowerCase() ==
                            'New'.toLowerCase() &&
                        element.projectId == Global.projectId)
                    .toList()
                    .isNotEmpty,
                widgetBuilder: (BuildContext context) {
                  return ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(),
                    itemCount: newOrderList.length,
                    itemBuilder: (context, index) {
                      var orderModel = newOrderList[index];

                      // print(orderModel.toJson());
                      return StatefulBuilder(builder: (context, setState) {
                        return Slidable(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: double.infinity,
                              height: 200,
                              child: Card(
                                elevation: 2,
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(orderModel.userName ?? ''),
                                              Baseline(
                                                  baseline: 25.0,
                                                  baselineType:
                                                      TextBaseline.alphabetic,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 3),
                                                    child: Text(
                                                        orderModel.departMent ??
                                                            '',
                                                        style: const TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          //    fontFamily: 'Raleway'
                                                          // fontFamily: 'Elshan'
                                                          // fontFamily: 'Elshan'
                                                        )),
                                                  )),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 80,
                                            height: 30,
                                            child: Card(
                                              color: Colors.green,
                                              child: Center(
                                                  child: Text(
                                                orderModel.orderState ?? '',
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              )),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Divider(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: const [
                                              Text(
                                                'OrderCount : ',
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontSize: 17),
                                              ),
                                              Text(
                                                '20',
                                                style: TextStyle(fontSize: 17),
                                              )
                                            ],
                                          ),
                                          Text(
                                            cubit.convertDateFormat(
                                                    orderModel.createdDate) ??
                                                '',
                                            style: TextStyle(
                                                fontSize: 13.5,
                                                color: Colors.grey[600]),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      const Spacer(),
                                      const Divider(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              const Text(
                                                'Total : ',
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontSize: 17),
                                              ),
                                              Text(
                                                orderModel.orderPrice
                                                        .toString() ??
                                                    '0',
                                                style: const TextStyle(
                                                    fontSize: 17),
                                              ),
                                            ],
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                showDialog(
                                                    useSafeArea: true,
                                                    context: context,
                                                    builder:
                                                        (context) =>
                                                            AlertDialog(
                                                              content:
                                                                  SingleChildScrollView(
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: const [
                                                                        Text(
                                                                          'Order Detail',
                                                                          style: TextStyle(
                                                                              color: Colors.blue,
                                                                              fontSize: 16),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    SizedBox(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.7,
                                                                      height:
                                                                          200,
                                                                      child: ListView.separated(
                                                                          itemBuilder: (context, index) => orderModelCard(
                                                                              orderModel.listItemModel[
                                                                                  index],
                                                                              context),
                                                                          separatorBuilder: (context, index) => const SizedBox(
                                                                              height:
                                                                                  10),
                                                                          itemCount: orderModel
                                                                              .listItemModel
                                                                              .length),
                                                                    ),
                                                                    const Divider(),
                                                                    TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child:
                                                                            const Text(
                                                                          'الغاء',
                                                                          style:
                                                                              TextStyle(color: Colors.red),
                                                                        ))
                                                                  ],
                                                                ),
                                                              ),
                                                            ));
                                              },
                                              child: const Text('Details'))
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                    },
                  );
                },
                fallbackBuilder: (BuildContext context) => const Center(
                    child: Text(
                  'لا يوجد طلبات',
                  style: TextStyle(color: Colors.red, fontSize: 18),
                )),
              ),
            ),
          ),
        );
      },
      listener: (context, state) => {},
    );
  }
}

Widget orderModelCard(ItemModel model, context) => Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(model.orderCount.toString()),
                const Text('X'),
                Text(model.itemTitle.toString()),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            if (model.additionsList.isNotEmpty)
              const Text(
                ': الاضافات',
                style: TextStyle(color: Colors.blue),
              ),
            if (model.additionsList.isNotEmpty)
              SizedBox(
                height: 30,
                width: MediaQuery.of(context).size.width * 0.5,
                child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Text(
                        model.additionsList[index].itemTitle ?? '',
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        index + 1 < model.additionsList.length
                            ? const Text(
                                '  -  ',
                                style: TextStyle(color: Colors.black),
                              )
                            : const SizedBox(width: 5),
                    itemCount: model.additionsList.length),
              )
          ],
        ),
      ),
    );
