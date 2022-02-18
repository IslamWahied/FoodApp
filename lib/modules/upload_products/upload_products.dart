// @dart=2.9

// ignore_for_file: deprecated_member_use, use_key_in_widget_constructors

import 'package:dropdown_search/dropdown_search.dart';
import 'package:elomda/bloc/Upload_products/upload_products_cubit.dart';
import 'package:elomda/bloc/Upload_products/upload_products_state.dart';
import 'package:elomda/modules/login/register_screen.dart';

import 'package:elomda/styles/colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';

class UploadProductForm extends StatelessWidget {
  const UploadProductForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UploadProducts, UploadProductsState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = UploadProducts.get(context);
        return Scaffold(
          backgroundColor: Constants.lightBG,
          appBar: AppBar(
            title: const Text(
              'Upload Product',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          bottomSheet: Container(
            height: kBottomNavigationBarHeight * 0.8,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
            ),
            child: Material(
              color:Colors.yellowAccent[100],
              //Theme.of(context).bottomAppBarColor,
              child: InkWell(
                onTap: () {
                  if (cubit.UploadProduct_formKey.currentState.validate()) {
                    cubit.uploadProduct();
                  } else {
                    return null;
                  }
                },
                splashColor: Colors.pink,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(right: 2),
                      child: Text('Upload',
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.center),
                    ),
                    GradientIcon(
                      Feather.upload, 20,
                      LinearGradient(
                        colors: <Color>[
                          Colors.green,
                          Colors.yellow,
                          Colors.deepOrange,
                          Colors.orange,
                          Colors.yellow[800]
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: Form(
            key: cubit.UploadProduct_formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // SizedBox(height: 60,),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Text(cubit.category.toString()),
                          /* Image picker here ***********************************/
                          Card(
                            color: Colors.grey.shade100,
                            elevation: 5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  //  flex: 2,
                                  child: cubit.finalPickedProductImage == null
                                      ? Container(
                                          margin: const EdgeInsets.all(10),
                                          height: 200,
                                          width: 200,
                                          child: Center(
                                            child: Container(
                                              height: 200,
                                              // width: 200,
                                              decoration: BoxDecoration(
                                                // borderRadius: BorderRadius.only(
                                                //   topLeft: const Radius.circular(40.0),
                                                // ),
                                                color: Theme.of(context)
                                                    .backgroundColor,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(40.0),
                                                child: Image.network(
                                                  'https://haryana.gov.in/wp-content/themes/sdo-theme/images/default/image-gallery.jpg',
                                                  fit: BoxFit.cover,
                                                  alignment: Alignment.center,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container(
                                          margin: const EdgeInsets.all(10),
                                          height: 200,
                                          width: 200,
                                          child: Center(
                                            child: Container(
                                              height: 200,
                                              // width: 200,
                                              decoration: BoxDecoration(
                                                // borderRadius: BorderRadius.only(
                                                //   topLeft: const Radius.circular(40.0),
                                                // ),
                                                color: Theme.of(context)
                                                    .backgroundColor,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(0.0),
                                                child: Image.file(
                                                  cubit.finalPickedProductImage,
                                                  fit: BoxFit.fill,
                                                  alignment: Alignment.center,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FittedBox(
                                      child: FlatButton.icon(
                                        textColor: Colors.white,
                                        onPressed: () => cubit
                                            .uploadPickImageCamera(context),
                                        icon: const Icon(Icons.camera,
                                            color: Colors.purpleAccent),
                                        label: Text(
                                          'Camera',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Theme.of(context)
                                                .textSelectionColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    FittedBox(
                                      child: FlatButton.icon(
                                        textColor: Colors.white,
                                        onPressed: () =>
                                            cubit.UploadPickImageGallery(
                                                context),
                                        icon: const Icon(Icons.image,
                                            color: Colors.purpleAccent),
                                        label: Text(
                                          'Gallery',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Theme.of(context)
                                                .textSelectionColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    FittedBox(
                                      child: FlatButton.icon(
                                        textColor: Colors.white,
                                        onPressed: () =>
                                            cubit.removeUploadImage(context),
                                        icon: Icon(
                                          Icons.remove_circle_rounded,
                                          color:
                                              cubit.finalPickedProductImage ==
                                                      null
                                                  ? Colors.grey
                                                  : Colors.red,
                                        ),
                                        label: Text(
                                          'Remove',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color:
                                                cubit.finalPickedProductImage ==
                                                        null
                                                    ? Colors.grey
                                                    : Colors.redAccent,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 9),
                                  child: TextFormField(
                                    key: const ValueKey('Title'),
                                    controller: cubit.txtUploadTitle,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter a Title';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                      labelText: 'Product Title',
                                    ),
                                    // onSaved: (value) {
                                    //   _productTitle = value;
                                    // },
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: TextFormField(
                                  key: const ValueKey('Price \$'),
                                  controller: cubit.txtUploadPrice,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Price is missed';
                                    }
                                    return null;
                                  },
                                  // inputFormatters: <TextInputFormatter>[
                                  //   FilteringTextInputFormatter.allow(
                                  //       RegExp(r'[0-9]')),
                                  // ],
                                  decoration: const InputDecoration(
                                    labelText: 'Price \$',
                                    //  prefixIcon: Icon(Icons.mail),
                                    // suffixIcon: Text(
                                    //   '\n \n \$',
                                    //   textAlign: TextAlign.start,
                                    // ),
                                  ),
                                  //obscureText: true,
                                  // onSaved: (value) {
                                  //   _productPrice = value;
                                  // },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
SizedBox(
  width: double.infinity,
  height: 50,
  child:   ListView.separated(

    scrollDirection: Axis.horizontal,

      itemBuilder: (context,index)=>GestureDetector(
        onTap: (){
          cubit.onChangeTypeItemId(index);
        },
        child: Container(

          height: 50.0,

          width: 100,

          color: Colors.transparent,

          child: Container(

              decoration: BoxDecoration(

                  color:cubit.selectedTypeItemId == listCategory[index].id?Colors.blue.withOpacity(0.4): Colors.grey.withOpacity(0.3),

                  borderRadius: BorderRadius.circular(25

                  )

              ),

              child:   Center(

                child:  Text(listCategory[index].name??''),

              )

          ),

        ),
      ),

      separatorBuilder:  (context,index)=>const SizedBox(width: 20),



      itemCount: listCategory.length??0

  ),
),


                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.075,
                                  width: 300,

                                  child:
                                  DropdownSearch(

                                    popupBackgroundColor:Colors.grey[250] ,

                                    maxHeight: MediaQuery.of(context).size.height * 0.30,
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

                                      labelText: 'Category',

                                      labelStyle: const TextStyle(
                                          // color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14),
                                    ),

                                //    selectedItem:cubit.departmantSelectedName??'' ,

                                    showSearchBox: true,
                                    mode: Mode.MENU,
                                  items: listDepartment.map((e) => e.name).toList(),
                                    onChanged: (value) async {
                                      // cubit.departmentId = listDepartment.firstWhere((element) => element.name == value ).id;
                                      // cubit.changeRegisterValidState();

                                    },
                                  )
                              ),
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Form(
                                          key: cubit.addCategoryFormKey,
                                          child: AlertDialog(
                                            title: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 6.0),
                                                  child: Image.network(
                                                    'https://cdn.iconscout.com/icon/premium/png-256-thumb/add-category-2636951-2184721.png',
                                                    height: 40,
                                                    width: 40,
                                                  ),
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text('Add category'),
                                                )
                                              ],
                                            ),
                                            content: TextFormField(
                                              controller: cubit.txtAddCategory,
                                              textInputAction:
                                                  TextInputAction.done,
                                              autofocus: true,
                                              onEditingComplete: () {
                                                if (cubit.addCategoryFormKey
                                                    .currentState
                                                    .validate()) {
                                                  cubit.addCategory(
                                                      cubit.txtAddCategory.text,
                                                      cubit.txtAddCategory.text,
                                                      context);
                                                } else {
                                                  return null;
                                                }
                                              },
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'Please enter a category';
                                                }
                                                return null;
                                              },
                                            ),
                                            actions: [
                                              TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  child: const Text('Cancel')),
                                              TextButton(
                                                  onPressed: () {
                                                    if (cubit.addCategoryFormKey
                                                        .currentState
                                                        .validate()) {
                                                      cubit.addCategory(
                                                          cubit.txtAddCategory
                                                              .text,
                                                          cubit.txtAddCategory
                                                              .text,
                                                          context);
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  child: const Text('Add')),
                                            ],
                                          ),
                                        );
                                      });
                                },
                                icon: const Icon(
                                  Icons.add_circle,
                                  color: Colors.deepOrange,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.075,
                                  width: 300,

                                  child:
                                  DropdownSearch(

                                    popupBackgroundColor:Colors.grey[250] ,

                                    maxHeight: MediaQuery.of(context).size.height * 0.30,
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

                                      labelText: 'SupCategory',

                                      labelStyle: const TextStyle(
                                        // color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14),
                                    ),

                                    //    selectedItem:cubit.departmantSelectedName??'' ,

                                    showSearchBox: true,
                                    mode: Mode.MENU,
                                    items: listDepartment.map((e) => e.name).toList(),
                                    onChanged: (value) async {
                                      // cubit.departmentId = listDepartment.firstWhere((element) => element.name == value ).id;
                                      // cubit.changeRegisterValidState();

                                    },
                                  )
                              ),
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Form(
                                          key: cubit.addCategoryFormKey,
                                          child: AlertDialog(
                                            title: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.only(
                                                      right: 6.0),
                                                  child: Image.network(
                                                    'https://cdn.iconscout.com/icon/premium/png-256-thumb/add-category-2636951-2184721.png',
                                                    height: 40,
                                                    width: 40,
                                                  ),
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text('Add category'),
                                                )
                                              ],
                                            ),
                                            content: TextFormField(
                                              controller: cubit.txtAddCategory,
                                              textInputAction:
                                              TextInputAction.done,
                                              autofocus: true,
                                              onEditingComplete: () {
                                                if (cubit.addCategoryFormKey
                                                    .currentState
                                                    .validate()) {
                                                  cubit.addCategory(
                                                      cubit.txtAddCategory.text,
                                                      cubit.txtAddCategory.text,
                                                      context);
                                                } else {
                                                  return null;
                                                }
                                              },
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'Please enter a category';
                                                }
                                                return null;
                                              },
                                            ),
                                            actions: [
                                              TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  child: const Text('Cancel')),
                                              TextButton(
                                                  onPressed: () {
                                                    if (cubit.addCategoryFormKey
                                                        .currentState
                                                        .validate()) {
                                                      cubit.addCategory(
                                                          cubit.txtAddCategory
                                                              .text,
                                                          cubit.txtAddCategory
                                                              .text,
                                                          context);
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  child: const Text('Add')),
                                            ],
                                          ),
                                        );
                                      });
                                },
                                icon: const Icon(
                                  Icons.add_circle,
                                  color: Colors.deepOrange,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.095,
                                  width: 300,

                                  child: TextFormField(
                                    // controller: cubit.txtRegisterUserNameControl,
                                    // onChanged: (value){
                                    //   cubit.changeRegisterValidState();
                                    // },

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

                                      labelText: 'Product',
                                      labelStyle: const TextStyle(
                                          // color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15),
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

                            ],
                          ),
                          const SizedBox(height: 25),
                          Card(
                            elevation: 3,
                            child: TextFormField(
                              key: const ValueKey('Description'),
                              controller: cubit.txtUploadDescription,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'product description is required';
                                }
                                return null;
                              },
                              maxLines: 5,
                              //autofocus: true,
                              enabled: true,
                              enableSuggestions: true,

                              textCapitalization: TextCapitalization.sentences,
                              decoration: const InputDecoration(
                                //  counterText: charLength.toString(),
                                labelText: 'Description',
                                // hintText: 'Product description',
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (text) {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class GradientIcon extends StatelessWidget {
  const GradientIcon(
    this.icon,
    this.size,
    this.gradient,
  );

  final IconData icon;
  final double size;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      child: SizedBox(
        width: size * 1.2,
        height: size * 1.2,
        child: Icon(
          icon,
          size: size,
          color: Colors.white,
        ),
      ),
      shaderCallback: (Rect bounds) {
        final Rect rect = Rect.fromLTRB(0, 0, size, size);
        return gradient.createShader(rect);
      },
    );
  }
}
