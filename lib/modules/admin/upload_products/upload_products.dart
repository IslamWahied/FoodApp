// @dart=2.9

import 'package:dropdown_search/dropdown_search.dart';
import 'package:elomda/bloc/Upload_products/upload_products_cubit.dart';
import 'package:elomda/bloc/Upload_products/upload_products_state.dart';
import 'package:elomda/bloc/home_bloc/HomeCubit.dart';
import 'package:elomda/modules/customer/product_details/foodDetail.dart';

import 'package:elomda/shared/Global.dart';
import 'package:elomda/shared/components/Componant.dart';

import 'package:elomda/styles/colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/svg.dart';

class UploadProductForm extends StatelessWidget {
  const UploadProductForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UploadProducts, UploadProductsState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = UploadProducts.get(context);
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              centerTitle: false,
              leadingWidth: 0,
              iconTheme: const IconThemeData(color: Constants.black),
              title: customAppBar(
                  context: context,
                  title: '',
                  isShowCarShop: false,
                  isYellow: true),
            ),
            bottomSheet: GestureDetector(
              onTap: () {
                if (cubit.isUploadValid && !cubit.isStartUpload) {
                  cubit.uploadCategory(context);
                }
              },
              child: Container(
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
                  color: cubit.isUploadValid
                      ? Colors.orange[400]
                      : Colors.grey[350],
                  //Theme.of(context).bottomAppBarColor,
                  child: InkWell(
                    onTap: () {
                      cubit.uploadCategory(context);
                    },
                    splashColor: Colors.pink,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.only(right: 2),
                          child: Text('اضافة',
                              style: TextStyle(fontSize: 18),
                              textAlign: TextAlign.center),
                        ),
                        GradientIcon(
                          Feather.upload,
                          20,
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
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    children: [
                      // SizedBox(height: 60,),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: Card(
                                color: Colors.grey.shade100,
                                elevation: 5,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        FittedBox(
                                          child: TextButton.icon(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.white)),
                                            onPressed: () => cubit
                                                .uploadPickImageCamera(context),
                                            icon: const Icon(Icons.camera,
                                                color: Colors.purpleAccent),
                                            label: Text(
                                              'كاميرا',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Theme.of(context)
                                                      .textSelectionTheme
                                                      .selectionColor),
                                            ),
                                          ),
                                        ),
                                        FittedBox(
                                          child: TextButton.icon(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.white)),
                                            onPressed: () =>
                                                cubit.uploadPickImageGallery(
                                                    context),
                                            icon: const Icon(Icons.image,
                                                color: Colors.purpleAccent),
                                            label: Text(
                                              'معرض الصور',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Theme.of(context)
                                                      .textSelectionTheme
                                                      .selectionColor),
                                            ),
                                          ),
                                        ),
                                        FittedBox(
                                          child: TextButton.icon(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.white)),
                                            onPressed: () => cubit
                                                .removeUploadImage(context),
                                            icon: Icon(
                                              Icons.remove_circle_rounded,
                                              color:
                                                  cubit.finalPickedProductImage ==
                                                          null
                                                      ? Colors.grey
                                                      : Colors.red,
                                            ),
                                            label: Text(
                                              'حذف',
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
                                    Expanded(
                                      //  flex: 2,
                                      child: cubit.finalPickedProductImage ==
                                              null
                                          ? Container(
                                              margin: const EdgeInsets.all(10),
                                              height: 200,
                                              width: 200,
                                              child: Center(
                                                child: Container(
                                                  height: 200,
                                                  // width: 200,
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .backgroundColor,
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            40.0),
                                                    child: Image.asset(
                                                      'assets/image-gallery.jpg',
                                                      fit: BoxFit.cover,
                                                      alignment:
                                                          Alignment.center,
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
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .backgroundColor,
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    child: Image.file(
                                                      cubit
                                                          .finalPickedProductImage,
                                                      fit: BoxFit.cover,
                                                      alignment:
                                                          Alignment.center,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 30),
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) =>
                                      GestureDetector(
                                        onTap: () {
                                          cubit.onChangeTypeItemId(
                                              listItemTypeCategory[index].id,
                                              context);
                                        },
                                        child: Container(
                                          height: 50.0,
                                          width: 85,
                                          color: Colors.transparent,
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  color: cubit.selectedTypeItemId ==
                                                          listItemTypeCategory[
                                                                  index]
                                                              .id
                                                      ? Colors.blue
                                                          .withOpacity(0.4)
                                                      : Colors.grey
                                                          .withOpacity(0.3),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25)),
                                              child: Center(
                                                child: Text(
                                                  listItemTypeCategory[index]
                                                          .name ??
                                                      '',
                                                  style: const TextStyle(
                                                      fontSize: 12),
                                                ),
                                              )),
                                        ),
                                      ),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(width: 5),
                                  itemCount: listItemTypeCategory.length ?? 0),
                            ),

                            const SizedBox(height: 30),
                            if (cubit.selectedTypeItemId == 2 ||
                                cubit.selectedTypeItemId == 3)
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.075,
                                  width: double.infinity,
                                  // child: DropdownSearch(
                                  //   popupBackgroundColor: Colors.grey[250],
                                  //   maxHeight:
                                  //       MediaQuery.of(context).size.height *
                                  //           0.35,
                                  //   dropdownSearchDecoration: InputDecoration(
                                  //     fillColor: Colors.white,
                                  //     focusedBorder: OutlineInputBorder(
                                  //       borderRadius:
                                  //           BorderRadius.circular(25.0),
                                  //       borderSide: const BorderSide(
                                  //         color: Colors.black,
                                  //       ),
                                  //     ),
                                  //     border: OutlineInputBorder(
                                  //       borderRadius:
                                  //           BorderRadius.circular(25.0),
                                  //       borderSide: const BorderSide(
                                  //         color: Colors.black,
                                  //         width: 2.0,
                                  //       ),
                                  //     ),
                                  //     labelText: 'القسم',
                                  //     labelStyle: const TextStyle(
                                  //         fontWeight: FontWeight.w400,
                                  //         fontSize: 14),
                                  //   ),
                                  //   selectedItem: cubit.selectedCategoryId !=
                                  //               0 &&
                                  //           HomeCubit.get(context)
                                  //               .listCategory
                                  //               .where((element) =>
                                  //                   element.isDeleted == 0 &&
                                  //                   element.projectId ==
                                  //                       Global.projectId)
                                  //               .isNotEmpty
                                  //       ? HomeCubit.get(context)
                                  //           .listCategory
                                  //           .firstWhere((element) =>
                                  //               element.categoryId ==
                                  //                   cubit.selectedCategoryId &&
                                  //               element.isDeleted == 0 &&
                                  //               element.projectId ==
                                  //                   Global.projectId)
                                  //           .categoryTitle
                                  //       : '',
                                  //   showSearchBox: true,
                                  //   mode: Mode.BOTTOM_SHEET,
                                  //   items: HomeCubit.get(context)
                                  //       .listCategory
                                  //       .where((element) =>
                                  //           element.isDeleted == 0 &&
                                  //           element.projectId ==
                                  //               Global.projectId)
                                  //       .map((e) => e.categoryTitle)
                                  //       .toList(),
                                  //   onChanged: (value) async {
                                  //     cubit.selectedSupCategoryId = 0;
                                  //     cubit.selectedCategoryId =
                                  //         HomeCubit.get(context)
                                  //             .listCategory
                                  //             .firstWhere((element) =>
                                  //                 element.categoryTitle ==
                                  //                     value &&
                                  //                 element.isDeleted == 0 &&
                                  //                 element.projectId ==
                                  //                     Global.projectId)
                                  //             .categoryId;
                                  //     if (cubit.selectedTypeItemId == 3) {
                                  //       cubit.getSubCategoryByCategoryId(
                                  //           cubit.selectedCategoryId);
                                  //     }
                                  //     cubit.checkIsUploadValid(context);
                                  //   },
                                  // )

                              ),
                            const SizedBox(height: 25),
                            if (cubit.selectedTypeItemId == 3 &&
                                HomeCubit.get(context)
                                    .listSubCategory
                                    .where((element) =>
                                        element.projectId == Global.projectId)
                                    .toList()
                                    .isNotEmpty)
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.075,
                                  width: double.infinity,
                                  // child: DropdownSearch(
                                  //   popupBackgroundColor: Colors.grey[250],
                                  //   maxHeight:
                                  //       MediaQuery.of(context).size.height *
                                  //           0.35,
                                  //   dropdownSearchDecoration: InputDecoration(
                                  //     fillColor: Colors.white,
                                  //     focusedBorder: OutlineInputBorder(
                                  //       borderRadius:
                                  //           BorderRadius.circular(25.0),
                                  //       borderSide: const BorderSide(
                                  //         color: Colors.black,
                                  //       ),
                                  //     ),
                                  //     border: OutlineInputBorder(
                                  //       borderRadius:
                                  //           BorderRadius.circular(25.0),
                                  //       borderSide: const BorderSide(
                                  //         color: Colors.black,
                                  //         width: 2.0,
                                  //       ),
                                  //     ),
                                  //     labelText: 'الفرع',
                                  //     labelStyle: const TextStyle(
                                  //         fontWeight: FontWeight.w400,
                                  //         fontSize: 14),
                                  //   ),
                                  //   selectedItem: cubit.selectedSupCategoryId !=
                                  //               0 &&
                                  //           HomeCubit.get(context)
                                  //               .listSubCategory
                                  //               .where((element) =>
                                  //                   element.isDeleted == 0 &&
                                  //                   element.categoryId ==
                                  //                       cubit
                                  //                           .selectedCategoryId &&
                                  //                   element.projectId ==
                                  //                       Global.projectId)
                                  //               .isNotEmpty &&
                                  //           cubit.selectedCategoryId != 0 &&
                                  //           cubit.selectedCategoryId != null
                                  //       ? HomeCubit.get(context)
                                  //           .listSubCategory
                                  //           .firstWhere((element) =>
                                  //               element.supCategoryId ==
                                  //                   cubit
                                  //                       .selectedSupCategoryId &&
                                  //               element.isDeleted == 0 &&
                                  //               element.projectId ==
                                  //                   Global.projectId)
                                  //           .subCategoryTitle
                                  //       : '',
                                  //   showSearchBox: true,
                                  //   mode: Mode.BOTTOM_SHEET,
                                  //   items: HomeCubit.get(context)
                                  //       .listSubCategory
                                  //       .where((element) =>
                                  //           element.isDeleted == 0 &&
                                  //           element.categoryId ==
                                  //               cubit.selectedCategoryId &&
                                  //           element.projectId ==
                                  //               Global.projectId)
                                  //       .map((e) => e.subCategoryTitle)
                                  //       .toList(),
                                  //   onChanged: (value) async {
                                  //     cubit.selectedSupCategoryId =
                                  //         HomeCubit.get(context)
                                  //             .listSubCategory
                                  //             .firstWhere((element) =>
                                  //                 element.subCategoryTitle ==
                                  //                     value &&
                                  //                 element.isDeleted == 0 &&
                                  //                 element.projectId ==
                                  //                     Global.projectId)
                                  //             .supCategoryId;
                                  //
                                  //     cubit.checkIsUploadValid(context);
                                  //   },
                                  // )
                              ),
                            const SizedBox(height: 25),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 9),
                                    child: TextFormField(
                                      // key: const ValueKey('Title'),
                                      controller: cubit.txtUploadTitle,
                                      onChanged: (value) {
                                        cubit.checkIsUploadValid(context);
                                      },
                                      keyboardType: TextInputType.text,
                                      decoration: const InputDecoration(
                                        labelText: 'الاسم',
                                      ),
                                      // onSaved: (value) {
                                      //   _productTitle = value;
                                      // },
                                    ),
                                  ),
                                ),
                              ],
                            ),


                            const SizedBox(
                              height: 15,
                            ),
                            if (cubit.selectedTypeItemId == 3)
                              Column(
                                children: <Widget>[
                                  Checkbox(
                                    value: cubit.isPopular,
                                    onChanged: (bool value) {
                                      cubit.changeIsPopular(value: value);
                                    },
                                  ), //Checkbox
                                  const Text(
                                    'ظهور في قائمة العروض',
                                    style: TextStyle(fontSize: 15.0),
                                  ), //Text
                                ], //<Widget>[]
                              ), //Row
                            const SizedBox(height: 30),
                            if (cubit.selectedTypeItemId != 1 &&
                                cubit.selectedTypeItemId != 2)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: TextFormField(
                                      controller: cubit.txtUploadPrice,
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        cubit.checkIsUploadValid(context);
                                      },
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'[0-9]')),
                                      ],
                                      decoration: const InputDecoration(
                                        labelText: 'السعر \$',
                                      ),
                                    ),
                                  ),
                                  if (cubit.isDiscount)
                                    Flexible(
                                      flex: 1,
                                      child: TextFormField(
                                        controller: cubit.txtUploadOldPrice,
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          cubit.checkIsUploadValid(context);
                                        },
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[0-9]')),
                                        ],
                                        decoration: const InputDecoration(
                                          labelText: 'السعر قبل الخصم \$',
                                        ),
                                      ),
                                    ),
                                  if (cubit.selectedTypeItemId != 4)
                                    Flexible(
                                      child: Column(
                                        children: <Widget>[
                                          //SizedBox

                                          Checkbox(
                                            value: cubit.isDiscount,
                                            onChanged: (bool value) {
                                              cubit.changeIsDiscount(
                                                  value: value);
                                            },
                                          ),

                                          const Text(
                                            'خصم',
                                            style: TextStyle(fontSize: 15.0),
                                          ), //Text
//Checkbox
                                        ], //<Widget>[]
                                      ),
                                    ),
                                ],
                              ),

                            const SizedBox(height: 30),
                            if (cubit.selectedTypeItemId == 3)
                              TextFormField(
                                // key: const ValueKey('Description'),
                                controller: cubit.txtUploadDescription,

                                maxLines: 5,
                                //autofocus: true,
                                // enabled: true,
                                // enableSuggestions: true,

                                textCapitalization:
                                    TextCapitalization.sentences,
                                decoration: InputDecoration(
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
                                  labelText: 'الوصف',
                                  labelStyle: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                ),
                                onChanged: (text) {
                                  cubit.checkIsUploadValid(context);
                                },
                              ),
                            if (cubit.selectedTypeItemId == 3 &&
                                HomeCubit.get(context)
                                    .listAdditions
                                    .where((element) =>
                                        element.projectId == Global.projectId)
                                    .toList()
                                    .isNotEmpty)
                              const SizedBox(height: 30),
        if (cubit.selectedTypeItemId ==3)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Text("الاضافات"),
                              ],
                            ),
        if (cubit.selectedTypeItemId != 1 &&
        cubit.selectedTypeItemId != 2)
                            const SizedBox(height: 20),
                            if (cubit.selectedTypeItemId == 3)
                              SizedBox(
                                height: 120,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: HomeCubit.get(context)
                                          .listAdditions
                                          .where((element) =>
                                              element.projectId ==
                                              Global.projectId)
                                          .toList()
                                          .length ??
                                      0,
                                  itemBuilder: (context, index) => Padding(
                                    padding: EdgeInsets.only(
                                        left: index == 0 ? 20 : 0,
                                        bottom: 7,
                                        top: 7),
                                    child: additionCard(
                                        imagePath: HomeCubit.get(context)
                                            .listAdditions
                                            .where((element) =>
                                                element.projectId ==
                                                Global.projectId)
                                            .toList()[index]
                                            .image,
                                        additionId: HomeCubit.get(context)
                                            .listAdditions
                                            .where((element) =>
                                                element.projectId ==
                                                Global.projectId)
                                            .toList()[index]
                                            .itemId,
                                        cubit: cubit,
                                        context: context),
                                  ),
                                ),
                              ),
                            if (cubit.selectedTypeItemId == 3 &&
                                HomeCubit.get(context)
                                    .listAdditions
                                    .where((element) =>
                                        element.projectId == Global.projectId)
                                    .toList()
                                    .isNotEmpty)
                              const SizedBox(
                                height: 50,
                              )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

