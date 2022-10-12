//@dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

AppBar buildAppBar(BuildContext context, {String title, List<Widget> actions, Widget leading}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.w300
      ),
    ),
    centerTitle: true,
    leading: leading,
    actions: actions, systemOverlayStyle: SystemUiOverlayStyle.light,
  );
}