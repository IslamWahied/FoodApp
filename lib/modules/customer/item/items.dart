//@dart=2.9
import 'package:elomda/bloc/home_bloc/HomeCubit.dart';
import 'package:elomda/bloc/home_bloc/HomeState.dart';
import 'package:elomda/modules/customer/product_details/foodDetail.dart';

import 'package:elomda/shared/Global.dart';

import 'package:elomda/shared/components/Componant.dart';
import 'package:elomda/styles/colors.dart';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../shared/components/Reuseable.dart';


class ItemsScreen extends StatelessWidget {
  final String subcategoryTitle;
  const ItemsScreen({this.subcategoryTitle,Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return Scaffold(
            extendBody: true,
            appBar: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              centerTitle: false,
              leadingWidth: 0,
              iconTheme: const IconThemeData(
                  color: Constants.black
              ),

              title:customAppBar(context: context,title: subcategoryTitle,isShowCarShop: true,isYellow: true) ,
            ),
            backgroundColor:Constants.white,
            body: Padding(
              padding: const EdgeInsets.all(8.0),
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
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Expanded(
                            child: TextField(
                              controller: cubit.txtItemControl,
                              onChanged: (String value){
                                  cubit.searchInItemsBySupCategory(value);
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

                            )),
                      ),

                    ],
                  ),
                  Expanded(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 1.1,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: cubit.listItemsBySubCategSearch.where((element) =>  element.categoryId == cubit.selectedCategoryId && element.supCategoryId == cubit.selectedSubCategoryId  && element.projectId == Global.projectId ).toList().length??0,
                        itemBuilder: (context, index) {
                          var itemModel =  cubit.listItemsBySubCategSearch.where((element) =>  element.categoryId == cubit.selectedCategoryId && element.supCategoryId == cubit.selectedSubCategoryId  && element.projectId == Global.projectId ).toList()[index];
                          return itemCard(

                            context: context,
                            isSearch: false,
                            itemModel: itemModel,
                            isFavourite: cubit.listFavourite.isNotEmpty && cubit.listFavourite.any((element) => element.ItemId == itemModel.itemId && element.isFavourit) ? true : false,
                          );
                        }
                      ),
                    ),
                  ),
                 Container( height: 80,color: Colors.transparent,)
                ],
              ),
            ),
          );
        });
  }
}
