import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/constants.dart';
import 'package:projects/layout/social_app/cubit/cubit.dart';
import 'package:projects/layout/social_app/cubit/states.dart';
import 'package:projects/models/social_app/post_model.dart';
import 'package:projects/modules/social_app/social_login_screen/social_login_screen.dart';
import 'package:projects/shared/styles/colors.dart';

class FeedsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        return  Conditional.single(
          context: context,
          conditionBuilder:(context)=>SocialCubit.get(context).posts.length>0,//&&SocialCubit.get(context).userModel !=null,
          widgetBuilder:(context)=>SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  elevation: 5,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  margin: EdgeInsets.all(8),
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      Image(
                        image:NetworkImage(
                            'https://image.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg'),
                        fit:BoxFit.cover,
                        width: double.infinity,
                        height: 200,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'communicate with friends',
                          style:Theme.of(context).textTheme.subtitle1!.copyWith(
                            color:Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder:(context,index)=>buildPostItem(SocialCubit.get(context).posts[index],context,index),
                    separatorBuilder:(context,index)=>SizedBox(
                      height: 8,
                    ),
                    itemCount:SocialCubit.get(context).posts.length),
              ],
            ),
          ),
          fallbackBuilder: (context)=>Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
  Widget buildPostItem(PostModel model,context,index)=> Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5,
    margin: EdgeInsets.symmetric(
      horizontal: 10,
    ),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage:NetworkImage
                    ('${model.image}'),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${model.name}',
                            style:Theme.of(context).textTheme.subtitle1!.copyWith(
                              height: 1.4,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.check_circle,
                            size:14,
                            color:defaultColor,
                          ),

                        ],
                      ),
                      Text(
                        '${model.dateTime}',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                            height: 1.4
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                IconButton(
                    onPressed: (){},
                    icon:Icon(Icons.more_horiz,
                      size: 16,
                    ))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 15.0),
            child: Container(
              width: double.infinity,
              height: 1,
              color:Colors.grey[300],
            ),
          ),
          Text(
            '${model.text}',
            style:Theme.of(context).textTheme.subtitle1,
          ),
          // Padding(
          //   padding: const EdgeInsets.only(
          //     bottom:10.0,
          //     top:5,
          //   ),
          //   child: Container(
          //     width: double.infinity,
          //     child: Wrap(
          //       children: [
          //
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(
          //               end:8.0),
          //           child: Container(
          //             height: 25,
          //             child: MaterialButton(
          //               onPressed: (){},
          //               minWidth: 1,
          //               padding: EdgeInsets.zero,
          //               child:Text(
          //                 '#software',
          //                 style:Theme.of(context).textTheme.caption!.copyWith(
          //                   color:Colors.blue,
          //                 ),),
          //             ),
          //           ),
          //         ),
          //         SizedBox(
          //           width: 5,
          //         ),
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(
          //               end:8.0),
          //           child: Container(
          //             height: 25,
          //             child: MaterialButton(
          //               onPressed: (){},
          //               minWidth: 1,
          //               padding: EdgeInsets.zero,
          //               child:Text(
          //                 '#flutter',
          //                 style:Theme.of(context).textTheme.caption!.copyWith(
          //                   color:Colors.blue,
          //                 ),),
          //             ),
          //           ),
          //         ),
          //
          //
          //       ],
          //     ),
          //   ),
          // ),
          if(model.postImage!='')
          Padding(
            padding: const EdgeInsetsDirectional.only(
              top: 15.0,
            ),
            child: Container(
              width: double.infinity,
              height: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    4.0
                ),
                image:DecorationImage(
                  image:NetworkImage(
                      '${model.postImage}'),
                  fit:BoxFit.cover,
                ),

              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 5.0),
            child:Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0),
                    child: InkWell(
                      child: Row(
                        children: [
                          Icon(
                            Icons.favorite_border_outlined,
                            size: 16,
                            color:Colors.red,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${SocialCubit.get(context).likes[index]}',
                            style:Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                      onTap: (){},
                    ),


                  ),
                ),
                SizedBox(
                  width: 100,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0),
                    child: InkWell(
                      child: Row(
                        children: [
                          Icon(
                            Icons.chat_outlined,
                            size: 16,
                            color:Colors.amber,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '0 comment',
                            style:Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                      onTap: (){},
                    ),


                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 5.0),
            child: Container(
              width: double.infinity,
              height: 1,
              color:Colors.grey[300],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundImage:NetworkImage
                            (''),//${SocialCubit.get(context).userModel.image}
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'write a comment...',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                              height: 1.4
                          ),
                        ),
                      ]
                  ),
                  onTap: (){},
                ),

              ),
              InkWell(
                child: Row(
                  children: [
                    Icon(
                      Icons.favorite_border_outlined,
                      size: 16,
                      color:Colors.red,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Like',
                      style:Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
                onTap: ()
                {
                  SocialCubit.get(context).likePost( SocialCubit.get(context).postsId[index]);
                },
              ),
            ],
          ),
        ],
      ),
    ),
  );

}



