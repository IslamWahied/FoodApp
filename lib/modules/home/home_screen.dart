// @dart=2.9

// ignore_for_file: missing_required_param

import 'package:backdrop/backdrop.dart';

import 'package:elomda/bloc/home_bloc/HomeCubit.dart';
import 'package:elomda/bloc/home_bloc/HomeState.dart';

import 'package:elomda/modules/home/backlayer.dart';
import 'package:elomda/modules/product_details/foodDetail.dart';
import 'package:elomda/shared/components/Componant.dart';
import 'package:elomda/styles/colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeScreenState>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          backgroundColor: Constants.lightBG,
          body: Center(
            child: BackdropScaffold(
              frontLayerBackgroundColor: Constants.white,
              headerHeight: MediaQuery.of(context).size.height * 0.45,
              appBar: BackdropAppBar(
                title: const Text("Home"),
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
                      icon: const CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                            radius: 13,
                            backgroundImage: NetworkImage(
                                'https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Unknown_person.jpg/542px-Unknown_person.jpg')),
                      ))
                ],
              ),
              backLayer: BackLayerMenu(),
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
                            itemCount: cubit.foodCategoryList.length,
                            itemBuilder: (context, index) => Padding(
                              padding:
                                  EdgeInsets.only(left: index == 0 ? 25 : 0),
                              child: foodCategoryCard(
                                  cubit.foodCategoryList[index]['imagePath'],
                                  cubit.foodCategoryList[index]['name'],
                                  index,
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
                            (index) => popularFoodCard(
                                cubit.popularFoodList[index]['imagePath'],
                                cubit.popularFoodList[index]['name'],
                                cubit.popularFoodList[index]['weight'],
                                cubit.popularFoodList[index]['star'],
                                context),
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

  Widget foodCategoryCard(String imagePath, String name, int index, context) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.only(right: 20, top: 20, bottom: 20),
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: HomeCubit.get(context).selectedFoodCard == index
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
            SvgPicture.asset(imagePath, width: 40),
            PrimaryText(text: name, fontWeight: FontWeight.w800, size: 16),
            RawMaterialButton(
                onPressed: null,
                fillColor:
                HomeCubit.get(context).selectedFoodCard == index
                        ? Constants.white
                        : Constants.tertiary,
                shape: const CircleBorder(),
                child: Icon(Icons.chevron_right_rounded,
                    size: 20,
                    color:
                    HomeCubit.get(context).selectedFoodCard == index
                            ? Constants.black
                            : Constants.white))
          ],
        ),
      ),
    );
  }

  Widget popularFoodCard(
      String imagePath, String name, String weight, String star, context) {
    return GestureDetector(
      onTap: (){
        navigateTo(context, FoodDetail(imagePath));

      },
      child: Container(
        margin: const EdgeInsets.only(right: 25, left: 20, top: 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(blurRadius: 10, color: Constants.lighterGray)
          ],
          color: Constants.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                        children: const [
                          Icon(
                            Icons.star,
                            color: Constants.primary,
                            size: 20,
                          ),
                          SizedBox(width: 10),
                          PrimaryText(
                            text: 'top of the week',
                            size: 16,
                          )
                        ],
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.2,
                        child: PrimaryText(
                            text: name, size: 22, fontWeight: FontWeight.w700),
                      ),
                      PrimaryText(
                          text: weight, size: 18, color: Constants.lightGray),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
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
                    const SizedBox(width: 20),
                    SizedBox(
                      child: Row(
                        children: [
                          const Icon(Icons.star, size: 12),
                          const SizedBox(width: 5),
                          PrimaryText(
                            text: star,
                            size: 18,
                            fontWeight: FontWeight.w600,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              transform: Matrix4.translationValues(30.0, 25.0, 0.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(color: Colors.grey[400], blurRadius: 20)
                  ]),
              child: Hero(
                tag: imagePath,
                child: Image.asset(imagePath,
                    width: MediaQuery.of(context).size.width / 2.9),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
