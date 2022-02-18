// @dart=2.9

// ignore_for_file: missing_required_param

import 'package:carousel_slider/carousel_slider.dart';
import 'package:elomda/bloc/home_bloc/HomeCubit.dart';
import 'package:elomda/bloc/home_bloc/HomeState.dart';
import 'package:elomda/bloc/login_bloc/loginCubit.dart';
import 'package:elomda/bloc/login_bloc/loginState.dart';
import 'package:elomda/styles/colors.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeScreenState>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          backgroundColor: Constants.lightBG,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30.0),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      const Text(
                        'Dishes',
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 20),
                      ),
                      const Spacer(),
                      MaterialButton(
                        onPressed: () {},
                        child: const Text(
                          'View all...',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                              color: Colors.red),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 210,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Swiper(
                      itemCount: cubit.carouselImage.length,
                      autoplay: false,
                      // viewportFraction: 0.8,
                      scale: 0.5,
                      onTap: (index) {},
                      itemBuilder: (BuildContext ctx, int index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            color: Colors.blueGrey,
                            child: Image.asset(
                              cubit.carouselImage[index],
                              fit: BoxFit.fill,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // child: Swiper(
                  //   itemCount: cubit.brandImages.length,
                  //   autoplay: true,
                  //   viewportFraction: 0.8,
                  //   scale: 0.9,
                  //   onTap: (index) {
                  //     cubit.brand = 'All';
                  //     cubit.getPrandFeed();
                  //     navigateTo(context, BrandsNavigationRail());
                  //   },
                  //   itemBuilder: (BuildContext ctx, int index) {
                  //     return ClipRRect(
                  //       borderRadius: BorderRadius.circular(10),
                  //       child: Container(
                  //         color: Colors.blueGrey,
                  //         child: Image.asset(
                  //           cubit.brandImages[index],
                  //           fit: BoxFit.fill,
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // ),
                ),
                const SizedBox(height: 20.0),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Food Categories",
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
              ],
            ),
          ),
        );
      },
    );
  }
}
