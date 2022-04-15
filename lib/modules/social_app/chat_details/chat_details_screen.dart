
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/layout/social_app/cubit/cubit.dart';
import 'package:projects/layout/social_app/cubit/states.dart';
import 'package:projects/models/social_app/message_model.dart';
import 'package:projects/models/social_app/social_user_model.dart';
import 'package:projects/shared/styles/colors.dart';

class ChatDetailsScreen extends StatelessWidget {
late  SocialUserModel userModel;
 var messageController=TextEditingController();
 ChatDetailsScreen({required this.userModel});
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: ( context,){
        SocialCubit.get(context).getMessages(
            receiverId: userModel.uId
        );

        return BlocConsumer<SocialCubit,SocialStates>(
          listener: (context,state){},
          builder: (context,state)
          {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(userModel.image),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      userModel.name,
                    ),
                  ],
                ),
              ),
              body:Conditional.single(
                context: context,
                conditionBuilder:(context)=> SocialCubit.get(context).messages.length>0,
                  widgetBuilder:(context,)=> Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                            itemBuilder:(context,index)
                            {
                              var message=SocialCubit.get(context).messages[index];
                              if(SocialCubit.get(context).userModel!.uId==message.senderId)
                                return buildMyMessage(message);

                              return buildMessage(message);
                            },
                            separatorBuilder: (context,index)=>SizedBox(
                              height: 15,
                            ),
                            itemCount:SocialCubit.get(context).messages.length, ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color:Colors.grey,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: messageController,
                                decoration: InputDecoration(
                                  border:InputBorder.none,
                                  hintText:'type your message here...' ,
                                ),
                              ),
                            ),
                            Container(
                              height: 50,
                              color:defaultColor,
                              child: MaterialButton(
                                onPressed:()
                                {
                                  SocialCubit.get(context).sendMessage(
                                    receiverId: userModel.uId,
                                    dateTime: DateTime.now().toString(),
                                    text: messageController.text,
                                  );
                                },
                                minWidth: 1,
                                child:Icon(
                                  Icons.send_outlined,
                                  size:16,
                                  color:Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                fallbackBuilder: (context)=>Center(child: CircularProgressIndicator())
              ),
            );
          },
        );
      },

    );
  }

  
  Widget buildMessage(MessageModel model)=>Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
        decoration: BoxDecoration(
          color:Colors.grey[300],
          borderRadius: BorderRadiusDirectional.only(
            topEnd: Radius.circular(10.0),
            topStart: Radius.circular(10.0),
            bottomEnd: Radius.circular(10.0),
          ),
        ),
        padding: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10.0,
        ),
        child: Text(model.text)
    ),
  );
 Widget buildMyMessage(MessageModel model)=> Align(
   alignment: AlignmentDirectional.centerEnd,
   child: Container(
       decoration: BoxDecoration(
         color:defaultColor.withOpacity(.2),
         borderRadius: BorderRadiusDirectional.only(
           topEnd: Radius.circular(10.0),
           topStart: Radius.circular(10.0),
           bottomStart: Radius.circular(10.0),
         ),
       ),
       padding: EdgeInsets.symmetric(
         vertical: 5,
         horizontal: 10.0,
       ),
       child: Text(model.text)
   ),
 );
}
