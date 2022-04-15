import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/components.dart';
import 'package:projects/layout/social_app/cubit/cubit.dart';
import 'package:projects/layout/social_app/cubit/states.dart';

class NewPostScreen extends StatelessWidget  {

  var textController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          appBar:AppBar(
            title:Text('Create Post'),
            actions: [
              defaultTextButton(
                  function:(){
                    var now=DateTime.now();
                  if(SocialCubit.get(context).postImage!=null)
                 {
                 SocialCubit.get(context).createPost(
                    dateTime: now.toString(),
                  text:textController.text,
                  );
               }
                 else
                 {
                    SocialCubit.get(context).uploadPostImage(
                     dateTime: now.toString(),
                       text:textController.text,
                   );
                 }
          },
                  text:'Post'),
            ],
          ),
          body:Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is SocialCreatePostLoadingState)
                LinearProgressIndicator(),
                if(state is SocialCreatePostLoadingState)
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage:NetworkImage
                        ('https://image.freepik.com/free-photo/close-up-portrait-attractive-young-woman-isolated_273609-36147.jpg'),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        'Saber Farag',
                        style:Theme.of(context).textTheme.subtitle1!.copyWith(
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                        hintText: 'what is on your mind...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                if(SocialCubit.get(context).postImage !=null)
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        image:DecorationImage(
                          image:FileImage(SocialCubit.get(context).postImage!),
                          fit:BoxFit.cover,
                        ),

                      ),
                    ),
                    CircleAvatar(
                      radius: 20,
                      child: IconButton(
                        onPressed: (){
                          SocialCubit.get(context).removePostImage();
                        },
                        icon: Icon(Icons.close),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: (){
                            SocialCubit.get(context).getPostImage();
                          },
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'add photo'
                              ),
                            ],
                          ),),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: (){},
                        child:Text(
                            '# tags'
                        ),),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
