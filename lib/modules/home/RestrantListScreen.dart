// @dart=2.9
import 'package:backdrop/backdrop.dart';
import 'package:elomda/bloc/home_bloc/HomeCubit.dart';
import 'package:elomda/bloc/home_bloc/HomeState.dart';
import 'package:elomda/models/project/projectModel.dart';
import 'package:elomda/modules/home/Userbacklayer.dart';
import 'package:elomda/modules/home/home_screen.dart';
import 'package:elomda/modules/user_info/user_info_screen.dart';
import 'package:elomda/shared/Global.dart';
import 'package:elomda/shared/components/componant.dart';
import 'package:elomda/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

 



class RestrantListScreen extends StatelessWidget {
  const RestrantListScreen({Key  key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: HomeCubit.get(context).mAnavigatorkey,
      home:
      MediaQuery.removePadding(
        context: context,
        removeTop: false,

          child: BlocConsumer<HomeCubit, HomeScreenState>(
          builder: (context, state) {
            var cubit = HomeCubit.get(context);

            return Scaffold(

              body: Center(
                child: BackdropScaffold(
                  onBackLayerConcealed: (){
                    cubit.isShowBackLayer = true;
                    cubit.emit(SelectCategoryState());
                  },
                  onBackLayerRevealed: (){
                    cubit.isShowBackLayer = false;
                    cubit.emit(SelectCategoryState());
                  },

                  frontLayerBackgroundColor: Constants.white,
                  headerHeight: MediaQuery.of(context).size.height * 0.35,
                  appBar: BackdropAppBar(
                    title:   Text(cubit.selectedTab),
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
                      cubit.isShowBackLayer?       IconButton(
                          onPressed: () {
                            navigateTo(context, User_Info());
                          },
                          padding:   const EdgeInsets.all(10),
                          icon:   CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.white,
                            child: Global.imageUrl != null &&Global.imageUrl.trim()  != ''?
                            SizedBox(
                              height: 50,
                              width: 50,
                              child: FadeInImage(
                                  height: 50,
                                  width: 50,
                                  fadeInDuration: const Duration(milliseconds: 500),
                                  fadeInCurve: Curves.easeInExpo,
                                  fadeOutCurve: Curves.easeOutExpo,
                                  placeholder: const AssetImage("assets/person.jpg"),
                                  image: NetworkImage(Global.imageUrl
                                  ),
                                  imageErrorBuilder: (context, error, stackTrace) {
                                    return const CircleAvatar(
                                      radius: 13,
                                      backgroundImage: AssetImage('assets/person.jpg'),

                                    );
                                  },
                                  fit: BoxFit.cover),
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
                    conditionBuilder: (BuildContext context) => cubit.listProject.where((element) => element.isActive).isNotEmpty,
                    widgetBuilder: (BuildContext context) {
                      return  Column(
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
                               cubit.listProject.where((element) => element.isActive).length,
                                    (index) => buildGridProjects( cubit.listProject.where((element) => element.isActive).toList()[index],
                                        context),
                              ),
                            ),
                          ),
                        ],
                      );
                    },

                    fallbackBuilder: (BuildContext context) => const Center(child: Text('لا يوجد مطاعم حاليا',style: TextStyle(color: Colors.red,fontSize: 18),)),
                  ),
                ),
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
  onTap: (){
    Global.projectId = model.id;

    Navigator.of(HomeCubit.get(context).mAnavigatorkey.currentContext)
        .push(MaterialPageRoute(
        builder: (BuildContext context) =>
            const HomeScreen()));

    // navigatTo(context, const HomeScreen());
  },
  child:   SizedBox(



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

          child:Text(model.name),

        )

      ],

    ),

  ),
);

