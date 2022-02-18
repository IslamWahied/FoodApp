// @dart=2.9

import 'package:dropdown_search/dropdown_search.dart';
import 'package:elomda/bloc/login_bloc/loginCubit.dart';
import 'package:elomda/bloc/login_bloc/loginState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';



class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state)   {


        },
        builder:(context, state) {
          var cubit = LoginCubit.get(context);
          return  SizedBox(
            height: double.infinity,
            //decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/bg.png"), fit: BoxFit.cover)),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [

                      IconButton(onPressed: (){
                        Navigator.pop(context);
                      }, icon:const Icon(Icons.arrow_back_sharp,color: Colors.black,)),
                    const  Text('Back',style: TextStyle(fontSize: 17),),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.06,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    child: const Center(
                      child: Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 30,
                    ),
                    child: TextFormField(
                       controller: cubit.txtRegisterUserNameControl,
                      onChanged: (value){
                          cubit.changeRegisterValidState();
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
                        if ( cubit.registerValid) {
                          cubit.registerAndLogin(context);
                        }
                      },
                    ),
                  ),

                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                      height: 105,
                      padding:  const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 30,
                      ),
                     child:
                      DropdownSearch(

                        popupBackgroundColor:Colors.grey[250] ,

                        maxHeight: MediaQuery.of(context).size.height * 0.35,
                        dropdownSearchDecoration: InputDecoration(

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

                          labelText: 'Department',

                          labelStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 17),
                        ),

                        selectedItem:cubit.departmantSelectedName??'' ,

                        showSearchBox: true,
                        mode: Mode.MENU,
                        items: listDepartment.map((e) => e.name).toList(),
                        onChanged: (value) async {
                          cubit.departmentId = listDepartment.firstWhere((element) => element.name == value ).id;
                          cubit.changeRegisterValidState();

                        },
                      )
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: RoundedLoadingButton(

                        controller: cubit.loginBtnController,
                        successColor: Colors.green,
                        // color: Colors.green,
                        animateOnTap: false,
                        color:cubit.registerValid ? Colors.blue: Colors.grey[500],
                        disabledColor: Colors.grey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Finished',
                              style:TextStyle(
                                  color: Colors.white, fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                            //  Icon(Icons.arrow_forward_outlined, color: Colors.white,)
                          ],
                        ),

                        onPressed: () {
                          if (cubit.registerValid) {
                            cubit.registerAndLogin(context);
                          }
                        }),
                  ),
                ],
              ),
            ),
          );
        } ,

      ),
    );

  }
}
List<ListDepartment> listDepartment = [
  ListDepartment(id:1, name: 'برمجه'),
  ListDepartment(id:2,name: 'حسابات'),
  ListDepartment(id:3,name: 'لوجيستك'),
  ListDepartment(id:4,name: 'خدمة العملاء'),
  ListDepartment(id:5,name: 'IT'),
  ListDepartment(id:6,name: 'بوفية'),
];
class ListDepartment {
  String name;
  int id;
  ListDepartment({this.name,this.id});
}