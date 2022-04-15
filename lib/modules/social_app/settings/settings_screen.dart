import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/components.dart';
import 'package:projects/layout/social_app/cubit/cubit.dart';
import 'package:projects/layout/social_app/cubit/states.dart';
import 'package:projects/modules/social_app/edit_profile/edit_profile_screen.dart';

class SettingsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        var userModel=SocialCubit.get(context).userModel;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children:[
              Container(
                height: 190,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Container(
                        width: double.infinity,
                        height: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight:Radius.circular(4.0),
                            topLeft:Radius.circular(4.0),
                          ),
                          image:DecorationImage(
                            image:NetworkImage(''),//${userModel.cover}
                            fit:BoxFit.cover,
                          ),

                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 64,
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage:NetworkImage
                          ('${userModel!.image}'),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 7,
              ),
              Text(
                '${userModel.cover}',
                style: Theme.of(context).textTheme.subtitle2,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '${userModel.bio}',
                style: Theme.of(context).textTheme.caption,
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Column(
                        children: [
                          Text(
                            '100',
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Post',),
                        ],
                      ),
                      onTap: (){},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Column(
                        children: [
                          Text(
                            '250',
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'photos',),
                        ],
                      ),
                      onTap: (){},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Column(
                        children: [
                          Text(
                            '10k',
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Followers',),
                        ],
                      ),
                      onTap: (){},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Column(
                        children: [
                          Text(
                            '64',
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Followings',),
                        ],
                      ),
                      onTap: (){},
                    ),
                  ),

                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed:(){},
                      child:Text(
                          'Add Photos'
                      ),),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  OutlinedButton(
                    onPressed:()
                    {
                      navigateTo(context, EditProfileScreen());
                    },
                    child:Icon(
                      Icons.edit,
                      size: 16,),)
                ],
              ),
              Row(
                children: [
                  OutlinedButton(
                      onPressed: ()
                      {
                        FirebaseMessaging.instance.subscribeToTopic('announcements');
                      },
                      child:Text('subscribe')
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  OutlinedButton(
                      onPressed: (){
                        FirebaseMessaging.instance.unsubscribeFromTopic('announcements');
                      },
                      child:Text('unsubscribe')
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
   }
}


