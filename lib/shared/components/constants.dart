


import 'package:flutter/material.dart';

void printFullText(String text){

  final pattern=RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match)=>print(match.group(0)) );
}
 const Color primaryColor = Color(0xffFBFBFB);
 const String otpGifImage = "assets/otp.gif";
 const String sucessAcctiveImage = "assets/verify.png";

String token ='';



