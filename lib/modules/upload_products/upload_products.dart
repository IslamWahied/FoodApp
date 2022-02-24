// @dart=2.9

import 'package:dropdown_search/dropdown_search.dart';
import 'package:elomda/bloc/Upload_products/upload_products_cubit.dart';
import 'package:elomda/bloc/Upload_products/upload_products_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                color: cubit.isUploadValid ? Colors.yellowAccent[700] : Colors
                    .yellowAccent[100],
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
          ),
          body: SafeArea(
            child: Form(
              // key: cubit.UploadProduct_formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    customAppBar2(context),
                    // SizedBox(height: 60,),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Card(
                              color: Colors.grey.shade100,
                              elevation: 5,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
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

                                            color: Theme
                                                .of(context)
                                                .backgroundColor,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(
                                                40.0),
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
                                          decoration: BoxDecoration(

                                            color: Theme
                                                .of(context)
                                                .backgroundColor,
                                          ),
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.all(0.0),
                                            child: Image.file(
                                              cubit
                                                  .finalPickedProductImage,
                                              fit: BoxFit.fill,
                                              alignment: Alignment.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FittedBox(
                                        child: FlatButton.icon(
                                          textColor: Colors.white,
                                          onPressed: () =>
                                              cubit
                                                  .uploadPickImageCamera(
                                                  context),
                                          icon: const Icon(Icons.camera,
                                              color: Colors.purpleAccent),
                                          label: Text(
                                            'Camera',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Theme
                                                  .of(context)
                                                  .textSelectionColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      FittedBox(
                                        child: FlatButton.icon(
                                          textColor: Colors.white,
                                          onPressed: () =>
                                              cubit.uploadPickImageGallery(
                                                  context),
                                          icon: const Icon(Icons.image,
                                              color: Colors.purpleAccent),
                                          label: Text(
                                            'Gallery',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Theme
                                                  .of(context)
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

                            const SizedBox(height: 30),
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) =>
                                      GestureDetector(
                                        onTap: () {
                                          cubit.onChangeTypeItemId(index);
                                        },
                                        child: Container(
                                          height: 50.0,
                                          width: 100,
                                          color: Colors.transparent,
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  color: cubit
                                                      .selectedTypeItemId ==
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
                                                        ''),
                                              )),
                                        ),
                                      ),
                                  separatorBuilder: (context, index) =>
                                  const SizedBox(width: 20),
                                  itemCount: listItemTypeCategory.length ?? 0),
                            ),

                            const SizedBox(height: 30),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 9),
                                    child: TextFormField(
                                      // key: const ValueKey('Title'),
                                      controller: cubit.txtUploadTitle,
                                      onChanged: (value) {
                                        cubit.checkIsUploadValid();
                                      },
                                      keyboardType: TextInputType.text,
                                      decoration: const InputDecoration(
                                        labelText: 'Title',
                                      ),
                                      // onSaved: (value) {
                                      //   _productTitle = value;
                                      // },
                                    ),
                                  ),
                                ),
                                if (cubit.selectedTypeItemId == 3)
                                  Flexible(
                                    flex: 1,
                                    child: TextFormField(
                                      // key: const ValueKey('Price \$'),
                                      controller: cubit.txtUploadPrice,
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        cubit.checkIsUploadValid();
                                      },
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'[0-9]')),
                                      ],
                                      decoration: const InputDecoration(
                                        labelText: 'Price \$',
                                        // prefixIcon: Icon(Icons.mail),
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

                            const SizedBox(
                              height: 30,
                            ),
                            if (cubit.selectedTypeItemId == 3 || cubit.selectedTypeItemId != 1 && cubit.listSubCategory.isNotEmpty )
                              SizedBox(
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.075,
                                  width: double.infinity,
                                  child: DropdownSearch(
                                    popupBackgroundColor: Colors.grey[250],
                                    maxHeight: MediaQuery
                                        .of(context)
                                        .size
                                        .height * 0.35,
                                    dropdownSearchDecoration: InputDecoration(
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
                                      labelText: 'Category',
                                      labelStyle: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14),
                                    ),
                                    selectedItem: cubit.selectedCategoryId !=
                                        0 && cubit.listCategory
                                        .where((element) =>
                                    element.isDeleted == 0)
                                        .isNotEmpty
                                        ? cubit.listCategory
                                        .firstWhere((element) =>
                                    element.id ==
                                        cubit.selectedCategoryId &&
                                        element.isDeleted == 0)
                                        .name
                                        : '',
                                    showSearchBox: true,
                                    mode: Mode.BOTTOM_SHEET,
                                    items: cubit.listCategory.where((
                                        element) => element.isDeleted == 0)
                                        .map((e) => e.name)
                                        .toList(),
                                    onChanged: (value) async {
                                      cubit.selectedCategoryId = cubit.listCategory.firstWhere((element) => element.name == value && element.isDeleted == 0).id;
                                      if (cubit.selectedTypeItemId == 3) {
                                        cubit.getSubCategoryByCategoryId(cubit.selectedCategoryId);
                                      }
                                      cubit.checkIsUploadValid();
                                    },
                                  )),

                            if (cubit.selectedTypeItemId == 3)
                              const SizedBox(height: 25),
                            if (cubit.selectedTypeItemId == 3)
                              SizedBox(
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.075,
                                  width: double.infinity,
                                  child: DropdownSearch(
                                    popupBackgroundColor: Colors.grey[250],

                                    maxHeight: MediaQuery
                                        .of(context)
                                        .size
                                        .height * 0.35,
                                    dropdownSearchDecoration: InputDecoration(
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
                                      labelText: 'SupCategory',
                                      labelStyle: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14),
                                    ),
                                    selectedItem: cubit.selectedSupCategoryId !=
                                        0 && cubit.listSubCategory
                                        .where((element) =>
                                    element.isDeleted == 0)
                                        .isNotEmpty &&
                                        cubit.selectedCategoryId != 0 &&
                                        cubit.selectedCategoryId != null ? cubit
                                        .listSubCategory
                                        .firstWhere((element) =>
                                    element.supCategoryId ==
                                        cubit.selectedSupCategoryId &&
                                        element.isDeleted == 0)
                                        .name
                                        : '',
                                    showSearchBox: true,
                                    mode: Mode.BOTTOM_SHEET,
                                    items: cubit.listSubCategory.where((
                                        element) => element.isDeleted == 0)
                                        .map((e) => e.name)
                                        .toList(),
                                    onChanged: (value) async {
                                      cubit.selectedSupCategoryId =
                                          cubit.listSubCategory
                                              .firstWhere((element) =>
                                          element.name == value &&
                                              element.isDeleted == 0)
                                              .supCategoryId;

                                      cubit.checkIsUploadValid();
                                    },
                                  )),
                            if (cubit.selectedTypeItemId == 3)
                              const SizedBox(height: 25),
                            if (cubit.selectedTypeItemId == 3)
                              Card(
                                elevation: 3,
                                child: TextFormField(
                                  // key: const ValueKey('Description'),
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

                                  textCapitalization:
                                  TextCapitalization.sentences,
                                  decoration: const InputDecoration(
                                    //  counterText: charLength.toString(),
                                    labelText: 'Description',
                                    // hintText: 'Product description',
                                    border: OutlineInputBorder(),
                                  ),
                                  onChanged: (text) {},
                                ),
                              ),
                            if (cubit.selectedTypeItemId == 3)
                              const SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class GradientIcon extends StatelessWidget {
  const GradientIcon(this.icon,
      this.size,
      this.gradient,);

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
