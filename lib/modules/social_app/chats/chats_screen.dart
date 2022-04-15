import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/components.dart';
import 'package:projects/layout/social_app/cubit/cubit.dart';
import 'package:projects/layout/social_app/cubit/states.dart';
import 'package:projects/models/social_app/social_user_model.dart';
import 'package:projects/modules/social_app/chat_details/chat_details_screen.dart';

class ChatsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        return Conditional.single(
          context:context,
          conditionBuilder:(context)=>SocialCubit.get(context).users.length>0 ,
          widgetBuilder: (context)=>ListView.separated(
            physics:BouncingScrollPhysics() ,
            itemBuilder:(context,index)=> buildChatItem(SocialCubit.get(context).users[index],context),
            separatorBuilder:(context,state)=>myDiver(),
            itemCount: SocialCubit.get(context).users.length,
          ),
          fallbackBuilder: (context)=>Center(child: CircularProgressIndicator()),
        );
      },

    );
  }
  Widget buildChatItem(SocialUserModel model,context)=>InkWell(
    onTap: ()
    {
       navigateTo(context,ChatDetailsScreen(
           userModel: model));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
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
          Text(
            '${model.name}',
            style:Theme.of(context).textTheme.subtitle2!.copyWith(
              height: 1.4,
            ),
          ),
        ],
      ),
    ),
  );
}
