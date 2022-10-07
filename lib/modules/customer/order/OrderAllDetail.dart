//@dart=2.9
import 'package:elomda/bloc/home_bloc/HomeCubit.dart';
import 'package:elomda/bloc/home_bloc/HomeState.dart';
import 'package:elomda/models/category/itemModel.dart';

import 'package:elomda/modules/customer/product_details/foodDetail.dart';
import 'package:elomda/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderAllDetail extends StatelessWidget {


  OrderAllDetail({Key key}) : super(key: key);

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
                child: SingleChildScrollView(

                  child:cubit.orderModel != null && cubit.orderModel.orderState != null? Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [

                      const SizedBox(
                        height: 15,
                      ),

                      SingleChildScrollView(
                        controller: ScrollController(),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              children: [
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
                                              if(cubit.orderModel.orderState != null)
                                                Text(
                                                  HomeCubit.get(context).convertDateFormat(
                                                      cubit.orderModel.createdDate??"") ??
                                                      '',
                                                  style: TextStyle(
                                                      fontSize: 13.5, color: Colors.grey[600]),
                                                ),
                                              if(cubit.orderModel.orderState != null)
                                                SizedBox(
                                                  width: 80,
                                                  height: 30,
                                                  child: Card(
                                                    color: cubit.orderModel.orderState.toLowerCase() ==
                                                        'Canceled'
                                                        ? Colors.red :
                                                    cubit.orderModel.orderState.toLowerCase() == "new"?
                                                    Colors.amber[700]
                                                        : Colors.green,
                                                    child: Center(
                                                        child: Text(
                                                          cubit.orderModel.orderState.toLowerCase() ==
                                                              'Canceled'
                                                              ? 'تم الالغاء':
                                                          cubit.orderModel.orderState.toLowerCase() ==  "new"?
                                                          'جديد'
                                                              : 'تم الاستلام',
                                                          style:  const TextStyle(color: Colors.white,fontWeight: FontWeight.w500),
                                                        )),
                                                  ),
                                                ),
                                            ],
                                          ),
                                          const Divider(),
                                          if(cubit.orderModel.orderState != null)
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Text(HomeCubit.get(context)
                                                    .listProject
                                                    .firstWhere((element) =>
                                                element.id == cubit.orderModel.projectId)
                                                    .name),
                                                const SizedBox(width: 15),
                                                CircleAvatar(
                                                  radius: 25.0,
                                                  backgroundImage: NetworkImage(
                                                      HomeCubit.get(context)
                                                          .listProject
                                                          .firstWhere((element) =>
                                                      element.id == cubit.orderModel.projectId)
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
                                                    cubit.orderModel.orderPrice.toString() + ' EGP' ??
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

                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text("العناصر"),
                                SizedBox(height: 10),
                                SizedBox(
                                  width: double.infinity,
                                  height: 200,
                                  child: ListView.separated(
                                      itemBuilder: (context, index) => orderModelCard(
                                          cubit.orderModel.listItemModel[index], context),
                                      separatorBuilder: (context, index) =>
                                      const SizedBox(height: 10),
                                      itemCount: cubit.orderModel.listItemModel.length),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
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

                                                                  cubit.addNote(orderModel: cubit.orderModel,context: context,noteText: cubit.txtnote.text,projectId:cubit.orderModel.projectId);
                                                                  Navigator.of(context).pop();
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

                                SizedBox(
                                  height:500 ,
                                  width:double.infinity,
                                  child: ListView.separated(
                                      itemBuilder: (context,index){
                                        return   Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                  CircleAvatar(
                                                  radius: 25,
                                                  child: Text(cubit.orderModel.listNoteModel[index].senderName[0]??""),
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
                                                      child:   SingleChildScrollView(
                                                          child: Text(
                                                            cubit.orderModel.listNoteModel[index].noteText??"",
                                                            style: const TextStyle(
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
                                      itemCount: cubit.orderModel.listNoteModel.length
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),


                      // const SizedBox(height: 100,)



                    ],
                  ):SizedBox(),
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
