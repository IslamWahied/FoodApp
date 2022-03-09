// @dart=2.9
import 'package:badges/badges.dart';
import 'package:elomda/bloc/home_bloc/HomeCubit.dart';
import 'package:elomda/bloc/home_bloc/HomeState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (BuildContext context) {
          HomeCubit.get(context).getCategory();
          HomeCubit.get(context).getSubCategory();
          HomeCubit.get(context).getItems();
          HomeCubit.get(context).getAdditions();
          HomeCubit.get(context).getFavourite();
          HomeCubit.get(context).getOrders();

          return BlocConsumer<HomeCubit, HomeScreenState>(
            listener: (BuildContext context, HomeScreenState state) {},
            builder: (BuildContext context, HomeScreenState state) {
              var cubit = HomeCubit.get(context);
              return Scaffold(
                extendBody: true,
                body: cubit.screens[cubit.currentIndex],
                bottomNavigationBar: BottomAppBar(

                  shape: const CircularNotchedRectangle(),
                  notchMargin: 0.01,
                  clipBehavior: Clip.antiAlias,
                  child: SizedBox(
                    height: kBottomNavigationBarHeight * 0.98,
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          border: Border(
                              top: BorderSide(
                                color: Colors.grey,
                                width: 0.5,
                              ))),
                      child: BottomNavigationBar(
                        // enableFeedback: false,
                        type: BottomNavigationBarType.fixed,
                        onTap: (value) {
                          cubit.changeCurrentIndex(value);
                        },
                        backgroundColor: Theme
                            .of(context)
                            .primaryColor,
                        unselectedItemColor: Colors.grey,
                        selectedItemColor: Colors.deepOrange,
                        currentIndex: cubit.currentIndex,
                        items: [
                          const BottomNavigationBarItem(
                            icon: Icon(Icons.home),
                            label: 'Home',
                          ),
                          const BottomNavigationBarItem(
                            icon: Icon(Icons.favorite),
                            label: 'Favorite',
                          ),
                          const BottomNavigationBarItem(
                            activeIcon: null,
                            icon: Icon(null),
                            label: 'Search',
                          ),
                          BottomNavigationBarItem(
                            icon: Badge(
                              showBadge: HomeCubit
                                  .get(context)
                                  .listOrder
                                  .isNotEmpty && HomeCubit
                                  .get(context)
                                  .listOrder
                                  .length != null,
                              badgeContent: Text(HomeCubit
                                  .get(context)
                                  .listOrder
                                  .length
                                  .toString() ?? '0', style: const TextStyle(
                                  color: Colors.white, fontSize: 11),),
                              child: const Icon(
                                Icons.shopping_bag,
                              ),
                            ),
                            label: 'Cart',

                          ),
                          const BottomNavigationBarItem(
                            icon: Icon(Icons.person),
                            label: 'User',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                floatingActionButtonLocation:
                FloatingActionButtonLocation.miniCenterDocked,
                floatingActionButton: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: CircleAvatar(
                    radius: 32,
                    backgroundColor: const Color(0xfffcfcff),
                    child: FloatingActionButton(
                      backgroundColor: Colors.deepOrange,
                      onPressed: () {
                        cubit.changeCurrentIndex(1);
                      },
                      child: const Icon(Icons.search_outlined),
                      hoverElevation: 10,
                      elevation: 4,
                    ),
                  ),
                ),
              );
            },
          );
        });
  }
}