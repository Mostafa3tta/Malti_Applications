

import 'package:flutter/material.dart';
import 'package:projects/modules/shop_app/login/login_screen.dart';
import 'package:projects/shared/network/local/cach_helper.dart';

import 'components.dart';
import 'modules/social_app/social_login_screen/social_login_screen.dart';
void signOut(context,)
{
  CacheHelper.removeData(key:'token').then((value)
  {
   navigateAndFinish(context, SocialLoginScreen,) ;
 });
}
void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String token='';

String uId='';