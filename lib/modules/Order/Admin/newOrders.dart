// @dart=2.9

import 'package:elomda/bloc/home_bloc/HomeCubit.dart';
import 'package:elomda/models/category/additionsModel.dart';
import 'package:elomda/models/category/itemModel.dart';
import 'package:elomda/models/order/orderModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class NewOrderScreen extends StatelessWidget {
  const NewOrderScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),

        // appBar: AppBar(),
        body: Conditional.single(
          conditionBuilder: (BuildContext context) =>
          HomeCubit
              .get(context)
              .listAllOrders
              .where((element) =>
          element.orderState.toLowerCase() == 'New'.toLowerCase())
              .toList()
              .isNotEmpty,
          widgetBuilder: (BuildContext context) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  return getOrderCard(
                    orderModel: HomeCubit
                        .get(context)
                        .listAllOrders
                        .where((element) =>
                    element.orderState.toLowerCase() ==
                        'New'.toLowerCase())
                        .toList()[index],
                  );
                },
                separatorBuilder: (context, index) => SizedBox(),
                itemCount: HomeCubit
                    .get(context)
                    .listAllOrders
                    .where((element) =>
                element.orderState.toLowerCase() == 'New'.toLowerCase())
                    .toList()
                    .length);
          },
          context: context,
          fallbackBuilder: (BuildContext context) =>
          const Center(child: Text('No Orders')),
        ),
      ),
    );
  }
}

Widget getOrderCard({
  OrderModel orderModel,
}) {
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
                // HomeCubit.get(context).listOrder.removeWhere(
                // (item) => item == HomeCubit.get(context).listOrder[index]);
              },
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              icon: Icons.check,
              label: 'Done',
            ),
          ),
          SizedBox(width: 5),
          SizedBox(
            height: 150,
            width: 80,
            child: SlidableAction(
              // An action can be bigger than the others.
              flex: 1,
              onPressed: (context) {
                // HomeCubit.get(context).listOrder.removeWhere(
                // (item) => item == HomeCubit.get(context).listOrder[index]);
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(orderModel.userName ?? ''),
                          Baseline(
                              baseline: 25.0,
                              baselineType: TextBaseline.alphabetic,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 3),
                                child: Text(orderModel.departMent ?? '',
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400,
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
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'OrderCount : ',
                            style: TextStyle(color: Colors.blue, fontSize: 17),
                          ),
                          Text(
                            '20',
                            style: TextStyle(fontSize: 17),
                          )
                        ],
                      ),
                      Text(
                        orderModel.createdDate ?? '',
                        style:
                        TextStyle(fontSize: 13.5, color: Colors.grey[600]),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Spacer(),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Totale : ',
                            style: TextStyle(color: Colors.blue, fontSize: 17),
                          ),
                          Text(
                            orderModel.totalPrice.toString() ?? '0',
                            style: TextStyle(fontSize: 17),
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
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Order Detail',
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontSize: 16),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          SizedBox(
                                            width: double.infinity,
                                            child: OrderDetail(orderModel:orderModel ,context: context)

                                            // Card(
                                            //   child: Padding(
                                            //     padding:
                                            //     const EdgeInsets.all(10.0),
                                            //     child: Column(
                                            //       crossAxisAlignment:
                                            //       CrossAxisAlignment.end,
                                            //       children: [
                                            //         Row(
                                            //           mainAxisAlignment:
                                            //           MainAxisAlignment
                                            //               .spaceBetween,
                                            //           children: [
                                            //             Text('2'),
                                            //             Text('X'),
                                            //             Text('فول بالصلصه'),
                                            //           ],
                                            //         ),
                                            //         SizedBox(
                                            //           height: 10,
                                            //         ),
                                            //         Text(
                                            //           ': الاضافات',
                                            //           style: TextStyle(
                                            //               color: Colors.blue),
                                            //         ),
                                            //         Column(
                                            //           children: [
                                            //             Text(
                                            //               '  طحينة - ',
                                            //               style: TextStyle(
                                            //                   fontSize: 14),
                                            //             ),
                                            //           ],
                                            //         ),
                                            //       ],
                                            //     ),
                                            //   ),
                                            // ),
                                          ),
                                          Divider(),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                'Close',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ))
                                        ],
                                      ),
                                    ));
                          },
                          child: Text('Details'))
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
}

Widget OrderDetail({
  context,
  OrderModel orderModel,
}) {
  return AlertDialog(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Order Detail',
              style: TextStyle(color: Colors.blue, fontSize: 16),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        // SizedBox(
        //   width: double.infinity,
        //   child: Card(
        //     child: Padding(
        //       padding: const EdgeInsets.all(10.0),
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.end,
        //         children: [
        //           Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //               Text('2'),
        //               Text('X'),
        //               Text('فول بالصلصه'),
        //             ],
        //           ),
        //           SizedBox(
        //             height: 10,
        //           ),
        //           Text(
        //             ': الاضافات',
        //             style: TextStyle(color: Colors.blue),
        //           ),
        //           Column(
        //             children: [
        //               Text(
        //                 '  طحينة - ',
        //                 style: TextStyle(fontSize: 14),
        //               ),
        //             ],
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        orderDetailItems(
          context: context,
          orderModel:orderModel,
        ),
        Divider(),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Close',
              style: TextStyle(color: Colors.red),
            ))
      ],
    ),
  );
}

Widget orderDetailItems
(
{
  context,
  OrderModel orderModel,

}){
return SizedBox(
width: double.infinity,
child: Card(
child: Padding(
padding: const EdgeInsets.all(10.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.end,
children: [
Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
Text('2'),
Text('X'),
Text('فول بالصلصه'),
],
),
SizedBox(
height: 10,
),
Text(
': الاضافات',
style: TextStyle(color: Colors.blue),
),
Column(
children: [
Text(
'  طحينة - ',
style: TextStyle(fontSize: 14),
),
],
),
],
),
),
),
);
}