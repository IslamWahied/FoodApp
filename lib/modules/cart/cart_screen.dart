//@dart=2.9
import 'package:elomda/bloc/home_bloc/HomeCubit.dart';
import 'package:elomda/bloc/home_bloc/HomeState.dart';

import 'package:elomda/shared/components/Componant.dart';
import 'package:elomda/styles/colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'orderDetail.dart';

class OrderScreen extends StatelessWidget {
  final bool isShowNavBar;
   const OrderScreen({this.isShowNavBar,Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeScreenState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return SafeArea(
            child: Scaffold(

              appBar:isShowNavBar != false? AppBar(
                elevation: 0,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent,
                centerTitle: false,
                leadingWidth: 0,
                iconTheme: const IconThemeData(
                    color: Constants.black
                ),

                title:customAppBar(context: context,title: '') ,
              ): AppBar(

                elevation: 0,
                backgroundColor: Colors.transparent,
              ),
              floatingActionButton: Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width - 40),
                  child: ElevatedButton(
                    onPressed: () {
                      // cubit.listOrder.add(HomeCubit.get(context).listItemsSearch.firstWhere((element) => element.itemId == cubit.selectedItemId));
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              'assets/dollar.svg',
                              color: Constants.tertiary,
                              width: 15,
                            ),
                            PrimaryText(
                              text: cubit.getTotalPrice() ?? '0',
                              size: 30,
                              fontWeight: FontWeight.w700,
                              color: Constants.tertiary,
                              height: 1,
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const PrimaryText(
                          text: 'تاكيد الطلب',
                          fontWeight: FontWeight.w600,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(
                          Icons.chevron_right,
                          color: Constants.black,
                        )
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: cubit.getTotalPrice() == '0' ||
                                cubit.getTotalPrice() == null
                            ? Colors.yellowAccent[200]
                            : Constants.primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 20),
                        textStyle: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                  ),
                ),
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
                      visible: cubit.listOrder.isNotEmpty && cubit.listOrder != [],
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

Widget itemCard(
    {
      int itemId,
      int index,
    String imagePath,
    String subCategoryTitle,
    double itemPrice,
    String name,
    String itemDescription,
    String star,
    context,
    double itemsPrice}) {
  return GestureDetector(
    onTap: () {

      var cubit = HomeCubit.get(context);
      cubit.selectedItemId = itemId;
      cubit.selectedCategoryId = cubit.listOrder[index].categoryId;
      cubit.selectedSubCategoryId = cubit.listOrder[index].supCategoryId;

      navigateTo(
          context,
          OrderDetailScreen(
            additionsList: cubit.listOrder[index].additionsList??[],
            isDiscount:cubit.listOrder[index].isDiscount ,
            oldPrice: cubit.listOrder[index].oldPrice,
            imagePath:cubit.listOrder[index]
                .image,
            subCategoryTitle:cubit.listOrder[index].supCategoryTitle,
            itemName:cubit.listOrder[index]
                .itemTitle,
            itemDescription: cubit.listOrder[index]
                    .description ??
                '',
            index: index,
            itemPrice: cubit.listOrder[index]
                .price,
          ));
    },
    child: Container(
      margin: const EdgeInsets.only(right: 15, left: 0, top: 25, bottom: 10),
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
                padding: const EdgeInsets.only(top: 25, left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Constants.primary,
                          size: 20,
                        ),
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
                    child:       Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children:  [
                        Text(
                          HomeCubit.get(context).listOrder[index].orderCount.toString()??'1',style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w400,),),
                        const Text(' : العدد',style: TextStyle(  fontWeight: FontWeight.w700,
                          color: Constants.tertiary, ),),

                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (HomeCubit.get(context)
                          .listOrder[index]
                          .isDiscount)
                        PrimaryText(
                          isDiscount: true,
                          text: HomeCubit.get(context)
                              .listOrder[index]
                              .oldPrice
                              .toString(),
                          size: 20,
                          fontWeight: FontWeight.w700,
                          color: Constants.lighterGray,
                          height: 1,
                        ),
                      SvgPicture.asset(
                        'assets/dollar.svg',
                        color: Constants.tertiary,
                        width: 15,
                      ),
                      PrimaryText(
                        text: itemPrice.toString(),
                        size: 20,
                        fontWeight: FontWeight.w700,
                        color: Constants.tertiary,
                        height: 1,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          Container(
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
                      color: Colors.grey[300], blurRadius: 20, spreadRadius: 2)
                ]),
            child: Hero(
              // key: GlobalKey(debugLabel: index.toString()),
               tag: imagePath + index.toString(),
              child: Image.network(imagePath??'',
                  width: MediaQuery.of(context).size.width / 2.9),
            ),
          ),
        ],
      ),
    ),
  );
}
