//@dart=2.9
import 'package:elomda/bloc/home_bloc/HomeCubit.dart';
import 'package:elomda/bloc/home_bloc/HomeState.dart';
import 'package:elomda/modules/product_details/foodDetail.dart';
import 'package:elomda/modules/upload_products/upload_products.dart';
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

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // customAppBar2(context),

                      SizedBox(width: MediaQuery.of(context).size.width * 0.15),
                    ],
                  ),

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
                    
                      width: 350,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: cubit.listItemsSearch.length??0,
                        itemBuilder: (context, index) => itemCard(
                          itemId:cubit.listItemsSearch[index].itemId ,
                            itemPrice:cubit.listItemsSearch[index].price ,
                          subCategoryTitle: cubit.listItemsSearch[index].supCategoryTitle,
                            name:cubit.listItemsSearch[index].itemTitle,
                            context: context,
                            imagePath:  cubit.listItemsSearch[index].image,
                            itemsPrice:  cubit.listItemsSearch[index].price,
                            star: '',
                            itemDescription: cubit.listItemsSearch[index].description??''


                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
Widget itemCard({int itemId,String imagePath,String subCategoryTitle,double itemPrice ,String name, String itemDescription, String star, context,double itemsPrice}) {
  return GestureDetector(
    onTap: (){
HomeCubit.get(context).selectedItemId = itemId;

        navigateTo(context, FoodDetail(
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
                      children:  [
                        const Icon(
                          Icons.star,
                          color: Constants.primary,
                          size: 20,
                        ),
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
                children: [
                  GestureDetector(
                    onTap: (){
                      HomeCubit.get(context).listOrder.add(HomeCubit.get(context).listItemsSearch.firstWhere((element) => element.itemId == itemId));
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
                  const SizedBox(width: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
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
                  // SizedBox(
                  //   child: Row(
                  //     children: [
                  //       const Icon(Icons.star, size: 12),
                  //       const SizedBox(width: 5),
                  //       PrimaryText(
                  //         text: star,
                  //         size: 18,
                  //         fontWeight: FontWeight.w600,
                  //       )
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
          Container(
            height: 100,
            width: 150,
            transform: Matrix4.translationValues(50.0, 0.0, 0.0,),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(color: Colors.grey[400], blurRadius: 20)
                ]),
            child: Hero(
              tag: imagePath,
              child: Image.network(imagePath, width: MediaQuery.of(context).size.width / 2.9),
            ),
          ),
        ],
      ),
    ),
  );
}