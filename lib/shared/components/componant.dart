// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void navigateTo(context, widget) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => widget),
  );
}

void navigateWithoutBack(context, widget) {
  Navigator.pushReplacement(context,
      new MaterialPageRoute(builder: (BuildContext context) => widget));
}

Widget defultTextFormFaild({
  @required TextEditingController controlle,
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
  TextInputAction textInputAction
}) {
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

Widget buildbutton({
  double width = double.infinity,
  Color color = Colors.blue,
  bool isUppercase = true,
  double radiuss = 20.0,
  @required Function onpressed,
  @required String text,
}) =>
    Container(
      width: width,
      child: MaterialButton(
        onPressed: onpressed,
        child: Text(
          isUppercase ? text.toUpperCase() : text.toLowerCase(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        ),
      ),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radiuss),
        color: color,
      ),
    );

void showToast({
  @required String text,
  @required ToastState state,
}) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

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
                onPressed: () => Navigator.pop(context), child: Text('Cancel')),
            TextButton(onPressed: fuc, child: Text('Ok')),
          ],
        );
      });
}
