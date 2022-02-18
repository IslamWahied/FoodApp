// @dart=2.9

import 'package:elomda/bloc/login_bloc/loginCubit.dart';
import 'package:elomda/bloc/login_bloc/loginState.dart';
import 'package:elomda/shared/network/local/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      builder: (context, state) {
        var cubit = LoginCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                width: double.infinity,
                child: Column(
                  children: [
                    Image.asset('assets/foodLogo.jpg'),
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(50),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 25,
                            offset: Offset(0, 5),
                            spreadRadius: -25,
                          ),
                        ],
                      ),
                      margin: const EdgeInsets.only(bottom: 20),
                      child: TextFormField(
                        controller: cubit.textMobileControl,
                        keyboardType: TextInputType.phone,
                        obscureText: false,
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff000912),
                          ),
                        ),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 25),
                          hintText: "Mobile",
                          hintStyle: TextStyle(
                            color: Color(0xffA6B0BD),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: Icon(Icons.phone),
                          prefixIconConstraints: BoxConstraints(
                            minWidth: 75,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        onChanged: (value) {
                          cubit.changVaildState();
                        },
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: RoundedLoadingButton(
                          height: 60,
                          controller: cubit.loginbtnController,
                          successColor: Colors.green,
                          color: cubit.isVaild ? Colors.blue : Colors.grey[500],
                          disabledColor: Colors.grey,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Activation',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          animateOnTap: false,
                          onPressed: () {
                            // navigatTo(context, ActivationCodeScreen());
                            if (cubit.isVaild) {
                              cubit.getActivationCode(context);
                            }
                          }),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 18),
                      child: Text(
                        "Terms & Conditions",
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                            color: Color(0xffA6B0BD),
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
      listener: (context, state) {
        var cubit = LoginCubit.get(context);
        if (state is LoginErorrState) {
          // home_layout_bloc.scaffoldLoginKey.currentState.showSnackBar(SnackBar(
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

class ActivationCodeScreen extends StatelessWidget {
  const ActivationCodeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      builder: (context, state) {
        var cubit = LoginCubit.get(context);
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(

              iconTheme: const IconThemeData(color: Colors.black),
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                width: double.infinity,
                child: Column(
                  children: [
                    Image.asset('assets/foodLogo.jpg'),
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(50),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 25,
                            offset: Offset(0, 5),
                            spreadRadius: -25,
                          ),
                        ],
                      ),
                      margin: const EdgeInsets.only(bottom: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: cubit.textVerifiedCodeControl,
                        obscureText: false,
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff000912),
                          ),
                        ),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 25),
                          hintText: "Verified Code",
                          hintStyle: TextStyle(
                            color: Color(0xffA6B0BD),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: Icon(Icons.phone),
                          prefixIconConstraints: BoxConstraints(
                            minWidth: 75,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        onChanged: (value) {
                          cubit.changVaildState();
                        },
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: RoundedLoadingButton(
                          height: 60,
                          controller: cubit.loginbtnController,
                          successColor: Colors.green,
                          // color: Colors.green,
                          color: cubit.isVaild ? Colors.blue : Colors.grey[500],
                          disabledColor: Colors.grey,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Verified',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                              //  Icon(Icons.arrow_forward_outlined, color: Colors.white,)
                            ],
                          ),
                          //  animateOnTap:  cubit.isVaild,
                          onPressed: () {
                            // if ( cubit.isVaild) {
                            //   cubit.getActivationCode(context);
                            // }
                          }),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 18),
                      child: Text(
                        "Terms & Conditions",
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                            color: Color(0xffA6B0BD),
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
      listener: (context, state) {
        var cubit = LoginCubit.get(context);
        if (state is LoginErorrState) {
          // home_layout_bloc.scaffoldLoginKey.currentState.showSnackBar(SnackBar(
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
