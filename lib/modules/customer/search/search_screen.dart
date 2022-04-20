// @dart=2.9


// ignore_for_file: missing_required_param

import 'package:backdrop/backdrop.dart';
import 'package:badges/badges.dart';
import 'package:elomda/bloc/home_bloc/HomeCubit.dart';
import 'package:elomda/bloc/home_bloc/HomeState.dart';

import 'package:elomda/modules/customer/Userbacklayer.dart';
import 'package:elomda/shared/Global.dart';
import 'package:elomda/shared/components/Componant.dart';
import 'package:elomda/styles/colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';



class SearchScreen extends StatelessWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context)   {
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
                      visible:cubit.listFavourite.where((element) => element.projectId == Global.projectId).toList().isNotEmpty && cubit.listFavourite.any((element) => element.isFavourit &&  element.projectId == Global.projectId) ,
                      replacement: const Expanded(child: Center(child: Text('No Favourite Data'))),
                      child: Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount:cubit.listFavourite.where((element) =>   element.projectId == Global.projectId).toList().isNotEmpty && cubit.listItems.where((element) =>   element.projectId == Global.projectId).toList().isNotEmpty && cubit.listFavourite.where((element) =>   element.projectId == Global.projectId).toList().any((element) => element.isFavourit) &&cubit.listFavourite != [] ?cubit.listFavourite.where((element) => element.isFavourit &&  element.projectId == Global.projectId).toList().length:0  ,
                              itemBuilder: (context, index) {
                                var favModel = cubit.listFavourite.where((
                                    element) => element.isFavourit &&  element.projectId == Global.projectId)
                                    .toList()[index];

                                return const Text('d');
                              }
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },

              fallbackBuilder: (BuildContext context) => const Center(child: Text('لا يوجد بيانات',style: TextStyle(color: Colors.red,fontSize: 18),)),
            ),

          );
        });
  }
}
