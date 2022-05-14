//@dart=2.9
import 'package:elomda/bloc/home_bloc/HomeCubit.dart';
import 'package:elomda/models/order/orderModel.dart';
import 'package:elomda/modules/admin/Order/Admin/canceledOrder.dart';
import 'package:elomda/modules/customer/product_details/foodDetail.dart';
import 'package:elomda/shared/components/Componant.dart';
import 'package:elomda/styles/colors.dart';

import 'package:flutter/material.dart';

class OrderAllDetail extends StatelessWidget {
OrderModel  orderModel;
    OrderAllDetail({Key key,this.orderModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        centerTitle: false,
        leadingWidth: 0,

        iconTheme: const IconThemeData(
            color: Constants.black
        ),

        title:customAppBar(context: context,title: 'تفاصيل الطلب',isShowCarShop: true,isYellow: true) ,
      ),
      backgroundColor:Constants.white,
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(


        children: [
            const SizedBox(height: 15,),
            SizedBox(
              width: double.infinity,
              height: 200,
              child: Card(
                elevation: 2,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment
                            .spaceBetween,
                        children: [
                          Text(
                            HomeCubit.get(context).convertDateFormat(
                                orderModel
                                    .createdDate) ??
                                '',
                            style: TextStyle(
                                fontSize: 13.5,
                                color: Colors.grey[600]),
                          ),
                          SizedBox(
                            width: 80,
                            height: 30,
                            child: Card(
                              color: orderModel.orderState
                                  .toLowerCase() ==
                                  'Canceled'
                                  ? Colors.red
                                  : Colors.green,
                              child: Center(
                                  child: Text(
                                    orderModel.orderState
                                        .toLowerCase() ==
                                        'Canceled'
                                        ? 'تم الالغاء'
                                        : 'تم الاستلام',
                                    style: const TextStyle(
                                        color: Colors.white),
                                  )),
                            ),
                          ),
                        ],
                      ),
                      const Divider(),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [

                          Text(HomeCubit.get(context).listProject.firstWhere((element) => element.id == orderModel.projectId).name),
                          const SizedBox(width: 15),

                          CircleAvatar(
                            radius: 25.0,
                            backgroundImage: NetworkImage(HomeCubit.get(context).listProject.firstWhere((element) => element.id == orderModel.projectId).image),
                            backgroundColor: Colors.transparent,
                          ),
                        ],
                      ),



                      const Divider(),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment
                            .end,
                        children: [


                          Row(

                            children: [
                              Text(
                                orderModel.orderPrice
                                    .toString() +' EGP'??
                                    '0',
                                style: const TextStyle(
                                    color: Colors.lightBlueAccent,
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
                        ],
                      ),
                      const SizedBox(height: 15,),

                    ],
                  ),
                ),
              ),
            ),

            SingleChildScrollView(
              child:
              Column(
                mainAxisSize:
                MainAxisSize.min,
                crossAxisAlignment:
                CrossAxisAlignment
                    .end,
                children: [


                  SizedBox(
                    width:double.infinity,
                    height:
                    200,
                    child: ListView.separated(
                        itemBuilder: (context, index) => orderModelCard(orderModel.listItemModel[index], context),
                        separatorBuilder: (context, index) => const SizedBox(height: 10),
                        itemCount: orderModel.listItemModel.length
                    ),
                  ),


                ],
              ),
            ),


        ],


      ),
          )),
    );

  }
}
