// @dart = 2.9
import 'package:dropdown_search/dropdown_search.dart';
import 'package:elomda/bloc/home_bloc/HomeCubit.dart';
import 'package:elomda/bloc/home_bloc/HomeState.dart';
import 'package:elomda/modules/product_details/foodDetail.dart';
import 'package:elomda/shared/components/Componant.dart';
import 'package:elomda/styles/colors.dart';
import 'package:elomda/styles/icons/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:url_launcher/url_launcher.dart';

import 'CustomerOrder.dart';

class CustomerAccountScreen extends StatelessWidget {
  const CustomerAccountScreen({Key  key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea (
      child: BlocConsumer<HomeCubit,HomeScreenState>(
        builder: (context,state){
          var cubit = HomeCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.grey[50],
            appBar:  AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              centerTitle: false,
              leadingWidth: 0,
              iconTheme: const IconThemeData(color: Constants.black),
              title: customAppBar(context: context, title: ' حساب العملاء',isShowCarShop: false),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.only(right: 10,left: 10),
                    child: SizedBox(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.095,
                        width: double.infinity,
                        child: DropdownSearch(


                          showClearButton: true,

                          popupBackgroundColor: Colors.grey[250],
                          maxHeight: MediaQuery
                              .of(context)
                              .size
                              .height * 0.35,
                          dropdownSearchDecoration: InputDecoration(
                            floatingLabelBehavior:FloatingLabelBehavior.auto ,
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(25.0),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(25.0),
                              borderSide: const BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                            ),
                            labelText: 'العميل',
                            alignLabelWithHint: true,


                            labelStyle: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 20),
                          ),
                          selectedItem: cubit.selectedUserId.trim() !=
                              '' ? cubit.listUser
                              .firstWhere((element) =>
                          element.mobile == cubit.selectedUserId)
                              .userName
                              : '',
                          showSearchBox: true,
                          mode: Mode.BOTTOM_SHEET,

                          items: cubit.listUser.map((e) => e.userName).toList(),
                          onChanged: (value) async {
                           if(value != null)
                             {
                               cubit.selectedUserId = cubit.listUser.firstWhere((element) => element.userName.toLowerCase()  == value.toString().toLowerCase()).mobile ;
                             }else{
                             cubit.selectedUserId = '';

                           }
                           cubit.emit(SelectCategoryState());

                          },
                        )),
                  ),
                  const SizedBox(height: 20),
                  if(cubit.selectedUserId != null &&  cubit.selectedUserId.trim() != '')
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.topCenter,
                      children: [

                        SizedBox(
                          width: double.infinity,
                          child: Card(
                            shadowColor: Colors.grey,

color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const SizedBox(
                                    height: 70,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Column(

                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('اجمالي المبالغ',style: TextStyle(fontSize: 18,color: Colors.grey[600],fontWeight:FontWeight.w800)),
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/dollar.svg',
                                                      color: Constants.tertiary,
                                                      width: 15,
                                                    ),
                                                    PrimaryText(
                                                      text:cubit.getTotalCustomerOrdersPrice() ,
                                                      size: 25,
                                                      fontWeight: FontWeight.w700,
                                                      color: Constants.tertiary,
                                                      height: 1,
                                                    ),

                                                  ],
                                                ),


                                              ],
                                            ),
                                            InkWell(
                                              onTap: (){
                                                navigateTo(context, const CustomerOrdersScreen());
                                              },
                                              child: Column(

                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text('عدد الطلبات',style: TextStyle(fontSize: 18,color: Colors.grey[600],fontWeight:FontWeight.w800)),

                                                  PrimaryText(
                                                    text:cubit.listAllOrders.where((element) => element.userMobile == cubit.selectedUserId).toList().length.toString()??0 ,
                                                    size: 25,
                                                    fontWeight: FontWeight.w700,
                                                    color: Constants.tertiary,
                                                    height: 1,
                                                  ),


                                                ],
                                              ),
                                            ),
                                            Column(

                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('الرصيد الحالي',style: TextStyle(fontSize: 18,color: Colors.grey[600],fontWeight:FontWeight.w800)),
                                                // Text('20',style: TextStyle(fontSize: 22,color: Colors.blueAccent,fontWeight:FontWeight.w700 ),),

                                                Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/dollar.svg',
                                                      color: Constants.tertiary,
                                                      width: 15,
                                                    ),
                                                    PrimaryText(
                                                      text:cubit.listUser.firstWhere((element) => element.mobile == cubit.selectedUserId).currentBalance.toString()??'0' ,
                                                      size: 25,
                                                      fontWeight: FontWeight.w700,
                                                      color: Constants.tertiary,
                                                      height: 1,
                                                    ),

                                                  ],
                                                ),

                                                MaterialButton(color: Colors.green,onPressed: (){

                                                  cubit.modalBottomSheetMenu(context);

                                                },child: Text('+اضافة رصيد',style: TextStyle(fontSize: 12,color: Colors.white,fontWeight:FontWeight.w800),))

                                              ],
                                            ),
                                          ],
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(vertical: 8),
                                          child: Divider(color: Colors.grey),
                                        ),
                                        Row(
mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Row(
                                              children: [
                                                Text(cubit.selectedUserId??'',style: TextStyle(color: Colors.blueAccent,fontSize: 16),),
                                                const Text('  :  '),
                                                Text('الموبيل',style: TextStyle(fontSize: 16,color: Colors.grey[600],fontWeight:FontWeight.w600)),
                                              ],
                                            ),


                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text(cubit.listUser.firstWhere((element) => element.mobile == cubit.selectedUserId).departmentId != null?cubit.departMentList[cubit.listUser.firstWhere((element) => element.mobile == cubit.selectedUserId).departmentId]:'',style: const TextStyle(color: Colors.blueAccent,fontSize: 16),),
                                            const Text('  :  '),
                                            Text('القسم',style: TextStyle(fontSize: 16,color: Colors.grey[600],fontWeight:FontWeight.w600)),

                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text(cubit.convertDateFormat(cubit.listUser.firstWhere((element) => element.mobile == cubit.selectedUserId).createdDate)??'',style: TextStyle(color: Colors.blueAccent,fontSize: 16),),
                                            // const Text('  :  '),
                                            Text('تاريخ الانضمام',style: TextStyle(fontSize: 16,color: Colors.grey[600],fontWeight:FontWeight.w600)),

                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        Padding(
                                          padding: const EdgeInsets.only(right: 10,top: 10),
                                          child: RoundedLoadingButton(
                                              width: 80,
                                              height: 40,

                                              controller: cubit.callBtnController,

                                              // color: Colors.green,
                                              color: Colors.green,

                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: const [

                                                  Icon(
                                                    Icons.call,
                                                    color: Colors.white,
                                                    size: 14,
                                                  ),
                                                  SizedBox(width: 3,),
                                                  Text(
                                                    "اتصال",
                                                    style: TextStyle(
                                                      fontSize: 15.0,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),



                                                ],
                                              ),
                                              animateOnTap: false,
                                              onPressed: () {

                                                launch(('tel://${cubit.selectedUserId}'));

                                              }),
                                        ),

                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: -20,
                          child:  Column(
                            children: [
                              CircleAvatar(
                                radius: 32,
                                backgroundColor: Colors.grey[50],
                                child:cubit.listUser.firstWhere((element) => element.mobile == cubit.selectedUserId).image != null && cubit.listUser.firstWhere((element) => element.mobile == cubit.selectedUserId).image.trim() != '' ? CircleAvatar(
                                  radius: 28,
                                  backgroundImage: NetworkImage(cubit.listUser.firstWhere((element) => element.mobile == cubit.selectedUserId).image),

                                ): const CircleAvatar(
                                  radius: 28,
                                  backgroundImage:AssetImage('assets/person.jpg'),

                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(cubit.listUser.firstWhere((element) => element.mobile == cubit.selectedUserId).userName??'',style: TextStyle(fontSize: 20,color: Colors.grey),)
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
          listener:  (context,state){},


      ),
    );
  }
}
