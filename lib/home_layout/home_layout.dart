
// @dart=2.9
import 'package:elomda/bloc/home_bloc/HomeCubit.dart';
import 'package:elomda/bloc/home_layout_bloc/cubit.dart';
import 'package:elomda/bloc/home_layout_bloc/state.dart';
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

          return BlocConsumer<HomeLayoutCubit, HomeLayoutState>(
            listener: (BuildContext context, HomeLayoutState state) {},
            builder: (BuildContext context, HomeLayoutState state) {
              var cubit = HomeLayoutCubit.get(context);
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
                        onTap: (value) {
                          cubit.changeCurrentIndex(value);
                        },
                        backgroundColor: Theme
                            .of(context)
                            .primaryColor,
                        unselectedItemColor: Colors.grey,
                        selectedItemColor: Colors.deepOrange,
                        currentIndex: cubit.currentIndex,
                        items: const [
                          BottomNavigationBarItem(
                            icon: Icon(Icons.home),
                            label: 'Home',
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.rss_feed),
                            label: 'Feeds',
                          ),
                          BottomNavigationBarItem(
                            activeIcon: null,
                            icon: Icon(null),
                            label: 'Search',
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(
                              Icons.shopping_bag,
                            ),
                            label: 'Cart',
                          ),
                          BottomNavigationBarItem(
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
                  padding: const EdgeInsets.all(8.0),
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
              );
            },
          );
        });
  }
}