GestureDetector additionCard(
    {String imagePath, int additionId, UploadProducts cubit, context}) {
  return GestureDetector(
    onTap: () {

      cubit.addAddition(context: context,additionId:additionId );
    },
    child: Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topRight,
      children: [
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 9),
            margin: const EdgeInsets.only(
              right: 20,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: const Radius.circular(20),
                  bottomRight: const Radius.circular(20),
                  topLeft: const Radius.circular(20),
                  topRight: cubit.listOfSelectedAdditions.any((element) =>
                          element.itemId == additionId &&
                          element.projectId == Global.projectId)
                      ? const Radius.circular(0)
                      : const Radius.circular(20),
                ),
                color: Constants.white,
                boxShadow: [
                  BoxShadow(blurRadius: 10, color: Colors.grey[300]),
                ]),
            child: Column(
              children: [
                Image.network(
                  imagePath,
                  width: 110,
                  height: 40,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      'assets/dollar.svg',
                      color: Constants.tertiary,
                      width: 10,
                      height: 10,
                    ),
                    PrimaryText(
                      text: HomeCubit.get(context)
                              .listAdditions
                              .firstWhere((element) =>
                                  element.itemId == additionId &&
                                  element.projectId == Global.projectId)
                              .price
                              .toString() ??
                          0.toString(),
                      size: 12,
                      fontWeight: FontWeight.w700,
                      color: Constants.tertiary,
                      height: 1,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                PrimaryText(
                  text: HomeCubit.get(context)
                          .listAdditions
                          .firstWhere((element) =>
                              element.itemId == additionId &&
                              element.projectId == Global.projectId)
                          .itemTitle
                          .toString() ??
                      ''.toString(),
                  size: 15,
                  fontWeight: FontWeight.w700,
                  color: Constants.darkBG,
                  height: 1,
                ),
              ],
            )),
        if (cubit.listOfSelectedAdditions.any((element) =>
            element.itemId == additionId &&
            element.projectId == Global.projectId))
          const Positioned(
              top: -10,
              right: 10,
              child: Icon(
                Icons.check_circle,
                color: Colors.green,
              )),
      ],
    ),
  );
}

class GradientIcon extends StatelessWidget {
  const GradientIcon(this.icon, this.size, this.gradient, {Key key}) : super(key: key);

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

Padding customAppBar2(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 10,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(width: 1, color: Colors.grey[400])),
            child: const Icon(Icons.chevron_left),
          ),
        ),
      ],
    ),
  );
}
