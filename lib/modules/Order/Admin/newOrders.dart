// @dart=2.9

import 'package:elomda/bloc/home_bloc/HomeCubit.dart';
import 'package:elomda/bloc/home_bloc/HomeState.dart';
import 'package:elomda/models/category/additionsModel.dart';
import 'package:elomda/models/category/itemModel.dart';
import 'package:elomda/models/order/orderModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class NewOrderScreen extends StatelessWidget {
  const NewOrderScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeScreenState>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        var newOrderList = cubit.listAllOrders.where((element) =>element.orderState.toLowerCase() == 'New'.toLowerCase()).toList();
        return SafeArea(
          child: Scaffold(

            body: Conditional.single(
              context: context,
              conditionBuilder: (BuildContext context) => cubit.listAllOrders.where((element) => element.orderState.toLowerCase() == 'New'.toLowerCase()).toList().isNotEmpty,
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
                                height: 150,
                                width: 80,
                                child: SlidableAction(
                                  // An action can be bigger than the others.
                                  flex: 1,
                                  onPressed: (context) {
                                    cubit.listAllOrders.firstWhere((element) =>element == orderModel).orderState = 'Prepared';
                                    cubit.emit(SelectCategoryState());
                                  },
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                  icon: Icons.check,
                                  label: 'Done',
                                ),
                              ),
                              const SizedBox(width: 5),
                              SizedBox(
                                height: 150,
                                width: 80,
                                child: SlidableAction(
                                  // An action can be bigger than the others.
                                  flex: 1,
                                  onPressed: (context) {
                                    cubit.listAllOrders.firstWhere((element) =>element == orderModel).orderState = 'Canceled';
                                    cubit.emit(SelectCategoryState());
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                              color: Colors.red,
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
                                            orderModel.createdDate ?? '',
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
                                                orderModel.totalPrice.toString() ??
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
                                                    builder: (context) =>
                                                            AlertDialog(
                                                              content: SingleChildScrollView(
                                                                child: Column(
                                                                  mainAxisSize: MainAxisSize.min,
                                                                  crossAxisAlignment: CrossAxisAlignment.end,
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
                                                                              color:
                                                                                  Colors.blue,
                                                                              fontSize: 16),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 10,
                                                                    ),



SizedBox(
  width: MediaQuery.of(context).size.width * 0.7,
  height: 200,
  child:   ListView.separated(

      itemBuilder: (context,index)=>orderModelCard(orderModel.listItemModel[index],context), separatorBuilder:(context,index)=> const SizedBox(height: 10),

      itemCount: orderModel.listItemModel.length),
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
                                                                          'Close',
                                                                          style: TextStyle(
                                                                              color:
                                                                                  Colors.red),
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

              fallbackBuilder: (BuildContext context) => const Center(child: Text('No Orders')),
            ),
          ),
        );
      },
      listener: (context, state) => {},
    );
  }
}

Widget orderModelCard(ItemModel model,context) =>Card(
  child:
  Padding(
    padding:
    const EdgeInsets.all(10.0),
    child:


    Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:   [
            Text(model.orderCount.toString()),
            const Text('X'),
            Text(model.itemTitle.toString()),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        if(model.additionsList.isNotEmpty)
        const Text(
          ': الاضافات',
          style: TextStyle(color: Colors.blue),
        ),
        if(model.additionsList.isNotEmpty)
        SizedBox(
          height: 30,
          width: MediaQuery.of(context).size.width * 0.5,
          child: Container(
            // color: Colors.red,
            child: ListView.separated(
shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index){
                  return  Text(
                    model.additionsList[index].itemTitle??'' ,
                    style: const TextStyle(fontSize: 14,),
                  );
                },
                separatorBuilder: (context,index)=>index + 1 < model.additionsList.length ? const Text('  -  ',style: TextStyle(color: Colors.black),):const SizedBox(width: 5),
                itemCount: model.additionsList.length
            ),
          ),
        )

      ],
    ),
  ),
);