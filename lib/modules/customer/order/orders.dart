//@dart=2.9
import 'package:elomda/bloc/home_bloc/HomeCubit.dart';
import 'package:elomda/bloc/home_bloc/HomeState.dart';
import 'package:elomda/modules/customer/product_details/foodDetail.dart';
import 'package:elomda/shared/Global.dart';
import 'package:elomda/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';


class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) => {},
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
              title: customAppBar(
                  context: context,
                  title: '',
                  isShowCarShop: true,
                  isYellow: true),
            ),
            backgroundColor: Constants.white,
            body: SafeArea(
              bottom: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Conditional.single(
                    context: context,
                    conditionBuilder: (BuildContext context) =>
                    cubit.listAllOrders.where((element) => element.userMobile == Global.mobile && element.projectId == Global.projectId).toList().isNotEmpty,
                    widgetBuilder: (BuildContext context) {
                      return Expanded(
                        child: ListView.separated(
                          reverse: true,
                          separatorBuilder: (context, index) =>
                              const SizedBox(),
                          itemCount: cubit.listAllOrders.where((element) => element.userMobile == Global.mobile && element.projectId == Global.projectId).length,
                          itemBuilder: (context, index) {
                            var orderModel =
                            cubit.listAllOrders.where((element) => element.userMobile == Global.mobile && element.projectId == Global.projectId).toList()[index];

                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 200,
                                    child: Card(
                                      elevation: 2,
                                      color: Colors.white,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  cubit.convertDateFormat(
                                                          orderModel
                                                              .createdDate) ??
                                                      '',
                                                  style: TextStyle(
                                                      fontSize: 13.5,
                                                      color: Colors.grey[600]),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 80,
                                                height: 30,
                                                child: Card(
                                                  color: cubit.orderStateColor(
                                                      orderModel.orderState
                                                          .toLowerCase()),
                                                  child: Center(
                                                      child: Text(
                                                    cubit.orderStateArabic(
                                                        orderModel.orderState
                                                            .toLowerCase()),
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  )),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Divider(),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(cubit.listProject
                                                    .firstWhere((element) =>
                                                        element.id ==
                                                        orderModel.projectId)
                                                    .name),
                                                const SizedBox(width: 15),
                                                CircleAvatar(
                                                  radius: 25.0,
                                                  backgroundImage: NetworkImage(
                                                      cubit.listProject
                                                          .firstWhere(
                                                              (element) =>
                                                                  element.id ==
                                                                  orderModel
                                                                      .projectId)
                                                          .image),
                                                  backgroundColor:
                                                      Colors.transparent,
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Divider(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                orderModel.orderPrice
                                                            .toString() +
                                                        ' EGP' ??
                                                    '0',
                                                style: const TextStyle(
                                                    color:
                                                        Colors.lightBlueAccent,
                                                    fontSize: 17),
                                              ),
                                              const Text(
                                                ' : المجموع  ',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 17),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                cubit.goToOrderDetail(
                                                    orderId: orderModel.orderId,
                                                    context: context);
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                color: Colors.blue[300],
                                                child: const Center(
                                                    child: Text(
                                                  'تفاصيل الطلب',
                                                  style: TextStyle(
                                                      color: Constants.white,
                                                      fontWeight:
                                                          FontWeight.w800),
                                                )),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                // if (cubit.listAllOrders.where((element) => element.userMobile == Global.mobile && element.projectId == Global.projectId).length - 1 == index)
                                //   Container(
                                //     height: 100,
                                //     color: Colors.transparent,
                                //   )
                              ],
                            );
                          },
                        ),
                      );
                    },
                    fallbackBuilder: (BuildContext context) => const Center(
                        child: Text(
                      'لا يوجد طلبات',
                      style: TextStyle(color: Colors.red, fontSize: 18),
                    )),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
