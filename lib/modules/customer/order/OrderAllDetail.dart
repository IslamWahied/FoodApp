//@dart=2.9
import 'package:elomda/bloc/home_bloc/HomeCubit.dart';
import 'package:elomda/bloc/home_bloc/HomeState.dart';
import 'package:elomda/models/category/itemModel.dart';

import 'package:elomda/modules/customer/product_details/foodDetail.dart';
import 'package:elomda/shared/Global.dart';
import 'package:elomda/styles/colors.dart';
import 'package:elomda/styles/icons/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderAllDetail extends StatelessWidget {


  OrderAllDetail({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
            return  Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(

                child:cubit.orderModel != null && cubit.orderModel.orderState != null? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
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
                                        color:cubit.orderStateColor(cubit.orderModel.orderState.toLowerCase()),
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
                    const SizedBox(height: 10),
                    const Text("العناصر"),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      height: 200,
                      child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => orderModelCard(
                              cubit.orderModel.listItemModel[index], context),
                          separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                          itemCount: cubit.orderModel.listItemModel.length),
                    ),


                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey[300],
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(
                          15.0,
                        ),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15.0,
                              ),
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: TextFormField(
                                  controller:  cubit.txtnote,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'أضافة ملاحظات علي الطلب...',
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 50.0,
                            color: Colors.lightBlue,
                            child: MaterialButton(
                              onPressed: () async {
                                if( cubit.txtnote.text!= null &&  cubit.txtnote.text.trim() != ''){
                                 await cubit.addNote(context: context,projectId: cubit.orderModel.projectId,noteText:  cubit.txtnote.text,orderModel:  cubit.orderModel);
                                }

                              },
                              minWidth: 1.0,
                              child: const Icon(
                                IconBroken.Send,
                                size: 16.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height:500 ,
                      width:double.infinity,
                      child:  ListView.separated(
                        reverse: true,
  controller: cubit.chatScrollControl,
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
                                      child: Text(cubit.orderModel.listNoteModel[index].senderName[0]??"",style: const TextStyle(color: Colors.white,fontSize: 22),),
                                      backgroundColor:cubit.orderModel.listNoteModel[index].senderMobile == Global.mobile? Colors.brown:Colors.lightBlue,
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
                                              color:cubit.orderModel.listNoteModel[index].senderMobile == Global.mobile? Colors.grey:Colors.lightBlue
                                          ),
                                          child:   Text(
                                            cubit.orderModel.listNoteModel[index].noteText??"",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16),
                                          )


                                      ),
                                    ),

                                    // if(cubit.orderModel.listNoteModel.length - 1 == index)
                                    //   const SizedBox(height: 150,)
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context,state)=> const SizedBox(height: 10),
                          itemCount: cubit.orderModel.listNoteModel.length
                      ),
                    ) ,

                  ],
                ):const SizedBox(),
              ),

            );
          },
          listener: (context,state){},

        ),
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
