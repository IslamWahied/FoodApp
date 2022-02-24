// @dart=2.9
// ignore_for_file: constant_identifier_names

import 'package:elomda/styles/colors.dart';
import 'package:flutter/material.dart';


void navigateTo(context, widget) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => widget),
  );
}

void navigateWithoutBack(context, widget) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (BuildContext context) => widget));
}

Widget defultTextFormFaild(
    {@required TextEditingController controlle,
    @required TextInputType tybe,
    @required String lable,
    @required IconData prefix,
    @required Function validate,
    IconData sufix,
    bool ispassowrd = false,
    Function onchange,
    Function onsubmit,
    Function hideen,
    Function onTap,
    Function onSave,
    Color fillColor,
    TextInputAction textInputAction}) {
  return TextFormField(
    onChanged: onchange,
    onTap: onTap,
    onFieldSubmitted: onsubmit,
    validator: validate,
    controller: controlle,
    keyboardType: tybe,
    obscureText: ispassowrd,
    //textInputAction: textInputAction,
    //  onSaved: onSave,
    decoration: InputDecoration(
      labelText: lable,
      border: const UnderlineInputBorder(),
      prefixIcon: Icon(prefix),
      filled: true,
      fillColor: fillColor,
      suffixIcon: sufix != null
          ? IconButton(
              icon: Icon(sufix),
              onPressed: hideen,
            )
          : null,
    ),
  );
}

// void showToast({
//   @required String text,
//   @required ToastState state,
// }) {
//   Fluttertoast.showToast(
//       msg: text,
//       toastLength: Toast.LENGTH_LONG,
//       gravity: ToastGravity.BOTTOM,
//       timeInSecForIosWeb: 5,
//       backgroundColor: chooseToastColor(state),
//       textColor: Colors.white,
//       fontSize: 16.0);
// }

enum ToastState { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastState state) {
  Color color;

  switch (state) {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.ERROR:
      color = Colors.red;
      break;
    case ToastState.WARNING:
      color = Colors.yellow;
      break;
  }

  return color;
}

void showDialogAlairt(context, String title, String subtitle, Function fuc) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 6.0),
                child: Image.network(
                  'https://image.flaticon.com/icons/png/128/564/564619.png',
                  height: 20,
                  width: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(title),
              )
            ],
          ),
          content: Text(subtitle),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel')),
            TextButton(onPressed: fuc, child: const Text('Ok')),
          ],
        );
      });
}

class PrimaryText extends StatelessWidget {
  final double size;
  final FontWeight fontWeight;
  final Color color;
  final String text;
  final double height;

   const PrimaryText({
    this.text,
    this.fontWeight = FontWeight.w400,
    this.color = Constants.secondary,
    this.size = 20,
    this.height = 1.3,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        height: height,
        fontFamily: 'Poppins',
        fontSize: size,
        fontWeight: fontWeight,
      ),
    );
  }
}
