// @dart=2.9
import 'package:backdrop/backdrop.dart';
import 'package:badges/badges.dart';
import 'package:elomda/bloc/home_bloc/HomeCubit.dart';
import 'package:elomda/bloc/home_bloc/HomeState.dart';
import 'package:elomda/home_layout/home_layout.dart';
import 'package:elomda/modules/user_info/edit_profile/edit_project_profile_screen.dart';
import 'package:elomda/shared/Global.dart';
import 'package:elomda/shared/components/Componant.dart';
import 'package:elomda/shared/network/local/helper.dart';
import 'package:elomda/styles/colors.dart';
import 'package:elomda/styles/icons/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:list_tile_switch/list_tile_switch.dart';

import '../customer/Userbacklayer.dart';
import 'edit_profile/edit_user_profile_screen.dart';

class UserInformationScreen extends StatelessWidget {
  const UserInformationScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
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
            frontLayerBackgroundColor: Constants.white,
            headerHeight: MediaQuery.of(context).size.height * 0.45,
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
              actions: [
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
                          // navigateTo(context, User_Info());
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [


                  if (!Global.isAdmin)
                    userTitle(
                        isShowAvatar: true,
                        title: Global.isAdmin
                            ? 'بيانات المطعم'
                            : 'الصفحة الشخصية'),

                  if (!Global.isAdmin)
                    const Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  if (!Global.isAdmin)
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          cubit.isShowBackLayer = false;
                          NavigatToAndReplace(
                              context, const HomeLayout());
                          cubit.changeCurrentIndex(1);
                        },
                        splashColor: Colors.red,
                        child: const ListTile(
                          title: Text('المفضلات'),
                          trailing: Icon(Icons.chevron_right_rounded),
                          leading: Icon(Icons.favorite),
                        ),
                      ),
                    ),
                  if (!Global.isAdmin)
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          cubit.isShowBackLayer = false;
                          NavigatToAndReplace(
                              context, const HomeLayout());
                          cubit.changeCurrentIndex(3);
                        },
                        splashColor: Colors.red,
                        child: const ListTile(
                          title: Text('المشتريات'),
                          trailing: Icon(Icons.chevron_right_rounded),
                          leading: Icon(MaterialCommunityIcons.cart_plus),
                        ),
                      ),
                    ),



                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 10.0),
                      //   child: OutlinedButton(
                      //     onPressed: () {
                      //       if(Global.isAdmin) {
                      //         navigateTo(
                      //           context,
                      //           EditProjectProfileScreen(projectModel: cubit.listProject.firstWhere((element) => element.id == Global.projectId) ),
                      //         );
                      //       }
                      //
                      //       if(!Global.isAdmin) {
                      //         navigateTo(
                      //           context,
                      //           EditUserProfileScreen( userModel:  cubit.listUser.firstWhere((element) => element.mobile == Global.mobile)),
                      //         );
                      //       }
                      //     },
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: const [
                      //         Icon(
                      //           IconBroken.Edit,
                      //           size: 16.0,
                      //         ),
                      //         SizedBox(
                      //           width: 10.0,
                      //         ),
                      //         Text(
                      //           'تعديل البيانات',
                      //         ),
                      //
                      //
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      SizedBox(),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: userTitle(title:Global.isAdmin?'بيانات المطعم': 'البيانات '),
                      ),

                    ],
                  ),
                  const Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),

                  if (Global.isAdmin)
                    Container(
                      child: userTile(
                        'رقم التليفون',
                        cubit.listProject
                            .firstWhere((element) =>
                        element.id == Global.projectId)
                            .projectMobile ??
                            '',
                        Icons.phone,
                      ),
                    ),
                  if (!Global.isAdmin)
                    Container(
                      child: userTile(
                        'رقم التليفون',
                        Global.mobile ?? '',
                        Icons.phone,
                      ),
                    ),
                  if(cubit.listUser.isNotEmpty && !Global.isAdmin )
                    Container(
                      child: userTile(
                        'العنوان',
                        cubit.listUser
                            .firstWhere((element) =>
                        element.mobile == Global.mobile)
                            .address ??
                            '',
                        Icons.location_on_outlined,
                      ),
                    ),

                  if(cubit.listProject.isNotEmpty && Global.isAdmin )
                    Container(
                      child: userTile(
                        'العنوان',
                        cubit.listProject
                            .firstWhere((element) =>
                        element.id == Global.projectId)
                            .address ??
                            '',
                        Icons.location_on_outlined,
                      ),
                    ),

                  if (Global.isAdmin)
                    Container(
                      child: userTile(
                        'الحالة',
                        cubit.listProject
                            .firstWhere((element) =>
                        element.id == Global.projectId)
                            .isActive
                            ? 'فعال'
                            : 'غير فعال' ?? '',
                        cubit.listProject
                            .firstWhere((element) =>
                        element.id == Global.projectId)
                            .isActive?  Icons.check_circle_outline:Icons.do_not_disturb,
                      ),
                    ),
                  if (!Global.isAdmin)
                    Container(
                      child: userTile(
                        'تاريخ الانضمام',
                        cubit.listUser.isNotEmpty?      cubit.convertDateFormat(cubit.listUser
                            .firstWhere((element) =>
                        element.mobile == Global.mobile)
                            .createdDate ??
                            '') ??
                            '':'',
                        Icons.watch_later,
                      ),
                    ),

                  if ( Global.isAdmin)
                    Container(
                      child: userTile(
                        'تاريخ الانضمام',
                        cubit.listProject.isNotEmpty?      cubit.convertDateFormat(cubit.listProject
                            .firstWhere((element) =>
                        element.id == Global.projectId)
                            .createdDate ??
                            '') ??
                            '':'',
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
                  // ListTileSwitch(
                  //   value: cubit.isDarkTheme,
                  //   onChanged: (value) {
                  //     //cubit.mode();
                  //   },
                  //   leading: const Icon(Icons.dark_mode_outlined),
                  //   visualDensity: VisualDensity.comfortable,
                  //   switchType: SwitchType.cupertino,
                  //   switchActiveColor: Colors.indigo,
                  //   title: const Text('الوضع اليلي'),
                  // ),
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
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(
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
                                    'هل تريد تسجيل الخروج؟',
                                    textAlign: TextAlign.end,
                                  ),
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
                        leading:
                        const Icon(Icons.exit_to_app_rounded),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 85,
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget userTile(String title, String subtitle, IconData leading) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      leading: Icon(leading),
    );
  }

  Widget userTitle({@required String title,bool isShowAvatar = false }) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [

          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
          ),
          if(isShowAvatar)
          const SizedBox(width: 10,),
    //       if(isShowAvatar)
    //       CircleAvatar(
    //         backgroundImage: Global.imageUrl != null ?
    // Image.network(Global.imageUrl, errorBuilder: (BuildContext context, Object exception,StackTrace stackTrace) {
    //           return const Text('😢');
    //   }):)

        ],
      ),
    );
  }
}
