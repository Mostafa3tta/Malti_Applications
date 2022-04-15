import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/components.dart';
import 'package:projects/layout/social_app/cubit/cubit.dart';
import 'package:projects/layout/social_app/cubit/states.dart';

class EditProfileScreen extends StatelessWidget {
  var nameControlle=TextEditingController();
  var bioController=TextEditingController();
  var phoneController=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        var userModel=SocialCubit.get(context).userModel;
        var profileImage=SocialCubit.get(context).profileImage;
        var coverImage=SocialCubit.get(context).coverImage;


        nameControlle.text=userModel!.name;
        bioController.text=userModel.bio;
        phoneController.text=userModel.phone;
        return Scaffold(
          appBar: AppBar(
            title:Text('Edit Profile'),
            actions: [
              defaultTextButton(
                  function:(){
                    SocialCubit.get(context).updateUser(
                        name: nameControlle.text,
                        phone: phoneController.text,
                        bio: bioController.text);
                  },
                  text:'update'),
              SizedBox(
                height: 5,
              ),
            ],
          ),
          body:Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if(state is SocialUserUpdateLoadingState)
                    LinearProgressIndicator(),
                  if(state is SocialUserUpdateLoadingState)
                    SizedBox(
                      height: 15,
                    ),
                  Container(
                    height: 190,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 140,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight:Radius.circular(4.0),
                                    topLeft:Radius.circular(4.0),
                                  ),
                                  image:DecorationImage(
                                    image:coverImage==null?NetworkImage('${userModel!.cover}'):FileImage(coverImage)as ImageProvider,
                                    fit:BoxFit.cover,
                                  ),

                                ),
                              ),
                              CircleAvatar(
                                radius: 20,
                                child: IconButton(
                                  onPressed: (){
                                    SocialCubit.get(context).getCoverImage();
                                  },
                                  icon: Icon(Icons.camera_alt_outlined),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 64,
                              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage:profileImage==null? NetworkImage(
                                    '${userModel!.image}'):FileImage(profileImage)as ImageProvider,
                              ),
                            ),
                            CircleAvatar(
                              radius: 20,
                              child: IconButton(
                                onPressed: (){
                                  SocialCubit.get(context).getProfileImage();
                                },
                                icon: Icon(Icons.camera_alt_outlined),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  if(SocialCubit.get(context).profileImage!=null||SocialCubit.get(context).coverImage!=null)
                  Row(
                  children: [
                    if(SocialCubit.get(context).profileImage!=null)
                    Expanded(
                        child: Column(
                          children: [
                            defaultButton(
                                function:(){
                                  SocialCubit.get(context).uploadProfileImage(
                                      name:nameControlle.text,
                                      phone: phoneController.text,
                                      bio: bioController.text);
                                },
                                text: 'upload profile'),
                            SizedBox(
                              height: 5,
                            ),
                            if(state is SocialUserUpdateLoadingState)
                            LinearProgressIndicator(),
                          ],
                        ),
                      ),
                    SizedBox(
                     width: 5,
                    ),
                    if(SocialCubit.get(context).coverImage!=null)
                    Expanded(
                      child: Column(
                        children: [
                          defaultButton(
                              function:()
                              {
                                SocialCubit.get(context).uploadCoverImage(
                                    name:nameControlle.text,
                                    phone: phoneController.text,
                                    bio: bioController.text);
                              },
                              text: 'upload cover'),
                          SizedBox(
                            height: 5,
                          ),
                          if(state is SocialUserUpdateLoadingState)
                          LinearProgressIndicator(),
                        ],
                      ),
                    ),
                  ],
                ),
                  if(SocialCubit.get(context).profileImage!=null||SocialCubit.get(context).coverImage!=null)
                  SizedBox(
                    height: 15,
                  ),
                  defaultFormFeild(
                      controller: nameControlle,
                      type:TextInputType.name,
                      validate:(value){
                        if(value.isEmpty)
                        {
                          return'name must not be empty';
                        }
                        return null;
                      },
                      label: 'Name',
                      prefix:Icons.supervised_user_circle_outlined,),
                  SizedBox(
                    height: 10,
                  ),
                  defaultFormFeild(
                    controller: bioController,
                    type:TextInputType.text,
                    validate:(value){
                      if(value.isEmpty)
                      {
                        return'dio must not be empty';
                      }
                      return null;
                    },
                    label: 'Bio',
                    prefix:Icons.info_outline,),
                  SizedBox(
                    height: 10,
                  ),
                  defaultFormFeild(
                    controller: phoneController,
                    type:TextInputType.phone,
                    validate:(value){
                      if(value.isEmpty)
                      {
                        return'phone must not be empty';
                      }
                      return null;
                    },
                    label: 'Phone',
                    prefix:Icons.call,),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

