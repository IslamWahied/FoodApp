//@dart=2.9
import 'package:backdrop/backdrop.dart';
import 'package:badges/badges.dart';
import 'package:cart_stepper/cart_stepper.dart';
import 'package:elomda/bloc/home_bloc/HomeCubit.dart';
import 'package:elomda/bloc/home_bloc/HomeState.dart';
import 'package:elomda/modules/home/Userbacklayer.dart';
import 'package:elomda/modules/home/adminBackLayer.dart';
import 'package:elomda/modules/user_info/user_info_screen.dart';
import 'package:elomda/shared/Global.dart';
import 'package:elomda/shared/components/Componant.dart';
import 'package:elomda/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_svg/svg.dart';

import 'FeedFoodDetail.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeScreenState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return BackdropScaffold(
            onBackLayerConcealed: (){
              cubit.isShowBackLayer = true;
              cubit.emit(SelectCategoryState());
            },
            onBackLayerRevealed: (){
              cubit.isShowBackLayer = false;
              cubit.emit(SelectCategoryState());
            },

            frontLayerBackgroundColor: Constants.white,
            headerHeight: MediaQuery.of(context).size.height * 0.45,
            appBar: BackdropAppBar(
              title:   Text( cubit.selectedTab),
              leading: const BackdropToggleButton(
                icon: AnimatedIcons.home_menu,
                color: Colors.deepOrange,
              ),
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                ),
              ),
              actions: [
                cubit.isShowBackLayer?        IconButton(
                    onPressed: () {
                      // navigateTo(context, User_Info());
                    },
                    padding: const EdgeInsets.all(10),
                    icon:   CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.white,
                      child:Global.imageUrl != null?
                      CircleAvatar(
                        radius: 30.0,
                        backgroundImage:
                        NetworkImage(Global.imageUrl),
                        backgroundColor: Colors.transparent,
                      )

                          :
                      const CircleAvatar(
                        radius: 13,
                        backgroundImage: AssetImage('assets/person.jpg'),

                      ),
                    )):const SizedBox(width: 1,)

              ],
            ),
            backLayer: UserBackLayerMenu(),
            frontLayer:Conditional.single(
              context: context,
              conditionBuilder: (BuildContext context) => cubit.listAllOrders.where((element) => element.orderState.toLowerCase() == 'New'.toLowerCase() &&  element.projectId == Global.projectId).toList().isNotEmpty,
              widgetBuilder: (BuildContext context) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20, top: 15),
                      child: Badge(
                          badgeContent: Text(
                            cubit.listOrder.length.toString() ?? '0',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 11),
                          ),
                          child:
                          Image.asset('assets/shoppingcart.png', width: 30)),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 20),
                        const Icon(
                          Icons.search,
                          color: AppColors.secondary,
                          size: 25,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                            child: TextField(
                              controller: cubit.txtFavouriteControl,
                              onChanged: (String value) {
                                cubit.searchInFeeds(value);
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
                    Visibility(
                      visible:cubit.listFavourite.where((element) =>   element.projectId == Global.projectId).toList().isNotEmpty && cubit.listFavourite.any((element) => element.isFavourit &&  element.projectId == Global.projectId) ,
                      replacement: const Expanded(child: Center(child: Text('No Favourite Data'))),
                      child: Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount:cubit.listFavourite.where((element) =>   element.projectId == Global.projectId).toList().isNotEmpty && cubit.listItems.where((element) =>   element.projectId == Global.projectId).toList().isNotEmpty && cubit.listFavourite.where((element) =>   element.projectId == Global.projectId).toList().any((element) => element.isFavourit) &&cubit.listFavourite != [] ?cubit.listFavourite.where((element) => element.isFavourit &&  element.projectId == Global.projectId).toList().length:0  ,
                              itemBuilder: (context, index) {
                                var favModel = cubit.listFavourite.where((element) => element.isFavourit).toList()[index];

                                return    itemCard(
                                    isFavourite:favModel.isFavourit ,
                                    itemId:favModel.ItemId,
                                    itemPrice:cubit.listItems.firstWhere((element) => element.itemId == favModel.ItemId &&  element.projectId == Global.projectId).price??0,
                                    subCategoryTitle:
                                    cubit.listItems.firstWhere((element) => element.itemId ==  favModel.ItemId &&  element.projectId == Global.projectId).supCategoryTitle,
                                    name:cubit.listItems.firstWhere((element) => element.itemId == favModel.ItemId &&  element.projectId == Global.projectId).itemTitle,
                                    context: context,
                                    imagePath: cubit.listItems.firstWhere((element) => element.itemId ==  favModel.ItemId &&  element.projectId == Global.projectId).image,
                                    itemsPrice:cubit.listItems.firstWhere((element) => element.itemId == favModel.ItemId &&  element.projectId == Global.projectId).price,
                                    star: '',
                                    itemDescription: cubit.listItems.firstWhere((element) => element.itemId == favModel.ItemId &&  element.projectId == Global.projectId).description ?? '');
                              }

                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },

              fallbackBuilder: (BuildContext context) => const Center(child: Text('لا يوجد طلبات',style: TextStyle(color: Colors.red,fontSize: 18),)),
            ),

          );
        });
  }
}

