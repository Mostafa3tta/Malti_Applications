import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/components.dart';
import 'package:projects/layout/social_app/cubit/cubit.dart';
import 'package:projects/layout/social_app/cubit/states.dart';
import 'package:projects/modules/social_app/new_post/new_post_screen.dart';
import 'package:projects/shared/styles/icon_broken.dart';

class SocialLayout extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state)
      {
        if(state is SocialNewPostState){
          navigateTo(context, NewPostScreen());
        }
      },
      builder: (context,state){
        var cubit=SocialCubit.get(context);
        return  Scaffold(
          appBar: AppBar(
            title:Text(
              cubit.titles[cubit.currentIndex],
                ),
            actions: [
             IconButton(
                 onPressed:(){},
                 icon:Icon(
                   Icons.notifications,
                 ),),
              IconButton(
                onPressed:(){},
                icon:Icon(
                  Icons.search,
                ),),
            ],
          ),
          body:cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index)
            {
              cubit.changeBottomNav(index);
            },
            items: [
              BottomNavigationBarItem(
                  icon:Icon(Icons.home),
                label:'Home',
              ),
              BottomNavigationBarItem(
                icon:Icon(Icons.chat),
                label:'Chats',
              ),
              BottomNavigationBarItem(
                icon:Icon(Icons.upload_outlined),
                label:'Post',
              ),
              BottomNavigationBarItem(
                icon:Icon(Icons.add_location_outlined),
                label:'Users',
              ),
              BottomNavigationBarItem(
                icon:Icon(Icons.settings),
                label:'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}
