// @dart=2.9
import 'package:backdrop/backdrop.dart';
import 'package:badges/badges.dart';
import 'package:elomda/bloc/home_bloc/HomeCubit.dart';
import 'package:elomda/bloc/home_bloc/HomeState.dart';
import 'package:elomda/home_layout/home_layout.dart';
import 'package:elomda/models/project/projectModel.dart';
import 'package:elomda/modules/customer/Userbacklayer.dart';
import 'package:elomda/modules/customer/home/home_screen.dart';
import 'package:elomda/shared/Global.dart';
import 'package:elomda/shared/network/local/helper.dart';
import 'package:elomda/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

class RestrantListScreen extends StatelessWidget {
  const RestrantListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      navigatorKey: HomeCubit.get(context).mAnavigatorkey,
      home: MediaQuery.removePadding(
        context: context,
        removeTop: false,
        child: BlocConsumer<HomeCubit, HomeState>(
          builder: (context, state) {
            var cubit = HomeCubit.get(context);

           return   BackdropScaffold(

             backgroundColor: Colors.transparent,
             onBackLayerConcealed: () {
               cubit.isShowBackLayer = true;
               cubit.emit(SelectCategoryState());
             },
             onBackLayerRevealed: () {
               cubit.isShowBackLayer = false;
               cubit.emit(SelectCategoryState());
             },
             frontLayerBackgroundColor: Constants.white,
             headerHeight: MediaQuery.of(context).size.height * 0.35,
             appBar: BackdropAppBar(
               title: Text(cubit.selectedTab),
               leading: const BackdropToggleButton(
                 icon: AnimatedIcons.home_menu,
                 color: Colors.deepOrange,
               ),
               flexibleSpace: Container(
                 decoration:   BoxDecoration(
                   color: Colors.black.withOpacity(0.8),
                 ),
               ),
               actions: [
                 cubit.isShowBackLayer
                     ? Row(
                   children: [
                     GestureDetector(
                       onTap: () {
                         cubit.isShowBackLayer = false;
                         NavigatToAndReplace(
                             context, const HomeLayout());
                         cubit.changeCurrentIndex(3);
                       },
                       child: Badge(
                           badgeContent: Text(
                             cubit.listOrder.length.toString() ??
                                 '0',
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
                           NavigatToAndReplace(
                               context, const HomeLayout());
                           cubit.changeCurrentIndex(4);
                         },
                         padding: const EdgeInsets.all(10),
                         icon: CircleAvatar(
                           radius: 15,
                           backgroundColor: Colors.white,
                           child: Global.imageUrl != null &&
                               Global.imageUrl.trim() != ''
                               ? CircleAvatar(
                             radius: 30.0,
                             backgroundImage:
                             NetworkImage(Global.imageUrl),
                             backgroundColor:
                             Colors.transparent,
                           )
                               : const CircleAvatar(
                             radius: 13,
                             backgroundImage: AssetImage(
                                 'assets/person.jpg'),
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
             frontLayer: Conditional.single(context: context,
               conditionBuilder: (BuildContext context) => cubit.listProject.where((element) => element.isActive).isNotEmpty,
               widgetBuilder: (BuildContext context) {
                 return Container(
                   decoration: const BoxDecoration(
                     image: DecorationImage(
                       image: AssetImage("assets/foodBackGround.jpg"),
                       fit: BoxFit.cover,
                     ),
                   ),
                   child: Column(
                     children: [
                       const SizedBox(
                         height: 30,
                       ),
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: GridView.count(
                           shrinkWrap: true,
                           physics: const NeverScrollableScrollPhysics(),
                           crossAxisCount: 2,
                           mainAxisSpacing: 1.0,
                           crossAxisSpacing: 1.0,
                           childAspectRatio: 1 / 1.3,
                           children: List.generate(
                             cubit.listProject
                                 .where((element) => element.isActive)
                                 .length,
                                 (index) => buildGridProjects(
                                 cubit.listProject
                                     .where((element) => element.isActive)
                                     .toList()[index],
                                 context),
                           ),
                         ),
                       ),
                     ],
                   ),
                 );
               },
               fallbackBuilder: (BuildContext context) => const Center(
                   child: Text(
                     'لا يوجد مطاعم حاليا',
                     style: TextStyle(color: Colors.red, fontSize: 18),
                   )),
             ),
           );



          },
          listener: (context, state) => {},
        ),
      ),
    );
  }
}

Widget buildGridProjects(Project model, context) => GestureDetector(
      onTap: () {
        Global.projectId = model.id;

        Navigator.of(HomeCubit.get(context).mAnavigatorkey.currentContext).push(
            MaterialPageRoute(
                builder: (BuildContext context) => const HomeScreen()));

        // navigatTo(context, const HomeScreen());
      },
      child: SizedBox(
        height: 174,
        child: Stack(
          children: <Widget>[
            Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 335,
                    height: 180,
                    child: Image.network(
                      model.image,
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
            Positioned(
              right: 20,
              bottom: 20,
              left: 75,
              child: Text(model.name),
            )
          ],
        ),
      ),
    );
