import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:firebase_core/firebase_core.dart';
import'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:projects/components.dart';
import 'package:projects/desktop.dart';
import 'package:projects/layout/social_app/social_layout.dart';
import 'package:projects/layout/todo_app/home_layout.dart';
import 'package:projects/mobile.dart';
import 'package:projects/shared/cubit/cubit.dart';
import 'package:projects/layout/shop_app/shop_layout.dart';
import 'package:projects/modules/shop_app/login/login_screen.dart';
import 'package:projects/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:projects/shared/bloc_observer.dart';
import 'package:projects/shared/network/local/cach_helper.dart';
import 'package:projects/shared/network/remote/dio_helper.dart';
import 'package:projects/shared/styles/themes.dart';
import 'package:projects/states.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'constants.dart';
import 'layout/news_app/cubit/cubit.dart';
import 'layout/news_app/cubit/states.dart';
import 'layout/news_app/news_layout.dart';
import 'layout/shop_app/shop_cubit.dart';
import 'layout/social_app/cubit/cubit.dart';
import 'modules/social_app/social_login_screen/social_login_screen.dart';

// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print('on background message ');
//   print(message.data.toString());
//   showToast(text: 'on background message', state:ToastState.SUCCESS);
//
// }

void main() async {
  //بيتأكد ان كل حاجه هنا في الميثود خلصت و بعدين يفتح الابليكشن
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // var token=FirebaseMessaging.instance.getToken();
  // print(token);
  // FirebaseMessaging.onMessage.listen((event) {
  //   print('on message');
  //   print(event.data.toString());
  //   showToast(text: 'on message', state:ToastState.SUCCESS);
  // });
  // FirebaseMessaging.onMessageOpenedApp.listen((event) {
  //   print('on message opened app');
  //   print(event.data.toString());
  //   showToast(text: 'on message opened app', state:ToastState.SUCCESS);
  //
  // });
  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  if(Platform.isWindows)
  await DesktopWindow.setMinWindowSize(Size(
    350,650
  ));
  bool isDark=CacheHelper.getData(key: 'isDark');

 Widget widget;
 //bool onBoarding=CacheHelper.getData(key: 'onBoarding');
  //token=CacheHelper.getData(key: 'token');
   uId=CacheHelper.getData(key: 'uId');

  // if(onBoarding !=null)
  // {
  //     if(token!=null)
  //     widget=ShopLayout();
  //     else
  //       widget=ShopLoginScreen();
  // }
  // else {
  //   widget = OnBoardingScreen();
  // }

  if(uId !=null)
  {
    widget=SocialLayout();
  }
  else{
    widget=SocialLoginScreen();
  }

  runApp(MyApp(isDark: isDark,
  startWidget: widget,)
  );

  //runApp(MyApp());

}


class MyApp extends StatelessWidget
{
 bool? isDark;
 Widget? startWidget;
//final Widget starWidget;
 // this.starWidget
  MyApp({this.isDark,this.startWidget});

  @override
  Widget build(BuildContext context) {

         return MultiBlocProvider(
           providers: [

             BlocProvider(create:(context)=>NewsCubit()
               ..getBusinessData()
               ..getSportsData()
               ..getScienceData(),),
             BlocProvider(create: (context)=> AppCubit()
               ..changeDarkMode(formShared:isDark,)),
             BlocProvider(create:(context)=>ShopCubit()
               ..getHomeData()
               ..getCategories()
               ..getFavorites()
               ..getUserData()
             ),
             BlocProvider(create:(context)=>SocialCubit()
               ..getUserData()
               ..getPosts()
               ..getUsers()
             ),

           ],
           child:BlocConsumer<AppCubit,AppStates>(
             listener:(context,state){},
             builder: (context,state){
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                 theme: lightTheme,
                 darkTheme:darkTheme,
                 themeMode:AppCubit.get(context).isDark?ThemeMode.dark:ThemeMode.light,

                 home: LayoutBuilder (
                     builder: (BuildContext context, BoxConstraints constraints){
                       if(constraints.minWidth.toInt()<=560)
                         return MobileScreen();
                       return  DesktopScreen();
                     },
                     ),
              );
             }
           ),
         );
       }
    //  ),
    // );
  }
