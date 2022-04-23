// @dart=2.9
import 'package:backdrop/backdrop.dart';
import 'package:badges/badges.dart';
import 'package:elomda/bloc/home_bloc/HomeCubit.dart';
import 'package:elomda/bloc/home_bloc/HomeState.dart';
import 'package:elomda/home_layout/home_layout.dart';

import 'package:elomda/modules/customer/Userbacklayer.dart';

import 'package:elomda/shared/Global.dart';
import 'package:elomda/shared/components/Componant.dart';
import 'package:elomda/shared/network/local/helper.dart';
import 'package:elomda/styles/colors.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/components/Reuseable.dart';




class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) => () {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return BackdropScaffold(

          onBackLayerConcealed: () {
            cubit.isShowBackLayer = true;
            cubit.emit(SelectCategoryState());
          },
          onBackLayerRevealed: () {
            cubit.isShowBackLayer = false;
            cubit.emit(SelectCategoryState());
          },
          frontLayerBackgroundColor: Constants.lighterGray,
          headerHeight: MediaQuery.of(context).size.height * 0.35,
          appBar: BackdropAppBar(

            title: Text(cubit.selectedTab),
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
              cubit.isShowBackLayer
                  ? Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            cubit.isShowBackLayer = false;
                            NavigatToAndReplace(context, const HomeLayout());
                            cubit.changeCurrentIndex(3);
                          },
                          child: Badge(
                              badgeContent: Text(
                                cubit.listOrder.length.toString() ?? '0',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 11),
                              ),
                              child: Image.asset(
                                'assets/shoppingcart.png',
                                width: 22,
                                color: Colors.white,
                              )),
                        ),
                        const SizedBox(width: 20),
                        IconButton(
                            onPressed: () {
                              cubit.isShowBackLayer = false;
                              NavigatToAndReplace(context, const HomeLayout());
                              cubit.changeCurrentIndex(4);
                            },
                            padding: const EdgeInsets.all(10),
                            icon: CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.white,
                              child: Global.imageUrl != null
                                  ? CircleAvatar(
                                      radius: 30.0,
                                      backgroundImage:
                                          NetworkImage(Global.imageUrl),
                                      backgroundColor: Colors.transparent,
                                    )
                                  : const CircleAvatar(
                                      radius: 13,
                                      backgroundImage:
                                          AssetImage('assets/person.jpg'),
                                    ),
                            )),
                      ],
                    )
                  : const SizedBox(
                      width: 1,
                    )
            ],
          ),
          backLayer: UserBackLayerMenu(),
          frontLayer: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                    const PrimaryText(
                      text: 'رجوع',
                      size: 22,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // const Padding(
                    //   padding: EdgeInsets.only(left: 20),
                    //   child: PrimaryText(
                    //     text: 'Food',
                    //     size: 22,
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: PrimaryText(
                        text: cubit.listProject
                                .firstWhere(
                                    (element) => element.id == Global.projectId)
                                .name ??
                            '',
                        height: 1.1,
                        size: 42,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: PrimaryText(
                              text: 'الاقسام',
                              fontWeight: FontWeight.w700,
                              size: 22),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      height: 250,
                      child: ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(width: 10) ,
                        scrollDirection: Axis.horizontal,
                        itemCount: cubit.listCategory
                                .where((element) =>
                                    element.projectId == Global.projectId)
                                .length ??
                            0,
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.only(left: index == 0 ? 25 : 0),
                          child: foodCategoryCard(
                              cubit.listCategory
                                  .where((element) =>
                                      element.projectId == Global.projectId)
                                  .toList()[index]
                                  .image,
                              cubit.listCategory
                                  .where((element) =>
                                      element.projectId == Global.projectId)
                                  .toList()[index]
                                  .categoryTitle,
                              cubit.listCategory
                                  .where((element) =>
                                      element.projectId == Global.projectId)
                                  .toList()[index]
                                  .categoryId,
                              context),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(right: 20, top: 10),
                          child: PrimaryText(
                              text: 'الاكثر طالبا',
                              fontWeight: FontWeight.w700,
                              size: 22),
                        ),
                      ],
                    ),
                    Column(
                      children: List.generate(
                        cubit.popularList
                            .where((element) =>
                                element.projectId == Global.projectId)
                            .toList()
                            .length,
                        (index) {
                     var popularModel  =   cubit.popularList.where((element) => element.projectId == Global.projectId).toList()[index];
                        return    itemCard(
                           
                          isFavourite: cubit.listFavourite.isNotEmpty && cubit.listFavourite.any((element) => element.ItemId == popularModel.itemId && element.isFavourit) ? true : false,
                          
                          context: context,
                          itemModel: popularModel
                          
                          
                        );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 150,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget foodCategoryCard(
      String imagePath, String name, int categoryId, context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) => {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return GestureDetector(
          onTap: () {
            cubit.selectCategory(categoryId, context);
          },
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Card(
                color: HomeCubit.get(context).selectedCategoryId == categoryId ? Constants.primary : Constants.white,
                clipBehavior: Clip.antiAliasWithSaveLayer,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 150,
                      height: 150,
                      child: Image.network(
                        imagePath,
                        fit: BoxFit.cover,

                      ),
                    ),
                  ],
                ),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),

                elevation: 5,

                // margin: const EdgeInsets.all(10),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

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
                                        : Constants.white)),
                  ],
                ),
              ),

            ],
          )


          // Container(
          //   margin: const EdgeInsets.only(right: 20, top: 20, bottom: 20),
          //   padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
          //   decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(20),
          //       color: HomeCubit.get(context).selectedCategoryId == categoryId
          //           ? Constants.primary
          //           : Constants.white,
          //       boxShadow: const [
          //         BoxShadow(
          //           color: Colors.grey,
          //           blurRadius: 15,
          //         )
          //       ]),
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       // SvgPicture.asset(imagePath, width: 40),
          //       Image.network(imagePath, width: 90, height: 80,fit: BoxFit.cover,),
          //       PrimaryText(text: name, fontWeight: FontWeight.w800, size: 16),
          //       RawMaterialButton(
          //           onPressed: null,
          //           fillColor: cubit.selectedCategoryId == categoryId
          //               ? Constants.white
          //               : Constants.tertiary,
          //           shape: const CircleBorder(),
          //           child: Icon(Icons.chevron_right_rounded,
          //               size: 20,
          //               color: HomeCubit.get(context).selectedCategoryId ==
          //                       categoryId
          //                   ? Constants.black
          //                   : Constants.white))
          //     ],
          //   ),
          // ),
        );
      },
    );
  }

 
}
