import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/components.dart';
import 'package:projects/layout/news_app/cubit/cubit.dart';
import 'package:projects/layout/news_app/cubit/states.dart';
import 'package:projects/modules/news_app/search/search_screen.dart';

import 'package:projects/shared/network/remote/dio_helper.dart';

import '../../shared/cubit/cubit.dart';



class NewsLayout extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    // return BlocConsumer<NewsCubit,NewsStates>(
    //   listener: (context,state){},
    //   builder: (context,state){
    //     var cubit=NewsCubit.get(context);
        return BlocProvider(
          create: (BuildContext context)=>NewsCubit()..getBusinessData()..getSportsData()..getScienceData(),
          child: BlocConsumer<NewsCubit,NewsStates>(
            listener:(context,state){},
            builder:(context,state){
              var cubit=NewsCubit.get(context);
             return Scaffold(
                appBar: AppBar(
                  title: Text(
                    'News App',
                    ),
                  actions: [
                  IconButton(
                      onPressed:()
                      {
                        navigateTo(context, SearchScreen());
                      },
                      icon: Icon(Icons.search),),
                  IconButton(
                      onPressed:(){
                        AppCubit.get(context).changeDarkMode();
                      },
                      icon: Icon(Icons.brightness_4_outlined,
                      ),),
                  ],
                ),
                body:cubit.screens[cubit.currentIndex],
                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: cubit.currentIndex,
                 onTap:(index)
                 {
                   cubit.changeBottomNav(index);
                 },
                  items:cubit.bottomItem,
                ),


              );
            },
          ),
        );
    //   },
    // );
  }
}
