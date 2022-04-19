//@dart=2.9
import 'package:elomda/bloc/home_bloc/HomeCubit.dart';
import 'package:elomda/bloc/home_bloc/HomeState.dart';
import 'package:elomda/modules/product_details/foodDetail.dart';
import 'package:elomda/shared/Global.dart';

import 'package:elomda/shared/components/Componant.dart';
import 'package:elomda/styles/colors.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';


class ItemsScreen extends StatelessWidget {
  final String subcategoryTitle;
  const ItemsScreen({this.subcategoryTitle,Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<HomeCubit, HomeScreenState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
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

              title:customAppBar(context: context,title: subcategoryTitle) ,
            ),
            backgroundColor:Constants.white,
            body: SafeArea(

              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     // customAppBar2(context),
                    //
                    //
                    //     SizedBox(width: MediaQuery.of(context).size.width * 0.15),
                    //   ],
                    // ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                        const SizedBox(width: 20),
                        const Icon(
                          Icons.search,
                          color: AppColors.secondary,
                          size: 25,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                            child: TextField(
                              controller: cubit.txtItemControl,
                              onChanged: (String value){
                                  cubit.searchInItems(value);
                              },
                              decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: AppColors.lighterGray)),
                                hintText: 'Search..',
                                hintStyle: TextStyle(
                                    color: AppColors.lightGray,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),

                            )),
                        const SizedBox(width: 20),
                      ],
                    ),

                    // GridView.count(
                    //   shrinkWrap: true,
                    //
                    //   physics: const NeverScrollableScrollPhysics(),
                    //   crossAxisCount: 2,
                    //   mainAxisSpacing: 1.0,
                    //   crossAxisSpacing: 1.0,
                    //   childAspectRatio: 1 / 1.58,
                    //   padding: const EdgeInsets.only(left: 15),
                    //
                    //   children: List.generate(
                    //     cubit.listItemsSearch.length, (index) =>
                    //       itemCard(cubit.listItemsSearch[index].image, cubit.listItemsSearch[index].itemTitle,'','', context),
                    //   ),
                    // ),

                    Expanded(
                      child: SizedBox(

                        width: MediaQuery.of(context).size.width * 0.9,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: cubit.listItemsSearch.where((element) =>   element.projectId == Global.projectId).toList().length??0,
                          itemBuilder: (context, index) => itemCard(
                            isDiscount: cubit.listItemsSearch.where((element) =>   element.projectId == Global.projectId).toList()[index].isDiscount,
                            isFavourite:cubit.listFavourite.where((element) =>   element.projectId == Global.projectId).toList().isNotEmpty && cubit.listFavourite.any((element) => element.ItemId == cubit.listItemsSearch[index].itemId && element.isFavourit &&  element.projectId == Global.projectId)?true:false ,
                            itemId:cubit.listItemsSearch.where((element) =>   element.projectId == Global.projectId).toList()[index].itemId ,
                              itemPrice:cubit.listItemsSearch.where((element) =>   element.projectId == Global.projectId).toList()[index].price ,
                            subCategoryTitle: cubit.listItemsSearch.where((element) =>   element.projectId == Global.projectId).toList()[index].supCategoryTitle,
                              name:cubit.listItemsSearch.where((element) =>   element.projectId == Global.projectId).toList()[index].itemTitle,
                              context: context,
                              imagePath:  cubit.listItemsSearch.where((element) =>   element.projectId == Global.projectId).toList()[index].image,
                              itemsPrice:  cubit.listItemsSearch.where((element) =>   element.projectId == Global.projectId).toList()[index].price,
                              star: '',
                              itemDescription: cubit.listItemsSearch.where((element) =>   element.projectId == Global.projectId).toList()[index].description??''


                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
Widget itemCard({bool isFavourite,bool isDiscount,int itemId,String imagePath,String subCategoryTitle,double itemPrice ,String name, String itemDescription, String star, context,double itemsPrice}) {
  int value = 1;
  return StatefulBuilder(
      builder: (context, setState) {

      return  GestureDetector(
          onTap: (){
            HomeCubit.get(context).selectedItemId = itemId;

            navigateTo(context, FoodDetail(

              orderCount:value??1 ,
              isDiscount:isDiscount ,
              imagePath:imagePath,
              subCategoryTitle:subCategoryTitle,
              itemName:name ,
              itemDescription:itemDescription??'' ,
              itemPrice: itemsPrice,


            ));


          },
          child: Container(
            margin: const EdgeInsets.only(right: 15, left:0, top: 25,bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(blurRadius: 10, color: Constants.lighterGray)
              ],

              color: Constants.white,
            ),
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topRight,
              //   crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children:  [
                              GestureDetector(
                                  onTap: (){
                                    HomeCubit.get(context).changeItemFavouriteState(itemId:itemId,isFavourite:isFavourite);
                                  },
                                  child: isFavourite?  const Icon(Icons.favorite,color: Colors.red,size: 25,) :const Icon(Icons.favorite_border,size: 25)),

                              // const Icon(
                              //   Icons.star,
                              //   color: Constants.primary,
                              //   size: 20,
                              // ),
                              const SizedBox(width: 10),
                              SizedBox(
                                // width: MediaQuery.of(context).size.width / 2.2,
                                height:33 ,
                                child: PrimaryText(

                                    text: name, size: 22, fontWeight: FontWeight.w700),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: (){
                                HomeCubit.get(context).addNewItemToCartFromItemScreen(orderCount: value,itemId: itemId);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 45, vertical: 20),
                                decoration: const BoxDecoration(
                                    color: Constants.primary,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    )),
                                child: const Icon(Icons.add, size: 20),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if(HomeCubit.get(context).listItemsSearch.firstWhere((element) => element.itemId == itemId &&  element.projectId == Global.projectId).isDiscount)
                                  PrimaryText(
                                    isDiscount: true,
                                    text: HomeCubit.get(context).listItemsSearch.firstWhere((element) => element.itemId == itemId &&  element.projectId == Global.projectId).oldPrice.toString(),
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
                                  size: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Constants.tertiary,
                                  height: 1,
                                ),


                              ],
                            ),
                          ],
                        ),


                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState((){
                                    if(value != 1 )
                                    {
                                      value = value - 1;
                                    }

                                  });

                                },
                                child: const CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.blueAccent,
                                  child: Text('-', style: TextStyle(
                                      fontSize: 25, color: Colors.white),),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(value.toString() ?? '1'),
                              const SizedBox(width: 10),
                              GestureDetector(
                                onTap: () {
                                  setState((){
                                    if(value != 50)
                                      {
                                        value = value + 1;
                                      }

                                  });
                                },
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.blueAccent
                                      .withOpacity(0.9),
                                  child: const Text('+', style: TextStyle(
                                      fontSize: 22, color: Colors.white),),
                                ),
                              ),

                            ],
                          ),
                        ),

                      ],
                    ),
                  ],
                ),
                Positioned(
                  top: -10,
                  right: -30,
                  child: Hero(
                    tag: imagePath,
                    child: Image.network(imagePath, width:100,height: 80,),
                  ),
                ),
              ],
            ),
          ),

        );
      });



}