Widget itemCard(
    {int itemId,
    String imagePath,
    String subCategoryTitle,
    double itemPrice,
    String name,
    String itemDescription,
    String star,
      bool isFavourite,
    context,
    double itemsPrice}) {
  int value = 1;
  return StatefulBuilder(builder: (context, setState) {
    return GestureDetector(
      onTap: () {
        HomeCubit.get(context).selectedItemId = itemId;
        HomeCubit.get(context).selectedCategoryId = HomeCubit.get(context)
        .listItems.firstWhere((element) => element.itemId == HomeCubit.get(context).listFavourite.firstWhere((element) => element.ItemId == itemId &&  element.projectId == Global.projectId).ItemId).categoryId;
        HomeCubit.get(context).selectedSubCategoryId = HomeCubit.get(context)
            .listItems.firstWhere((element) => element.itemId == HomeCubit.get(context).listFavourite.firstWhere((element) => element.ItemId == itemId &&  element.projectId == Global.projectId).ItemId)
            .supCategoryId;

        navigateTo(
            context,
            FeedFoodDetailScreen(
              isDiscount: HomeCubit.get(context)
                  .listItems
                  .firstWhere((element) => element.itemId == itemId &&  element.projectId == Global.projectId).isDiscount??false,
itemId:HomeCubit.get(context)
    .listItems
    .firstWhere((element) => element.itemId == itemId &&  element.projectId == Global.projectId)
    .itemId ,
              imagePath: HomeCubit.get(context)
                  .listItems
                  .firstWhere((element) => element.itemId == itemId &&  element.projectId == Global.projectId)
                  .image,
              subCategoryTitle: HomeCubit.get(context)
                  .listItems
                  .firstWhere((element) => element.itemId == itemId &&  element.projectId == Global.projectId)
                  .supCategoryTitle,
              itemName: HomeCubit.get(context)
                  .listItems
                  .firstWhere((element) => element.itemId == itemId &&  element.projectId == Global.projectId)
                  .itemTitle,
              itemDescription:  HomeCubit.get(context)
                  .listItems
                  .firstWhere((element) => element.itemId == itemId &&  element.projectId == Global.projectId)
                      .description ??
                  '',
              itemPrice:  HomeCubit.get(context)
                  .listItems
                  .firstWhere((element) => element.itemId == itemId &&  element.projectId == Global.projectId)
                  .price,
              oldPrice:  HomeCubit.get(context)
                .listItems
                .firstWhere((element) => element.itemId == itemId &&  element.projectId == Global.projectId)
                .oldPrice,
              orderCount: value??1,

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
                        children: [
                          // const Icon(
                          //   Icons.star,
                          //   color: Constants.primary,
                          //   size: 20,
                          // ),
                          // const SizedBox(width: 10),
                          GestureDetector(
                              onTap: (){
                                HomeCubit.get(context).changeItemFavouriteState(itemId:itemId,isFavourite:isFavourite);
                              },
                              child: isFavourite?  const Icon(Icons.favorite,color: Colors.red,size: 25,) :const Icon(Icons.favorite_border,size: 25)),
                          const SizedBox(
                            width: 5,
                          ),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {


                            HomeCubit.get(context).addNewItemToCartFromFeedsScreen(orderCount: value,itemId:itemId );


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
                        const SizedBox(
                          width: 10,
                        ),
                        Row(
                          children: [


                            if(HomeCubit.get(context).listItems.firstWhere((element) => element.itemId == itemId &&  element.projectId == Global.projectId).isDiscount)
                              PrimaryText(
                                isDiscount: true,
                                text: HomeCubit.get(context).listItems.firstWhere((element) => element.itemId == itemId &&  element.projectId == Global.projectId).oldPrice.toString(),
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
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (value != 1) {
                                      value = value - 1;
                                    }
                                  });
                                },
                                child: const CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.blueAccent,
                                  child: Text(
                                    '-',
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(value.toString() ?? '1'),
                              const SizedBox(width: 10),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (value != 50) {
                                      value = value + 1;
                                    }
                                  });
                                },
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor:
                                      Colors.blueAccent.withOpacity(0.9),
                                  child: const Text(
                                    '+',
                                    style: TextStyle(
                                        fontSize: 22, color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
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
                15.0,
                -20.0,
                0.0,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey[300],
                        blurRadius: 20,
                        spreadRadius: 5)
                  ]),
              child: Hero(
                tag: imagePath,
                child: Image.network(imagePath,
                    width: MediaQuery.of(context).size.width / 2.9),
              ),
            ),
          ],
        ),
      ),
    );
  });
}
