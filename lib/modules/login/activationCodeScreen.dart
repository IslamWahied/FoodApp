// @dart=2.9
import 'package:elomda/bloc/login_bloc/loginCubit.dart';
import 'package:elomda/bloc/register_Bloc/registerBloc.dart';
import 'package:elomda/bloc/register_Bloc/registerState.dart';
import 'package:elomda/modules/login/login_screen.dart';
import 'package:elomda/shared/Global.dart';
import 'package:elomda/shared/components/constants.dart';
import 'package:elomda/shared/network/local/helper.dart';
import 'package:elomda/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ActivationCodeScreen extends StatelessWidget {
  const ActivationCodeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit()
        ..getAllProjects()
        ..getUsers(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
          return SafeArea(
            child: Scaffold(
                backgroundColor: Colors.grey[50],
                appBar: AppBar(
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.transparent,
                  centerTitle: false,
                  leadingWidth: 0,
                  iconTheme: const IconThemeData(color: Constants.black),
                  title: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 0,
                      vertical: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                       if(!cubit.activationDone)
                        GestureDetector(
                          onTap: () {
                            NavigatToAndReplace(context, const LoginScreen());
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    width: 1, color: Colors.grey[400])),
                            child: const Icon(Icons.chevron_left,color: Constants.white,),
                          ),
                        ),

                        const SizedBox(
                          width: 1,
                        )

                      ],
                    ),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    width: double.infinity,
                    child: Column(
                      children: [
                        // Image.asset('assets/foodLogo.jpg'),

                        const SizedBox(height: 30),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 3,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image.asset(cubit.activationDone
                                ? sucessAcctiveImage
                                : otpGifImage),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: cubit.activationDone
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0, vertical: 8),
                                  child: RichText(
                                    text: TextSpan(
                                        text:
                                            ' \n مبروك \n ${Global.mobile}\n  تم التفعيل بنجاح ',
                                        style: const TextStyle(
                                            color: Colors.green, fontSize: 15)),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              : const Text(
                                  'التحقق من رقم الهاتف',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22),
                                  textAlign: TextAlign.center,
                                ),
                        ),
                        if (!cubit.activationDone)
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30.0, vertical: 8),
                                child: RichText(
                                  text: TextSpan(
                                      text: "أدخل الرمز الذي أرسلناه إلى ",
                                      children: [
                                        TextSpan(
                                            text: LoginCubit.get(context)
                                                    .textMobileControl
                                                    .text ??
                                                '',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15)),
                                      ],
                                      style: const TextStyle(
                                          color: Colors.black54, fontSize: 15)),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              PinCodeTextField(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                cursorHeight: 20,
                                enablePinAutofill: true,
                                appContext: context,
                                length: 6,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                animationType: AnimationType.fade,
                                validator: (v) {
                                  if (v.length == 6) {
                                    cubit.verifiedIsValid = true;
                                    cubit.emit(RegisterSuccessState());

                                    return null;
                                  } else {
                                    cubit.verifiedIsValid = false;
                                    cubit.emit(RegisterSuccessState());

                                    return null;
                                  }
                                },
                                pinTheme: PinTheme(
                                  shape: PinCodeFieldShape.box,
                                  activeColor: Colors.white,
                                  activeFillColor: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  fieldHeight: 32,
                                  fieldWidth: 35,

                                  selectedColor: Colors.white,

                                  // fieldOuterPadding: EdgeInsets.all(1.5),
                                  selectedFillColor: Colors.white,
                                  inactiveColor:
                                      HexColor('#ededed').withOpacity(.1),
                                  inactiveFillColor: Colors.white,
                                ),
                                cursorColor: Colors.black,
                                animationDuration:
                                    const Duration(milliseconds: 300),
                                enableActiveFill: true,
                                useExternalAutoFillGroup: true,
                                errorAnimationController: cubit.errorController,
                                controller: cubit.textVerifiedCodeControl,
                                keyboardType: TextInputType.number,
                                boxShadows: const [
                                  BoxShadow(
                                    spreadRadius: 5,
                                    offset: Offset(0, 1),
                                    color: Colors.black12,
                                    blurRadius: 30,
                                  )
                                ],
                                onChanged: (String value) {},
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CountdownTimer(
                                    onEnd: () {
                                      cubit.timerEnd = true;
                                    },
                                    endTime: cubit.endTime,
                                    widgetBuilder: (_, time) {
                                      return cubit.timerEnd
                                          ? GestureDetector(
                                              onTap: () {
                                                cubit.endTime = DateTime.now()
                                                        .millisecondsSinceEpoch +
                                                    2000 * 30;
                                                cubit.timerEnd = false;
                                                cubit.resendActivationCode(
                                                    context);
                                                cubit.emit(
                                                    RegisterSuccessState());
                                              },
                                              child: const Text(
                                                'ارسال',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.deepOrange,
                                                    fontSize: 18,
                                                    decoration: TextDecoration
                                                        .underline),
                                              ),
                                            )
                                          : Text(
                                              '${time.min ?? '0'}:${time.sec ?? '0'}',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: Colors.grey,
                                                fontSize: 18,
                                              ),
                                              textAlign: TextAlign.center,
                                            );
                                    },
                                  ),
                                  const SizedBox(width: 10),
                                  RichText(
                                    text: const TextSpan(
                                        text: "اعادة ارسال كود التفعيل؟ ",
                                        children: [],
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 15)),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 200,
                                height: 200,
                                child: RoundedLoadingButton(
                                    height: 60,
                                    controller: cubit.verifiedBtnController,
                                    successColor: Colors.green,
                                    color: cubit.verifiedIsValid
                                        ? Colors.blue
                                        : Colors.grey[500],
                                    disabledColor: Colors.grey,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          'تفعيل',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                          textAlign: TextAlign.center,
                                        ),
                                        // Icon(Icons.arrow_forward_outlined, color: Colors.white,)
                                      ],
                                    ),
                                    animateOnTap: false,
                                    onPressed: () {
                                      if (cubit.verifiedIsValid) {
                                        cubit.activationNumber(context);
                                      }
                                    }),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                )),
          );
        },
        listener: (context, state) {
          // var cubit = LoginCubit.get(context);
          if (state is RegisterErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red,
                content: Text(
                  state.error.toString(),
                  textAlign: TextAlign.center,
                ),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                behavior: SnackBarBehavior.floating,
                padding: const EdgeInsets.all(10.0),
                duration: const Duration(milliseconds: 2000)));
          }
        },
      ),
    );
  }
}
