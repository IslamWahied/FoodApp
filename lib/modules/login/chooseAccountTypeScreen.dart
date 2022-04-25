// @dart=2.9

import 'package:elomda/bloc/register_Bloc/registerBloc.dart';
import 'package:elomda/bloc/register_Bloc/registerState.dart';
import 'package:elomda/modules/customer/product_details/foodDetail.dart';

import 'package:elomda/modules/login/register_screen.dart';

import 'package:elomda/shared/network/local/helper.dart';
import 'package:elomda/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountTypeScreen  extends StatelessWidget {
  const AccountTypeScreen ({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        centerTitle: false,
        leadingWidth: 0,
        iconTheme: const IconThemeData(
            color: Constants.black
        ),

        title:customAppBar(context: context,title: '',isShowCarShop: false) ,
      ),
      body: BlocConsumer<RegisterCubit,RegisterState>(
        builder: (context, state)  {
          var cubit = RegisterCubit.get(context);
          return Column(

            children:
            [

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children:
                    [
                      Expanded(
                        child:
                        GestureDetector(
                    onTap: (){
                cubit.isAdmin  = false;
                cubit.emit(RegisterChangeInScreenState());
                },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 200,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/customer.png',color:!cubit.isAdmin? Constants.white:Constants.black,),

                                    ],
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    10.0,
                                  ),
                                  color:!cubit.isAdmin? Colors.blue:Colors.grey[400],
                                ),
                              ),
                              const Text('عميل',style: TextStyle(fontSize: 18),)
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Expanded(

                        child:  GestureDetector(
                          onTap: (){
                            cubit.isAdmin  = true;
                            cubit.emit(RegisterChangeInScreenState());
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(

                                height: 200,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/Chef.png',color:cubit.isAdmin? Constants.white:Constants.black,),

                                    ],
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color:cubit.isAdmin? Colors.blue:Colors.grey[400],
                                  borderRadius: BorderRadius.circular(
                                    10.0,
                                  ),

                                ),
                              ),
                              const Text('مطعم',style: TextStyle(fontSize: 18),)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {

                        navigatTo(context , const RegisterScreen());


                      },
                      child: Container(

                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color:Colors.blue,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(width: 1, color: Colors.grey[400])),
                        child: Row(
                          children: const [
                            Text('التالي',style: TextStyle(fontSize: 18,color: Constants.white),),
                            Icon(Icons.chevron_right,color: Constants.white,),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            ],
          );
        },
        listener:(context, state)  {} ,

      ),
    );
  }
}
