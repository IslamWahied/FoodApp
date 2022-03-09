// @dart=2.9

import 'package:elomda/bloc/home_bloc/HomeCubit.dart';
import 'package:elomda/bloc/home_bloc/HomeState.dart';
import 'package:elomda/models/category/additionsModel.dart';
import 'package:elomda/modules/product_details/foodDetail.dart';
import 'package:elomda/shared/components/Componant.dart';

import 'package:elomda/styles/colors.dart';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class OrderDetailScreen extends StatelessWidget {
  final String imagePath;
  final bool isDiscount;
  final String itemName;
  final String subCategoryTitle;
  final  String itemDescription ;
  final double itemPrice;
  final double oldPrice;
  final int orderCount;
  final List<AdditionsModel> additionsList;
  final int index;

  const  OrderDetailScreen({this.orderCount,this.additionsList,this.oldPrice,this.isDiscount,this.index,this.imagePath,this.itemDescription,this.subCategoryTitle,this.itemName,this.itemPrice,Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeScreenState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);

        return   Scaffold(
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            centerTitle: false,
            leadingWidth: 0,
            iconTheme: const IconThemeData(
                color: Constants.black
            ),

            title:customAppBar(context: context,title: itemName) ,
          ),
          // floatingActionButton: ConstrainedBox(
          //   constraints: BoxConstraints(
          //       minWidth: MediaQuery.of(context).size.width - 40),
          //   child: ElevatedButton(
          //     onPressed: ()  async {
          //
          //        cubit.listOrder.removeWhere((item) => item ==  cubit.listOrder[index]);
          //         cubit.emit(SearchSubCategoryState());
          //       Navigator.pop(context);
          //     },
          //     child: Row(
          //       mainAxisSize: MainAxisSize.min,
          //       children: const [
          //         PrimaryText(
          //           text: 'حذف',
          //           color: Constants.white,
          //           fontWeight: FontWeight.w600,
          //           size: 18,
          //         ),
          //         SizedBox(width: 10,),
          //         Icon(Icons.chevron_right)
          //       ],
          //     ),
          //     style: ElevatedButton.styleFrom(
          //         primary: Colors.red,
          //         shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(10.0)),
          //         padding:
          //         const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          //         textStyle: const TextStyle(
          //             fontSize: 30, fontWeight: FontWeight.bold)),
          //   ),
          // ),
          // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          body: SingleChildScrollView(
            child: Column(
              children: [
                // customAppBar(context),
                Padding(
                  padding:  const EdgeInsets.only(left: 20, right: 20, top: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Hero(

                            tag: imagePath??'',
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey[400], blurRadius: 30),
                                ],
                                borderRadius: BorderRadius.circular(100),
                              ),
                              height: 200,
                              width: 170,
                              child: Image.network(imagePath??'', fit: BoxFit.cover),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: 160,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [

                                    if(isDiscount)
                                      PrimaryText(
                                        isDiscount: true,
                                        text: oldPrice.toString()??'',
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
                                      text: itemPrice.toString() ,
                                      size: 40,
                                      fontWeight: FontWeight.w700,
                                      color: Constants.tertiary,
                                      height: 1,
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(
                                height: 20,
                              ),
                              const PrimaryText(
                                  text: 'التوصيل في',
                                  fontWeight: FontWeight.w700,
                                  size: 22
                              ),




                              const SizedBox(
                                height: 8,
                              ),
                              const PrimaryText(
                                text: '30 دقيقة',
                                color: Constants.secondary,
                                size: 20,
                                fontWeight: FontWeight.w500,

                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 40,
                      ),
                      if( itemDescription != null && itemDescription.trim() != ''  )
                        const PrimaryText(
                            text: 'الوصف',
                            fontWeight: FontWeight.w700,
                            size: 22),
                      const SizedBox(
                        height: 10,
                      ),


                      SizedBox(
                        width: MediaQuery.of(context).size.width ,
                        height: 100,
                        child: SingleChildScrollView(
                          child: Text(

                            itemDescription??'',

                            textDirection: TextDirection.rtl,
                            textAlign:TextAlign.right ,
                            style:   const TextStyle(


                              color:  Constants.secondary,

                              fontFamily: 'Poppins',
                              fontSize: 20,

                              fontWeight: FontWeight.w500,
                            ),

                          ),
                        ),
                      ),
                      if(additionsList.isNotEmpty)
                        const SizedBox(
                          height: 50,
                        ),
                      if(additionsList.isNotEmpty)
                        const PrimaryText(
                            text: 'الاضافات',
                            fontWeight: FontWeight.w700,
                            size: 22),
                      // if(cubit.listFeedsSearch.firstWhere((element) => element.itemId == cubit.selectedItemId).additionsList.isNotEmpty)
                      // const SizedBox(
                      //   height: 15,
                      // ),
                    ],
                  ),
                ),

                if(additionsList.isNotEmpty)
                  SizedBox(
                    height: 150,

                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:  additionsList.length??0,
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.only(left: index == 0 ? 20 : 0,top: 10,bottom: 20),
                        child:
                        additionCard(
                            imagePath: additionsList[index].image
                            ,context: context,
                            cubit: cubit,

                            additionId: additionsList[index].itemId
                        ),
                      ),
                    ),
                  ),


                Card(
                  child: Column(
                    children: [





                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children:  [
                            const Text('جنية',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black87)),
                            Text((itemPrice * orderCount).toString(),style: const TextStyle(color: Colors.blue),),
                            const Text('=',style: TextStyle(color: Colors.red),),

                            Text(itemPrice.toString(),style: const TextStyle(color: Colors.blue),),

                            const Text('x',style: TextStyle(color: Colors.red),),
                            const SizedBox(
                              width: 5,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [

                                Text( orderCount.toString()??'1',style: const TextStyle(fontWeight: FontWeight.w600,color: Colors.blue),),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(':العدد ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                              ],
                            ),
                          ],
                        ),
                      ),

                      if(additionsList.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0,right: 25,bottom: 8,top: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children:  [
                              Text('جنية',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black87)),
                              SizedBox(
                                width: 5,
                              ),

                              Text(cubit.getTotalAddaitonlPriceForItem(index: index)??'0',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.blue),),
                              SizedBox(
                                width: 5,
                              ),
                              const Text(': سعر الاضافات',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                            ],
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:  [
                            Text('جنية',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black87)),
                            SizedBox(
                              width: 5,
                            ),

                            Text(HomeCubit.get(context).getTotalPriceForItem(index: index)??'0',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.blue),),
                            SizedBox(
                              width: 5,
                            ),
                            const Text(':الاجمالي',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
                SizedBox(height: 100,)
                // if(cubit.listFeedsSearch.firstWhere((element) => element.itemId == cubit.selectedItemId).additionsList.isNotEmpty)
                // const SizedBox(
                //   height: 100,
                // )
              ],
            ),
          ),
          bottomSheet: BottomSheet(
            enableDrag: false,

            onClosing: (){},
            builder: (context){

              return SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: ()  async {

                    cubit.listOrder.removeWhere((item) => item ==  cubit.listOrder[index]);
                    cubit.emit(SearchSubCategoryState());
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      PrimaryText(
                        text: 'حذف',
                        color: Constants.white,
                        fontWeight: FontWeight.w600,
                        size: 18,
                      ),
                      SizedBox(width: 10,),
                      Icon(Icons.chevron_right)
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      textStyle: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold)),
                ),
              );
            },
          ),
        );
      },
    );
  }
  GestureDetector additionCard({String imagePath,int additionId,HomeCubit cubit,context}) {
    return GestureDetector(
      onTap: (){
        if(cubit.listOfSelectedAdditions.any((element) => element.itemId ==additionId))
        {
          cubit.listOfSelectedAdditions.removeWhere((element) => element.itemId == additionId);
        }
        else{
          cubit.listOfSelectedAdditions.add(HomeCubit.get(context).listAdditions.firstWhere((element) => element.itemId == additionId));
        }
        cubit.emit(SelectCategoryState());
      },
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topRight,
        children: [

          Container(

              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 9),
              margin: const EdgeInsets.only(
                right: 20,
              ),
              decoration: BoxDecoration(
                  borderRadius:  BorderRadius.only(
                    bottomLeft:     const Radius.circular(20),
                    bottomRight:     const Radius.circular(20),
                    topLeft:  const Radius.circular(20),
                    topRight: cubit.listOfSelectedAdditions.any((element) => element.itemId == additionId)?  const Radius.circular(0)   :const Radius.circular(20),
                  ),
                  color: Constants.white,
                  boxShadow: [
                    BoxShadow(blurRadius: 10, color: Colors.grey[300]),
                  ]),
              child: Column(
                children: [
                  Image.network(
                    imagePath,
                    width: 110,
                    height: 50,
                  ),
                  const SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        'assets/dollar.svg',
                        color: Constants.tertiary,
                        width: 10,
                        height: 10,
                      ),
                      PrimaryText(
                        text: HomeCubit.get(context).listAdditions.firstWhere((element) => element.itemId == additionId).price.toString() ??0.toString(),
                        size: 10,
                        fontWeight: FontWeight.w700,
                        color: Constants.tertiary,
                        height: 1,
                      ),


                    ],
                  ),
                  const SizedBox(height: 5,),
                  PrimaryText(
                    text: HomeCubit.get(context).listAdditions.firstWhere((element) => element.itemId == additionId).itemTitle.toString() ??''.toString(),
                    size: 12,
                    fontWeight: FontWeight.w700,
                    color: Constants.darkBG,
                    height: 1,
                  ),
                ],
              )),
          // if(cubit.listOfSelectedAdditions.any((element) => element.itemId == additionId))
            const Positioned(
                top: -10,
                right: 10,
                child: Icon(Icons.check_circle,color: Colors.green,)),

        ],
      ),
    );
  }



}
// Padding customAppBar({BuildContext context,String title}) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(
//       horizontal: 0,
//       vertical: 10,
//     ),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         GestureDetector(
//           onTap: () => Navigator.pop(context),
//           child: Container(
//
//             padding: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//                 color: Constants.primary,
//                 borderRadius: BorderRadius.circular(15),
//                 border: Border.all(width: 1, color: Colors.grey[400])),
//             child: const Icon(Icons.chevron_left),
//           ),
//         ),
//
//         Text(title??'',style: const TextStyle( fontSize: 25,
//             fontWeight: FontWeight.w600,color: AppColors.black,overflow: TextOverflow.ellipsis),),
//         SizedBox(width:MediaQuery.of(context).size.width * 0.05 ,),
//         // Container(
//         //   padding: const EdgeInsets.all(10),
//         //   decoration: BoxDecoration(
//         //     color: Constants.primary,
//         //     borderRadius: BorderRadius.circular(15),
//         //   ),
//         //   child: const Icon(Icons.star, color: Constants.white),
//         // ),
//       ],
//     ),
//   );
// }