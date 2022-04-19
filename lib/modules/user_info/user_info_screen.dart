// @dart=2.9
import 'package:elomda/bloc/home_bloc/HomeCubit.dart';
import 'package:elomda/bloc/home_bloc/HomeState.dart';
import 'package:elomda/bloc/register_Bloc/registerBloc.dart';
import 'package:elomda/home_layout/home_layout.dart';
import 'package:elomda/modules/cart/cart_screen.dart';
import 'package:elomda/modules/favourite/feeds_screen.dart';
import 'package:elomda/modules/login/login_screen.dart';
import 'package:elomda/shared/Global.dart';
import 'package:elomda/shared/components/Componant.dart';
import 'package:elomda/shared/network/local/helper.dart';
import 'package:elomda/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:list_tile_switch/list_tile_switch.dart';

class User_Info extends StatelessWidget {
  ScrollController scrollController;
  var top = 0.0;

  User_Info({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeScreenState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return SafeArea(
          child: Scaffold(
            backgroundColor: Constants.lightBG,
            body: Stack(
              children: [
                CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    SliverAppBar(
                      // leading: Icon(Icons.ac_unit_outlined),
                      automaticallyImplyLeading: false,
                      expandedHeight: 200,
                      centerTitle: true,

                      elevation: 0,
                      pinned: true,
                      flexibleSpace: LayoutBuilder(builder:
                          (BuildContext context, BoxConstraints constraints) {
                        top = constraints.biggest.height;

                        return Stack(
                          children: [

                            Container(
                              decoration: const BoxDecoration(color: Colors.black),
                              child: FlexibleSpaceBar(
                                centerTitle: true,
                                title: AnimatedOpacity(
                                  duration: const Duration(milliseconds: 300),
                                  opacity: top <= 110.0 ? 1.0 : 0,
                                  child: Row(

                                    children: [

                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Container(
                                        height: kToolbarHeight / 1.8,
                                        width: kToolbarHeight / 1.8,
                                        decoration:   BoxDecoration(
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.white,
                                              blurRadius: 1.0,
                                            ),
                                          ],
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image:Global.imageUrl != null &&Global.imageUrl.trim() != ''? NetworkImage(Global.imageUrl):const AssetImage('assets/person.jpg'),
                                              //

                                              //
                                              // cubit.user_info_finalPickedImage ==
                                              //     null
                                              //     ? NetworkImage(cubit.image ??
                                              //     'https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Unknown_person.jpg/542px-Unknown_person.jpg')
                                              //     : FileImage(
                                              //     cubit.user_info_finalPickedImage),

                                              ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                        Text(
                                        Global.userName,
                                        style: const TextStyle(
                                            fontSize: 20.0, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                background: Stack(
                                  alignment: Alignment.bottomRight,
                                  children:   [

                                    Image(

                                      // image: AssetImage('assets/person.jpg'),
                                        image:    NetworkImage(
                                          Global.imageUrl),
                                      fit: BoxFit.fitWidth,
                                      width: double.infinity,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          // if(Global.isAdmin)
                          //   IconButton(icon: const Icon(Icons.arrow_back,size: 30),color: Constants.black,onPressed: (){
                          //     Navigator.pop(context);
                          //   }),

                          ],
                        );
                      }),
                    ),
                    SliverToBoxAdapter(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: userTitle(title: 'الصفحة الشخصية')),
                            const Divider(
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  // navigateTo(context, const FavouriteScreen());
                                  // NavigatToAndReplace(context,  const HomeLayout());
                                  HomeCubit.get(context).changeCurrentIndex(1);
                                },
                                splashColor: Colors.red,
                                child: const ListTile(
                                  title: Text('المفضلات'),
                                  trailing: Icon(Icons.chevron_right_rounded),
                                  leading: Icon(Icons.favorite),
                                ),
                              ),
                            ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  NavigatToAndReplace(context,  const HomeLayout());
                                  HomeCubit.get(context).changeCurrentIndex(3);
                                },
                                splashColor: Colors.red,
                                child: const ListTile(
                                  title: Text('المشتريات'),
                                  trailing: Icon(Icons.chevron_right_rounded),
                                  leading: Icon(MaterialCommunityIcons.cart_plus),
                                ),
                              ),
                            ),
                            // Material(
                            //   color: Colors.transparent,
                            //   child: InkWell(
                            //     onTap: () {
                            //       navigateTo(context, const Orders());
                            //     },
                            //     splashColor: Colors.red,
                            //     child: const ListTile(
                            //       title: Text('My Orders'),
                            //       trailing: Icon(Icons.chevron_right_rounded),
                            //       leading: Icon(Icons.shopping_bag_outlined),
                            //     ),
                            //   ),
                            // ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: userTitle(title: 'البيانات'),
                            ),
                            const Divider(
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            // Container(
                            //   child: userTile(
                            //     'البريد الالكتروني',
                            //     "IslamWaheed@gmail.com",
                            //     Icons.email,
                            //   ),
                            // ),
                            Container(
                              child: userTile(
                                'رقم التليفون',
                                Global.mobile??'',
                                Icons.phone,
                              ),
                            ),
if(Global.isAdmin)
                            Container(
                              child: userTile(
                                'الحالة',
                                cubit.listProject.firstWhere((element) => element.id == Global.projectId).isActive? 'فعال' : 'غير فعال'??'',
                                Icons.phone,
                              ),
                            ),
                            // Container(
                            //   child: userTile(
                            //     'العنوان',
                            //     "القطامية امام الاتحادية موقعه الجمل",
                            //     Icons.local_shipping,
                            //   ),
                            // ),
                            Container(
                              child: userTile(
                                'تاريخ الانضمام',
                             cubit.convertDateFormat(cubit.listUser.firstWhere((element) => element.mobile == Global.mobile).createdDate)??'',
                                Icons.watch_later,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0.8),
                              child: userTitle(title: 'الاعدادات'),
                            ),
                            const Divider(
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            ListTileSwitch(
                              value: cubit.isDarkTheme,
                              onChanged: (value) {
                                //cubit.mode();
                              },
                              leading: const Icon(Icons.dark_mode_outlined),
                              visualDensity: VisualDensity.comfortable,
                              switchType: SwitchType.cupertino,
                              switchActiveColor: Colors.indigo,
                              title: const Text('الوضع اليلي'),
                            ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                splashColor: Theme.of(context).splashColor,
                                child: ListTile(
                                  onTap: () async {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext ctx) {
                                          return AlertDialog(
                                            title: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      right: 6.0),
                                                  child: Image.asset(
                                                    'assets/logout.png',
                                                    height: 20,
                                                    width: 40,
                                                  ),
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text('تسجيل الخروج'),
                                                ),
                                              ],
                                            ),
                                            content: const Text(
                                                'هل تريد تسجيل الخروج؟',textAlign: TextAlign.end,),
                                            actions: [
                                              TextButton(
                                                  onPressed: () async {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text('الغاء')),
                                              TextButton(
                                                  onPressed: () {


                                                    cubit.logOut(context);

                                                  },
                                                  child: const Text(
                                                    'تاكيد',
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ))
                                            ],
                                          );
                                        });
                                  },
                                  title: const Text('تسجيل الخروج'),
                                  leading: const Icon(Icons.exit_to_app_rounded),
                                ),
                              ),
                            ),

                            // Material(
                            //   color: Colors.transparent,
                            //   child: InkWell(
                            //     splashColor: Theme.of(context).splashColor,
                            //     child: ListTile(
                            //       onTap: () async {
                            //         Global.isAdmin = !Global.isAdmin;
                            //         HomeCubit.get(context).emit(SearchSubCategoryState());
                            //       },
                            //       title:Global.isAdmin? const Text('التحويل الي مستخدم'):const Text('التحويل الي مدير'),
                            //       leading: const Icon(Icons.exit_to_app_rounded),
                            //     ),
                            //   ),
                            // ),
                            const SizedBox(
                              height: 85,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget userTile(String title, String subtitle, IconData leading) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      leading: Icon(leading),
    );
  }

  Widget userTitle({@required String title}) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
      ),
    );
  }
}
