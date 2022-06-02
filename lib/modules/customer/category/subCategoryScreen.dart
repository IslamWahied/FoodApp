//@dart=2.9

import 'package:elomda/bloc/home_bloc/HomeCubit.dart';
import 'package:elomda/bloc/home_bloc/HomeState.dart';
import 'package:elomda/modules/customer/product_details/foodDetail.dart';

import 'package:elomda/shared/Global.dart';
import 'package:elomda/shared/components/Componant.dart';
import 'package:elomda/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubCategoryScreen extends StatelessWidget {
  final String categoryTitle;
  const SubCategoryScreen({Key key,this.categoryTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<HomeCubit, HomeState>(
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

          title:customAppBar(context: context,title: categoryTitle,isShowCarShop: true,isYellow: true) ,
        ),
      backgroundColor:Constants.white,
        body: SafeArea(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [



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
                      child: Directionality(
                        textDirection:TextDirection.rtl ,
                        child: TextField(
                          controller: cubit.txtSubCategoryControl,
                          onChanged: (String value){
                          cubit.searchInSupCategory(value);
                          },
                          decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2, color: AppColors.lighterGray)),
                            hintText: 'بحث...',
                            hintStyle: TextStyle(
                                color: AppColors.lightGray,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),

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
                  cubit.listSubCategorySearch.where((element) =>   element.projectId == Global.projectId).toList().length,
                      (index) =>
                    foodSubCategoryCard(
                        imagePath: cubit.listSubCategorySearch.where((element) =>   element.projectId == Global.projectId).toList()[index].image,
                        name: cubit.listSubCategorySearch.where((element) =>   element.projectId == Global.projectId).toList()[index].subCategoryTitle,
                        supCategoryId: cubit.listSubCategorySearch.where((element) =>   element.projectId == Global.projectId).toList()[index].supCategoryId,
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

  return BlocConsumer<HomeCubit,HomeState>(
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
                  blurRadius: 10,
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