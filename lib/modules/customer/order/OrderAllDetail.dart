//@dart=2.9
import 'package:elomda/bloc/home_bloc/HomeCubit.dart';
import 'package:elomda/bloc/home_bloc/HomeState.dart';
import 'package:elomda/models/category/itemModel.dart';
import 'package:elomda/models/noteModel.dart';
import 'package:elomda/models/order/orderModel.dart';

import 'package:elomda/modules/customer/product_details/foodDetail.dart';

import 'package:elomda/styles/colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderAllDetail extends StatelessWidget {
  OrderModel orderModel;

  OrderAllDetail({Key key, this.orderModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            title: 'تفاصيل الطلب',
            isShowCarShop: true,
            isYellow: true),
      ),
      backgroundColor: Constants.white,
      body: BlocConsumer<HomeCubit,HomeState>(
        builder: (context,state){
          var cubit  = HomeCubit.get(context);
          return  SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Expanded(
                  child: SingleChildScrollView(

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [

                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 200,
                          child: Card(
                            elevation: 2,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        HomeCubit.get(context).convertDateFormat(
                                            orderModel.createdDate) ??
                                            '',
                                        style: TextStyle(
                                            fontSize: 13.5, color: Colors.grey[600]),
                                      ),
                                      SizedBox(
                                        width: 80,
                                        height: 30,
                                        child: Card(
                                          color: orderModel.orderState.toLowerCase() ==
                                              'Canceled'
                                              ? Colors.red
                                              : Colors.green,
                                          child: Center(
                                              child: Text(
                                                orderModel.orderState.toLowerCase() ==
                                                    'Canceled'
                                                    ? 'تم الالغاء'
                                                    : 'تم الاستلام',
                                                style: const TextStyle(color: Colors.white),
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
                                      Text(HomeCubit.get(context)
                                          .listProject
                                          .firstWhere((element) =>
                                      element.id == orderModel.projectId)
                                          .name),
                                      const SizedBox(width: 15),
                                      CircleAvatar(
                                        radius: 25.0,
                                        backgroundImage: NetworkImage(
                                            HomeCubit.get(context)
                                                .listProject
                                                .firstWhere((element) =>
                                            element.id == orderModel.projectId)
                                                .image),
                                        backgroundColor: Colors.transparent,
                                      ),
                                    ],
                                  ),
                                  const Divider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            orderModel.orderPrice.toString() + ' EGP' ??
                                                '0',
                                            style: const TextStyle(
                                                color: Colors.lightBlueAccent,
                                                fontSize: 17),
                                          ),
                                          const Text(
                                            ' : المجموع  ',
                                            style: TextStyle(
                                                color: Colors.grey, fontSize: 17),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: double.infinity,
                                height: 200,
                                child: ListView.separated(
                                    itemBuilder: (context, index) => orderModelCard(
                                        orderModel.listItemModel[index], context),
                                    separatorBuilder: (context, index) =>
                                    const SizedBox(height: 10),
                                    itemCount: orderModel.listItemModel.length),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text('الملاحظات'),
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: SizedBox(
                                          height:
                                          MediaQuery.of(context).size.height *
                                              0.33,
                                          width:
                                          MediaQuery.of(context).size.width *
                                              0.4,
                                          child: SingleChildScrollView(
                                            child: Stack(
                                              clipBehavior: Clip.none,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                                  children: [
                                                    const SizedBox( height: 50,),
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                      children: const [
                                                        Text(
                                                          'اضافة ملاحظة',
                                                          style: TextStyle(
                                                              color: Colors.red,
                                                              fontWeight:
                                                              FontWeight.bold),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Directionality(
                                                      textDirection: TextDirection.rtl,
                                                      child: TextFormField(
                                                        // key: const ValueKey('Description'),
                                                        controller: cubit.txtnote,

                                                        maxLines: 4,

                                                        autofocus: true,
                                                        textCapitalization:
                                                        TextCapitalization.sentences,
                                                        decoration: InputDecoration(

                                                          fillColor: Colors.white,
                                                          focusedBorder: OutlineInputBorder(
                                                            borderRadius:
                                                            BorderRadius.circular(25.0),
                                                            borderSide: const BorderSide(
                                                              color: Colors.black,
                                                            ),
                                                          ),
                                                          border: OutlineInputBorder(
                                                            borderRadius:
                                                            BorderRadius.circular(25.0),
                                                            borderSide: const BorderSide(
                                                              color: Colors.black,
                                                              width: 2.0,
                                                            ),
                                                          ),
                                                          // labelText: 'الوصف',
                                                          labelStyle: const TextStyle(
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: 14),
                                                        ),
                                                        onChanged: (text) {
                                                          // cubit.checkIsUploadValid(context);
                                                        },
                                                      ),
                                                    ),
                                                    const SizedBox(height: 20),
                                                    GestureDetector(
                                                        onTap: () {




                                                        //  cubit.addNote(context,, cubit.caseNumber, 1, true);
                                                        },
                                                        child:
                                                        const CircleAvatar(
                                                          radius: 25,
                                                          child:
                                                          Center(
                                                              child:
                                                              Icon(
                                                                Icons.send,
                                                                color: Colors
                                                                    .white,
                                                                size: 15,
                                                              )),
                                                          backgroundColor:
                                                          Colors.red,
                                                        )),
                                                  ],
                                                ),
                                                Positioned(
                                                  top: -12,
                                                  right: 0,
                                                  child: InkWell(onTap: (){

                                                    Navigator.pop(context);
                                                  },
                                                    child: const CircleAvatar(
                                                      radius: 13,
                                                      backgroundColor: Colors.red,
                                                      child: Icon(Icons.close,color: Constants.white,),
                                                    ),
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),
                                        ),
                                        elevation: 24,
                                        backgroundColor: Colors.blueGrey[50],
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(25.0))),
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(
                                  Icons.add_comment,
                                  color: Colors.red,
                                  size: 25,
                                )),

                          ],
                        ),

                        Container(
                          height:500 ,
                          width:double.infinity,
                          child: ListView.separated(

                              itemBuilder: (context,state){



                                return   Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const CircleAvatar(
                                          radius: 25,
                                          child: Text('ES'),
                                          backgroundColor: Colors.pink,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width * 0.03,
                                        ),
                                        Expanded(
                                          child: Container(
                                              padding: const EdgeInsets.all(10),
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: Colors.black26
                                              ),
                                              child: const SingleChildScrollView(
                                                  child: Text(
                                                    'notTextaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 16),
                                                  )

                                              )


                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context,state)=> const SizedBox(height: 10),

                              itemCount: 20
                          ),
                        ),

                        const SizedBox(height: 100,)



                      ],
                    ),
                  ),
                ),

              ));
        },
        listener: (context,state){},

      ),
    );
  }
}

Widget orderModelCard(ItemModel model, context) => Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(model.orderCount.toString()),
                  const Text('X'),
                  Text(model.itemTitle.toString()),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            if (model.additionsList.isNotEmpty)
              const Padding(
                padding: EdgeInsets.only(right: 10),
                child: Text(
                  ': الاضافات',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            if (model.additionsList.isNotEmpty)
              SizedBox(
                height: 30,
                width: MediaQuery.of(context).size.width * 0.9,
                child: ListView.separated(
                    shrinkWrap: true,
                    reverse: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Text(
                            model.additionsList[index].itemTitle ?? '',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.red),
                          ),
                          Text(' - ' + (index + 1).toString()),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 15),
                    itemCount: model.additionsList.length),
              )
          ],
        ),
      ),
    );
