// @dart=2.9
import 'dart:ui';

import 'package:elomda/bloc/login_bloc/loginCubit.dart';
import 'package:elomda/bloc/login_bloc/loginState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:rounded_loading_button/rounded_loading_button.dart';



class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      builder: (context,state){
        var cubit = LoginCubit.get(context);
        return Scaffold(
      //    key: cubit.scaffoldLoginKey,
          backgroundColor:Colors.blue,
          body: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state)   {
              var cubit  = LoginCubit.get(context);
              // if(state is LoginErorrState)
              // {
              //   cubit.scaffoldLoginKey.currentState.showSnackBar(SnackBar(
              //       backgroundColor: Colors.red,
              //       content: Text(
              //         state.erorr.toString(),
              //         textAlign: TextAlign.center,
              //       ),
              //       shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.all(Radius.circular(30))),
              //       behavior: SnackBarBehavior.floating,
              //       padding: EdgeInsets.all(10.0),
              //       duration: Duration(milliseconds: 2000)));
              // }
            },
            builder:(context, state) {
              // var cubit = LoginCubit.get(context);
              return  Container(
                height: double.infinity,
                decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/bg.png"), fit: BoxFit.cover)),
                child: SingleChildScrollView(
                  child: Form(
                    // key: cubit.loginFormGlobalKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 20),
                          child: Center(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 32,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 30,
                          ),
                          child: TextFormField(
                            maxLength: 11,


                         //   controller: cubit.textMobileControl,
                         //    onChanged: (value){
                         //      cubit.changVaildState();
                         //    },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'You must enter 11 numbers';
                              }
                              return '';
                            },

                            decoration:  InputDecoration(

                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                // borderSide: BorderSide(
                                //   color: kSecondaryColor,
                                // ),
                              ),


                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  // color: kSecondaryColor,
                                  width: 2.0,
                                ),
                              ),

                              labelText: 'Mobile',
                              labelStyle: const TextStyle(
                                  // color: kSecondaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17),
                            ),
                            // border: OutlineInputBorder(),

                            keyboardType: TextInputType.phone,
                            // onFieldSubmitted: (value) {
                            //   if ( cubit.isVaild) {
                            //     cubit.getActivationCode(context);
                            //   }
                            // },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        Container(
                          width: 200,
                          height: 200,
                          child: RoundedLoadingButton(

                              // controller: cubit.loginbtnController,
                              successColor: Colors.green,
                              // color: Colors.green,
                              // color:cubit.isVaild ?kSecondaryColor: Colors.grey[500],
                              disabledColor: Colors.grey,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Activation',
                                    style:const TextStyle(
                                        color: Colors.white, fontSize: 20),
                                    textAlign: TextAlign.center,
                                  ),
                                  //  Icon(Icons.arrow_forward_outlined, color: Colors.white,)
                                ],
                              ),
                              // animateOnTap:  cubit.isVaild,
                              // onPressed: () {
                              //   if ( cubit.isVaild) {
                              //     cubit.getActivationCode(context);
                              //   }
                               // }
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } ,

          ),
        );
      },
      listener: (context,state){
        var cubit = LoginCubit.get(context);
        if(state is LoginErorrState)
          {
            // cubit.scaffoldLoginKey.currentState.showSnackBar(SnackBar(
            //     backgroundColor: Colors.red,
            //     content: Text(
            //       state.erorr.toString(),
            //       textAlign: TextAlign.center,
            //     ),
            //     shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.all(Radius.circular(30))),
            //     behavior: SnackBarBehavior.floating,
            //     padding: EdgeInsets.all(10.0),
            //     duration: Duration(milliseconds: 2000)));
          }
      },

    );

  }
}
