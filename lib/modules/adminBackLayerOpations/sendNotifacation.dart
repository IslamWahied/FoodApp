import 'package:elomda/bloc/home_bloc/HomeCubit.dart';
import 'package:elomda/modules/product_details/foodDetail.dart';
import 'package:elomda/shared/Global.dart';
import 'package:elomda/styles/colors.dart';
import 'package:flutter/material.dart';

class SendNotifacationScreen extends StatelessWidget {
  const SendNotifacationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 30,
            ),
            child: TextFormField(
            //  controller: cubit.txtRegisterUserNameControl,
              onChanged: (value){
              //  cubit.changeRegisterValidState();
              },

              decoration:  InputDecoration(

                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(
                    color: Colors.black,
                  ),
                ),


                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 2.0,
                  ),
                ),

                labelText: 'UserName',
                labelStyle: const TextStyle(

                    fontWeight: FontWeight.w500,
                    fontSize: 17),
              ),

              maxLength: 150,

              keyboardType: TextInputType.text,
              onFieldSubmitted: (value) {
                // if ( cubit.registerValid) {
                //   cubit.registerAndLogin(context);
                // }
              },
            ),
          ),


          MaterialButton(onPressed: (){
            HomeCubit.get(context).SendNotificationForAllUser(messageTitle: 'sss',messageBody: 'sssssss');



          },child: Text('ssss'),)



        ],
      ),
    );
  }
}
