//@dart=2.9
import 'package:elomda/bloc/home_bloc/HomeCubit.dart';
import 'package:elomda/bloc/home_bloc/HomeState.dart';
import 'package:elomda/modules/customer/product_details/foodDetail.dart';



import 'package:elomda/styles/colors.dart';
import 'package:elomda/styles/icons/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rounded_loading_button/rounded_loading_button.dart';

class SendNotifacationScreen extends StatelessWidget {
  const SendNotifacationScreen({Key  key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeScreenState>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            centerTitle: false,
            leadingWidth: 0,
            iconTheme: const IconThemeData(color: Constants.black),
            title: customAppBar(context: context, title: '',isShowCarShop: false),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [




                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey[300],
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(
                            15.0,
                          ),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0,
                                ),
                                child: TextFormField(
                                  maxLines: 2,

                                    controller:cubit.titleTextControl,
                                  onChanged: (value){

                                      cubit.emit(SelectCategoryState());

                                  },
                                  textAlign: TextAlign.right,
                                  textDirection: TextDirection.rtl,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(fontSize: 20),
                                    hintText: '...الموضوع',

                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey[300],
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(
                            15.0,
                          ),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0,
                                ),
                                child: TextFormField(
                                  maxLines: 15,
                                  focusNode: cubit.sendMessageNode,
                                  controller:cubit.sendMessageTextControl,
                                  onChanged: (value){

                                    cubit.emit(SelectCategoryState());

                                  },
                                  textAlign: TextAlign.right,
                                  textDirection: TextDirection.rtl,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(fontSize: 20),
                                    hintText: '... اكتب رسالتك هنا ',

                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      height: 100,
                      child: RoundedLoadingButton(
                          height: 60,
                          controller: cubit.sendNotifactionBtnController,
                          successColor: Colors.green,
                          color:
                          cubit.sendMessageTextControl.text != null &&  cubit.sendMessageTextControl.text.trim() != '' &&  cubit.titleTextControl.text != null && cubit.titleTextControl.text.trim() != '' ? Colors.blue : Colors.grey[500],
                          disabledColor: Colors.grey,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'ارسال',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: 10,),
                              Icon(
                                IconBroken.Send,
                                size: 16.0,
                                color: Colors.white,
                              )
                            ],
                          ),
                          animateOnTap: false,
                          onPressed: () {

                            if (
                            cubit.sendMessageTextControl.text != null && cubit.sendMessageTextControl.text.trim() != ''
                            &&
                                cubit.titleTextControl.text != null && cubit.titleTextControl.text.trim() != ''
                            ) {
                             cubit.sendNotificationForAllUser(context);
                            }
                          }),
                    ),



                  ],
                ),
              ),
            ),
          ),
        );
      } ,
    listener:(context, state){} ,

    );
  }
}
