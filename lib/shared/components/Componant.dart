// @dart=2.9


import 'package:elomda/styles/colors.dart';
import 'package:elomda/styles/icons/icon_broken.dart';
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

Widget defaultAppBar({
  @required BuildContext context,
  String title,
  List<Widget> actions,
}) => AppBar(
  leading: IconButton(
    onPressed: ()
    {
      Navigator.pop(context);
    },
    icon: const Icon(
      IconBroken.Arrow___Left_2,
    ),
  ),
  titleSpacing: 5.0,
  title: Text(
    title,
  ),
  actions: actions,
);

Widget defaultFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  Function onSubmit,
  Function onChange,
  Function onTap,
  bool isPassword = false,
  @required Function validate,
  @required String label,
  @required IconData prefix,
  IconData suffix,
  Function suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: suffixPressed,
          icon: Icon(
            suffix,
          ),
        )
            : null,
        border: const OutlineInputBorder(),
      ),
    );

Widget defaultTextButton({
  @required Function function,
  @required String text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(
        text.toUpperCase(),
      ),
    );
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
class AppColors {
  static const white = Colors.white;
  static const secondary = Color(0xff323335);
  static const lightGray = Color(0xffc0c1c3);
  static const lighterGray = Color(0xffe0e0e0);
  static const black = Colors.black;
  static const primary = Color(0xfffdc912);
  static const tertiary = Color(0xffff36b6b);
}
class PrimaryText extends StatelessWidget {
  final double size;
  final FontWeight fontWeight;
  final Color color;
  final String text;
  final double height;
  final bool isDiscount;

   const PrimaryText( {
    this.text,
    this.isDiscount = false,
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
        decoration:isDiscount? TextDecoration.lineThrough:TextDecoration.none,
        overflow: TextOverflow.ellipsis,
        color: color,
        height: height,
        fontFamily: 'Poppins',
        fontSize: size,

        fontWeight: fontWeight,
      ),
    );
  }
}
