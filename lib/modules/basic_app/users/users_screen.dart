import 'package:flutter/material.dart';
import 'package:projects/models/user/user_model.dart';

class UsersScreen extends StatelessWidget {
List<UserModel>Users=[
  UserModel(
     id:1,
     name:'saber',
     phone:'+201030274069',
 ),
  UserModel(
    id:2,
    name:'mohamed',
    phone:'+201060274069',
  ),
  UserModel(
    id:3,
    name:'farag',
    phone:'+201040274069',
  ),
  UserModel(
    id:1,
    name:'saber',
    phone:'+201030274069',
  ),
  UserModel(
    id:2,
    name:'mohamed',
    phone:'+201060274069',
  ),
  UserModel(
    id:3,
    name:'farag',
    phone:'+201040274069',
  ),
  UserModel(
    id:4,
    name:'farouk',
    phone:'+201017441195',
  ),
];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Users'),
      ),
      body:ListView.separated(
          itemBuilder: (context,index)=>buildUserId(Users[index]),
          separatorBuilder:(context,index)=>Padding(
            padding: const EdgeInsetsDirectional.only(
              start:20.0,
            ),
            child: Container(
              width:double.infinity,
              height: 1,
              color:Colors.grey[300],

            ),
          ),
          itemCount: Users.length)
    );
  }
 Widget buildUserId(UserModel user)=> Padding(
   padding: const EdgeInsets.all(20.0),
   child: Row(
     children: [
       CircleAvatar(
         radius: 20.0,
         child:Text('${user.id}',
           style:TextStyle(
             fontSize:25.0,
             fontWeight: FontWeight.bold,
           ),),
       ),
       SizedBox(
         width: 20.0,
       ),
       Column(
         mainAxisSize: MainAxisSize.min,
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Text('${user.name}'),
           Text('${user.phone}',
             style:TextStyle(
               color:Colors.grey,
             ),),
         ],
       ),
     ],
   ),
 );
}
