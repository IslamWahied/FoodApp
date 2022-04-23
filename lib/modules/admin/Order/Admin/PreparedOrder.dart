// @dart=2.9
import 'package:elomda/bloc/home_bloc/HomeCubit.dart';
import 'package:elomda/bloc/home_bloc/HomeState.dart';
import 'package:elomda/modules/admin/adminBackLayer.dart';
import 'package:elomda/shared/Global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'newOrders.dart';

class PreparedOrderScreen extends StatelessWidget {
  const PreparedOrderScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        var newOrderList = cubit.listAllOrders
            .where((element) =>
                element.orderState.toLowerCase() == 'Prepared'.toLowerCase() &&
                element.projectId == Global.projectId)
            .toList();

        return Scaffold(
          body: Center(
            child: backdrop(
              context: context,
              newOrderList: newOrderList,
              backLayer: Conditional.single(
                context: context,
                conditionBuilder: (BuildContext context) => cubit.listAllOrders
                    .where((element) =>
                        element.orderState.toLowerCase() ==
                            'Prepared'.toLowerCase() &&
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
                          closeOnScroll: false,

                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SizedBox(
                                height: 185,
                                width: 95,
                                child: SlidableAction(
                                  // An action can be bigger than the others.
                                  flex: 1,
                                  onPressed: (context) {
                                    cubit.listAllOrders
                                        .firstWhere((element) =>
                                            element.orderId ==
                                                orderModel.orderId &&
                                            element.projectId ==
                                                Global.projectId)
                                        .orderState = 'Done';
                                    var x = cubit.listAllOrders.firstWhere(
                                        (element) =>
                                            element.orderId ==
                                                orderModel.orderId &&
                                            element.projectId ==
                                                Global.projectId);
                                    cubit.updateOrderState(orderModel: x);
                                  },
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                  icon: Icons.check,
                                  label: 'تم التسليم',
                                ),
                              ),
                              const SizedBox(width: 5),
                              SizedBox(
                                height: 185,
                                width: 91,
                                child: SlidableAction(
                                  // An action can be bigger than the others.
                                  flex: 1,
                                  onPressed: (context) {
                                    cubit.listAllOrders
                                        .firstWhere((element) =>
                                            element.orderId ==
                                                orderModel.orderId &&
                                            element.projectId ==
                                                Global.projectId)
                                        .orderState = 'Canceled';
                                    var x = cubit.listAllOrders.firstWhere(
                                        (element) =>
                                            element.orderId ==
                                                orderModel.orderId &&
                                            element.projectId ==
                                                Global.projectId);
                                    cubit.updateOrderState(orderModel: x);
                                  },
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  icon: Icons.archive,
                                  label: 'الغاء',
                                ),
                              ),
                            ],
                          ),

                          // component is not dragged.
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
                                          const SizedBox(
                                            width: 80,
                                            height: 30,
                                            child: Card(
                                              color: Colors.orange,
                                              child: Center(
                                                  child: Text(
                                                'تحت التجهيز' ?? '',
                                                style: TextStyle(
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
                                                'الاجمالي : ',
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
                                                if (cubit.listUser
                                                    .firstWhere((element) =>
                                                        element.mobile ==
                                                        Global.mobile)
                                                    .isActive) {
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
                                                                            CrossAxisAlignment.start,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: const [
                                                                          Text(
                                                                            'تفاصيل الطلب',
                                                                            style:
                                                                                TextStyle(color: Colors.blue, fontSize: 16),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      SizedBox(
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.7,
                                                                        height:
                                                                            200,
                                                                        child: ListView.separated(
                                                                            itemBuilder: (context, index) =>
                                                                                orderModelCard(orderModel.listItemModel[index], context),
                                                                            separatorBuilder: (context, index) => const SizedBox(height: 10),
                                                                            itemCount: orderModel.listItemModel.length),
                                                                      ),
                                                                      const Divider(),
                                                                      TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              const Text(
                                                                            'اغلاق',
                                                                            style:
                                                                                TextStyle(color: Colors.red),
                                                                          ))
                                                                    ],
                                                                  ),
                                                                ),
                                                              ));
                                                } else {
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                      const SnackBar(
                                                          backgroundColor:
                                                              Colors.red,
                                                          content: Text(
                                                            'لم يتم تفعيل الحساب برجاء الاتصال بالدعم الفني لاتمام عملية التسجيل',
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          30))),
                                                          behavior:
                                                              SnackBarBehavior
                                                                  .floating,
                                                          padding:
                                                              EdgeInsets.all(
                                                                  20.0),
                                                          duration: Duration(
                                                              milliseconds:
                                                                  4000)));
                                                }
                                              },
                                              child: const Text('التفاصيل'))
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
