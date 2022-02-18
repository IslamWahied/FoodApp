// @dart=2.9

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

Future<void> writeToFile(ByteData data, String path) {
  final buffer = data.buffer;
  return File(path).writeAsBytes(
      buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
}

 navigatTo(context,widget)=> Navigator.push(context,MaterialPageRoute(builder: (context)=>widget));






void NavigatToAndReplace(context,widget)
{
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context)=>widget,
      ), (Route<dynamic> route)=>false);
}


//  String DateFormate({
//    //String dateFormate = "dd-MM-yyyy",
//    String dateFormate = "yyyy-MM-dd",
//   @required String dateTime,
//
// })
// {
//   try
//   {
//     return dateFormate = DateFormat(dateFormate).format(DateTime.parse(dateTime)).toString();
//   }
//   catch(e)
//   {
//     return dateTime;
//   }
//
// }

List<String> cardColor = [
  "#5EB6E4",
  "#A24DC2",
  "#CF0072",
  "#6ABE2B",
  "#FB7545",
  "#5B1F69",
  "#5EB6E4",
  "#355C7D"
];