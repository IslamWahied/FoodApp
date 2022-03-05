//@dart=2.9
import 'package:badges/badges.dart';
import 'package:elomda/bloc/home_bloc/HomeCubit.dart';
import 'package:elomda/bloc/home_bloc/HomeState.dart';
import 'package:elomda/modules/product_details/foodDetail.dart';
import 'package:elomda/shared/components/Componant.dart';
import 'package:elomda/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class subCategoryScreen extends StatelessWidget {
  final String categoryTitle;
  const subCategoryScreen({Key key,this.categoryTitle}) : super(key: key);

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
          // actions: [
          //   Padding(
          //     padding: const EdgeInsets.only(right: 20,top: 15),
          //     child:   Badge(
          //         badgeContent: Text(cubit.listOrder.length.toString()??'0',style: const TextStyle(color: Colors.white,fontSize: 11),),
          //         child: Image.asset('assets/shoppingcart.png',width: 30)),
          //   ),
          // ],
          iconTheme: const IconThemeData(
              color: Constants.black
          ),

          title:customAppBar(context: context,title: categoryTitle,) ,
        ),
      backgroundColor:Constants.white,
        body: SafeArea(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     customAppBar2(context),
              //     Text(categoryTitle??'',style: const TextStyle( fontSize: 25,
              //         fontWeight: FontWeight.w600,color: AppColors.black,overflow: TextOverflow.ellipsis),),
              //     SizedBox(width: MediaQuery.of(context).size.width * 0.15),
              //   ],
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 20, right: 20, top: 25),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       PrimaryText(
              //         text: '$SubCategoryScreen',
              //         size: 45,
              //         fontWeight: FontWeight.w600,
              //       ),
              //       const SizedBox(height: 30),
              //       Row(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           SvgPicture.asset(
              //             'assets/dollar.svg',
              //             color: Constants.tertiary,
              //             width: 15,
              //           ),
              //           PrimaryText(
              //             text: itemPrice.toString() ,
              //             size: 48,
              //             fontWeight: FontWeight.w700,
              //             color: Constants.tertiary,
              //             height: 1,
              //           ),
              //         ],
              //       ),
              //       const SizedBox(
              //         height: 40,
              //       ),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           SizedBox(
              //             child: Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: const [
              //                   PrimaryText(
              //                     text: 'Size',
              //                     color: Constants.lightGray,
              //                     size: 16,
              //                     fontWeight: FontWeight.w500,
              //                   ),
              //                   SizedBox(
              //                     height: 8,
              //                   ),
              //                   PrimaryText(
              //                       text: 'Medium 14"',
              //                       fontWeight: FontWeight.w600),
              //                   SizedBox(
              //                     height: 20,
              //                   ),
              //                   PrimaryText(
              //                     text: 'Crust',
              //                     color: Constants.lightGray,
              //                     size: 16,
              //                     fontWeight: FontWeight.w500,
              //                   ),
              //                   SizedBox(
              //                     height: 8,
              //                   ),
              //                   PrimaryText(
              //                       text: 'Thin Crust',
              //                       fontWeight: FontWeight.w600),
              //                   SizedBox(
              //                     height: 20,
              //                   ),
              //                   PrimaryText(
              //                     text: 'Delivery in',
              //                     color: Constants.lightGray,
              //                     size: 16,
              //                     fontWeight: FontWeight.w500,
              //                   ),
              //                   SizedBox(
              //                     height: 8,
              //                   ),
              //                   PrimaryText(
              //                       text: '30 min',
              //                       fontWeight: FontWeight.w600),
              //                 ]),
              //           ),
              //           Hero(
              //             tag: imagePath,
              //             child: Container(
              //               decoration: BoxDecoration(
              //                 boxShadow: [
              //                   BoxShadow(
              //                       color: Colors.grey[400], blurRadius: 30),
              //                 ],
              //                 borderRadius: BorderRadius.circular(100),
              //               ),
              //               height: 200,
              //               width: 210,
              //               child: Image.network(imagePath, fit: BoxFit.cover),
              //             ),
              //           ),
              //         ],
              //       ),
              //       const SizedBox(
              //         height: 50,
              //       ),
              //       const PrimaryText(
              //           text: 'Ingredients',
              //           fontWeight: FontWeight.w700,
              //           size: 22),
              //       const SizedBox(
              //         height: 15,
              //       ),
              //     ],
              //   ),
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
                        controller: cubit.txtSubCategoryControl,
                        onChanged: (String value){
                        cubit.searchInSupCategory(value);
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
              GridView.count(
                shrinkWrap: true,

                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 1 / 1.58,
                padding: const EdgeInsets.only(left: 15),

                children: List.generate(
                  cubit.listSubCategorySearch.length,
                      (index) =>
                    foodSubCategoryCard(
                        imagePath: cubit.listSubCategorySearch[index].image,
                        name: cubit.listSubCategorySearch[index].subCategoryTitle,
                        supCategoryId: cubit.listSubCategorySearch[index].supCategoryId,
                        context: context
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
Widget foodSubCategoryCard({String imagePath, String name, int supCategoryId, context}) {

  return BlocConsumer<HomeCubit,HomeScreenState>(
    listener: (context,state)=>{},
    builder: (context,state){
      var cubit = HomeCubit.get(context);
      return  GestureDetector(
        onTap: (){


           cubit.selectSubCategory(supCategoryId:supCategoryId,context:context);

        },
        child: Container(
          margin: const EdgeInsets.only(right: 20, top: 20, bottom: 20),
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: HomeCubit.get(context).selectedSubCategoryId == supCategoryId
                  ? Constants.primary
                  : Constants.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 15,
                )
              ]
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              // SvgPicture.asset(imagePath, width: 40),
              Image.network(imagePath,width: 150,height: 130),
              const SizedBox(height: 5,),
              PrimaryText(text: name, fontWeight: FontWeight.w800, size: 16),
              RawMaterialButton(
                  onPressed: null,
                  fillColor: cubit.selectedSubCategoryId == supCategoryId ? Constants.white : Constants.tertiary,
                  shape: const CircleBorder(),
                  child: Icon(Icons.chevron_right_rounded,
                      size: 20,
                      color:
                      cubit.selectedSubCategoryId == supCategoryId
                          ? Constants.black
                          : Constants.white))
            ],
          ),
        ),
      );
    } ,

  );
}