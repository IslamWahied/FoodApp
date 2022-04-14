// @dart=2.9
import 'package:backdrop/backdrop.dart';
import 'package:elomda/bloc/home_bloc/HomeCubit.dart';
import 'package:elomda/bloc/home_bloc/HomeState.dart';
import 'package:elomda/modules/favourite/FeedFoodDetail.dart';
import 'package:elomda/modules/home/Userbacklayer.dart';
import 'package:elomda/modules/popularFood/popularFoodDetailScreen.dart';
import 'package:elomda/shared/Global.dart';
import 'package:elomda/shared/components/Componant.dart';
import 'package:elomda/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatelessWidget {
  const   HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeScreenState>(
      listener: (context, state) => () {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          backgroundColor: Constants.lightBG,
          body: Center(
            child: BackdropScaffold(
              frontLayerBackgroundColor: Constants.white,
              headerHeight: MediaQuery.of(context).size.height * 0.45,
              appBar: BackdropAppBar(
                title:   Text(cubit.selectedTab),
                leading: const BackdropToggleButton(
                  icon: AnimatedIcons.home_menu,
                  color: Colors.deepOrange,
                ),
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                ),
                actions: <Widget>[
                  IconButton(
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
                      ))
                ],
              ),
              backLayer: UserBackLayerMenu(),
              frontLayer: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: PrimaryText(
                            text: 'Food',
                            size: 22,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: PrimaryText(
                            text: 'Elomda',
                            height: 1.1,
                            size: 42,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const SizedBox(height: 25),
                        const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: PrimaryText(
                              text: 'Categories',
                              fontWeight: FontWeight.w700,
                              size: 22),
                        ),
                        SizedBox(
                          height: 240,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: cubit.listCategory.length ?? 0,
                            itemBuilder: (context, index) => Padding(
                              padding:
                                  EdgeInsets.only(left: index == 0 ? 25 : 0),
                              child: foodCategoryCard(
                                  cubit.listCategory[index].image,
                                  cubit.listCategory[index].categoryTitle,
                                  cubit.listCategory[index].categoryId,
                                  context),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 20, top: 10),
                          child: PrimaryText(
                              text: 'Popular',
                              fontWeight: FontWeight.w700,
                              size: 22),
                        ),
                        Column(
                          children: List.generate(
                            cubit.popularFoodList.length,
                            (index) => itemCard(
                              index: index,
                              isFavourite:cubit.listFavourite.isNotEmpty && cubit.listFavourite.any((element) => element.ItemId == cubit.popularFoodList[index].itemId && element.isFavourit)?true:false,

                              itemId: cubit.popularFoodList[index].itemId,
                              context: context,

                              imagePath: cubit.popularFoodList[index].image,
                              itemDescription: cubit.popularFoodList[index].description,
                              itemPrice: cubit.popularFoodList[index].price,
                              name: cubit.popularFoodList[index].itemTitle,
                              star: '5',

                              subCategoryTitle: cubit.popularFoodList[index].supCategoryTitle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget foodCategoryCard(String imagePath, String name, int categoryId, context) {
    return BlocConsumer<HomeCubit, HomeScreenState>(
      listener: (context, state) => {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return GestureDetector(
          onTap: () {
            cubit.selectCategory(categoryId, context);
          },
          child: Container(
            margin: const EdgeInsets.only(right: 20, top: 20, bottom: 20),
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: HomeCubit.get(context).selectedCategoryId == categoryId
                    ? Constants.primary
                    : Constants.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 15,
                  )
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // SvgPicture.asset(imagePath, width: 40),
                Image.network(imagePath, width: 90, height: 70),
                PrimaryText(text: name, fontWeight: FontWeight.w800, size: 16),
                RawMaterialButton(
                    onPressed: null,
                    fillColor: cubit.selectedCategoryId == categoryId
                        ? Constants.white
                        : Constants.tertiary,
                    shape: const CircleBorder(),
                    child: Icon(Icons.chevron_right_rounded,
                        size: 20,
                        color: HomeCubit.get(context).selectedCategoryId ==
                                categoryId
                            ? Constants.black
                            : Constants.white))
              ],
            ),
          ),
        );
      },
    );
  }

  Widget itemCard(
      {
        int itemId,
      String imagePath,
      String subCategoryTitle,
      double itemPrice,
      String name,
        int index,
      String itemDescription,
      String star,
      context,
        isFavourite
      }) {
    int value = 1;
    return StatefulBuilder(
        builder: (context, setState) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: () {

            HomeCubit.get(context).selectedItemId = itemId;
            HomeCubit.get(context).selectedCategoryId = HomeCubit.get(context).popularFoodList[index].categoryId;
            HomeCubit.get(context).selectedSubCategoryId = HomeCubit.get(context).popularFoodList[index].supCategoryId;

            navigateTo(
                context,
                popularFoodDetailScreen(
                  index: index,
                  orderCount: value,
                  oldPrice:HomeCubit.get(context).popularFoodList[index].oldPrice ,

                  isDiscount: HomeCubit.get(context).popularFoodList[index].isDiscount,
                  imagePath:HomeCubit.get(context).popularFoodList[index].image,
                  subCategoryTitle:HomeCubit.get(context).popularFoodList[index].supCategoryTitle,
                  itemName: HomeCubit.get(context).popularFoodList[index].itemTitle,
                  itemDescription:HomeCubit.get(context).popularFoodList[index].description ?? '',
                  itemPrice: HomeCubit.get(context).popularFoodList[index].price,
                  itemId:HomeCubit.get(context).popularFoodList[index].itemId,
                ));
          },
          child: Container(
            margin:
                const EdgeInsets.only(right: 15, left: 0, top: 25, bottom: 10),
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
                              GestureDetector(
                                onTap: (){
                                  HomeCubit.get(context).changeItemFavouriteState(itemId:itemId,isFavourite:isFavourite);
                                },
                                child: isFavourite?  const Icon(Icons.favorite,color: Colors.red,size: 25,) :const Icon(Icons.favorite_border,size: 25)),


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
                        GestureDetector(
                          onTap: () {
                            var cubit = HomeCubit.get(context);
                            cubit.addNewItemToCartFromHomeScreen(itemId:itemId,orderCount: value );

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
                        const SizedBox(width: 15),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [

                                  if(HomeCubit.get(context).popularFoodList.firstWhere((element) => element.itemId == itemId).isDiscount)
                                    PrimaryText(
                                     isDiscount: true,
                                      text: HomeCubit.get(context).popularFoodList.firstWhere((element) => element.itemId == itemId).oldPrice.toString(),
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
                              // const SizedBox(
                              //   width: 30,
                              // ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
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
                                              fontSize: 25,
                                              color: Colors.white),
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
                                              fontSize: 22,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
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
        ),
      );
    });
  }

// Widget popularFoodCard({String imagePath, String name, String weight, String star, context}) {
//   return GestureDetector(
//     onTap: (){
//
//       navigateTo(context, FoodDetail(
//         imagePath:imagePath ,
//           itemPrice: 0,
//         itemName: '',
//         subCategoryTitle: '',
//       )
//       );
//     },
//     child: Container(
//       margin: const EdgeInsets.only(right: 25, left: 20, top: 25),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: const [
//           BoxShadow(blurRadius: 10, color: Constants.lighterGray)
//         ],
//         color: Constants.white,
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(top: 25, left: 20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: const [
//                         Icon(
//                           Icons.star,
//                           color: Constants.primary,
//                           size: 20,
//                         ),
//                         SizedBox(width: 10),
//                         PrimaryText(
//                           text: 'top of the week',
//                           size: 16,
//                         )
//                       ],
//                     ),
//                     const SizedBox(height: 15),
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width / 2.2,
//                       child: PrimaryText(
//                           text: name, size: 22, fontWeight: FontWeight.w700),
//                     ),
//                     PrimaryText(
//                         text: weight, size: 18, color: Constants.lightGray),
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Row(
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 45, vertical: 20),
//                     decoration: const BoxDecoration(
//                         color: Constants.primary,
//                         borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(20),
//                           topRight: Radius.circular(20),
//                         )),
//                     child: const Icon(Icons.add, size: 20),
//                   ),
//                   const SizedBox(width: 20),
//                   SizedBox(
//                     child: Row(
//                       children: [
//                         const Icon(Icons.star, size: 12),
//                         const SizedBox(width: 5),
//                         PrimaryText(
//                           text: star,
//                           size: 18,
//                           fontWeight: FontWeight.w600,
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           Container(
//             transform: Matrix4.translationValues(30.0, 25.0, 0.0),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(50),
//                 boxShadow: [
//                   BoxShadow(color: Colors.grey[400], blurRadius: 20)
//                 ]),
//             child: Hero(
//               tag: imagePath,
//               child: Image.asset(imagePath,
//                   width: MediaQuery.of(context).size.width / 2.9),
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
}
