// @dart=2.9
import 'package:elomda/bloc/home_bloc/HomeCubit.dart';
import 'package:elomda/bloc/home_bloc/HomeState.dart';
import 'package:elomda/models/category/itemModel.dart';
import 'package:elomda/modules/customer/popularFood/ItemDetailScreen.dart';
import 'package:elomda/shared/components/Componant.dart';
import 'package:elomda/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

Widget itemCard(
    {
      ItemModel itemModel,
      context,
      isFavourite
    }) {
  int value = 1;
  return BlocConsumer<HomeCubit, HomeState>(
    listener: (context, state) => {},
    builder: (context, state) {
      var cubit = HomeCubit.get(context);

      return StatefulBuilder(builder: (context, setState) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: () {
              cubit.selectedItemId =itemModel. itemId;
              cubit.selectedCategoryId = itemModel.categoryId;
              cubit.selectedSubCategoryId = itemModel.supCategoryId;

              navigateTo(
                  context,
                  ItemDetailScreen(
                  orderCount: value ?? 1,
                  itemModel: itemModel,
                  ));
            },
            child: Container(
              margin: const EdgeInsets.only(
                  right: 15, left: 0, top: 25, bottom: 10),
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
                                const Icon(
                                  Icons.star,
                                  color: Constants.primary,
                                  size: 20,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      cubit
                                          .changeItemFavouriteState(
                                          itemModel: itemModel,
                                          isFavourite: isFavourite);
                                    },
                                    child: isFavourite
                                        ? const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                      size: 25,
                                    )
                                        : const Icon(Icons.favorite_border,
                                        size: 25)),
                                const SizedBox(width: 10),
                                SizedBox(
                                  // width: MediaQuery.of(context).size.width / 2.2,
                                  height: 33,
                                  child: PrimaryText(
                                      text: itemModel.itemTitle,
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
                        height: 65,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {

                              cubit.addItemToCart(
                                  itemModel: itemModel,
                                  context: context,
                                  isFavourit: isFavourite,
                                  orderCount: value
                              );
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
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    if (itemModel.isDiscount)
                                      PrimaryText(
                                        isDiscount: true,
                                        text: itemModel
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
                                      text:itemModel.price.toString(),
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
                                          backgroundColor: Colors.blueAccent
                                              .withOpacity(0.9),
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
                    transform: Matrix4.translationValues(0.0, 10.0, 40.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1),
                        boxShadow: [
                          BoxShadow(color: Colors.grey[400], blurRadius: 20)
                        ]),
                    child: Hero(
                      tag:itemModel.image,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: CircleAvatar(
                          radius: 50,
                         backgroundImage:  NetworkImage(itemModel.image)


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
    },
  );
}

// Widget itemCard(
// {
//       ItemModel itemModel,
//       context,
//       isFavourite
//     }) {
//   return GestureDetector(
//     onTap: () => {
//       Navigator.push(context,
//           MaterialPageRoute(builder: (context) => FoodDetail(imagePath: itemModel.image)))
//     },
//     child: Container(
//       margin: EdgeInsets.only(right: 25, left: 20, top: 25),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [BoxShadow(blurRadius: 10, color: AppColors.lighterGray)],
//         color: AppColors.white,
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(top: 25, left: 20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Icon(
//                           Icons.star,
//                           color: AppColors.primary,
//                           size: 20,
//                         ),
//                         SizedBox(width: 10),
//                         PrimaryText(
//                           text: 'top of the week',
//                           size: 16,
//                         )
//                       ],
//                     ),
//                     SizedBox(height: 15),
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width/2.2,
//                       child: PrimaryText(
//                           text:itemModel.itemTitle, size: 22, fontWeight: FontWeight.w700),
//                     ),
//                     // PrimaryText(
//                     //     text:itemModel. weight, size: 18, color: AppColors.lightGray),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Row(
//                 children: [
//                   Container(
//                     padding:
//                     EdgeInsets.symmetric(horizontal: 45, vertical: 20),
//                     decoration: const BoxDecoration(
//                         color: AppColors.primary,
//                         borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(20),
//                           topRight: Radius.circular(20),
//                         )),
//                     child: Icon(Icons.add, size: 20),
//                   ),
//                   SizedBox(width: 20),
//                   SizedBox(
//                     child: Row(
//                       children: const [
//                         Icon(Icons.star, size: 12),
//                         SizedBox(width: 5),
//                         PrimaryText(
//                           text: '2',
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
//
//         ],
//       ),
//     ),
//   );
// }