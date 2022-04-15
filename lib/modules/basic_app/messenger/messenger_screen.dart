import 'package:flutter/cupertino.dart';
import'package:flutter/material.dart';
class MessengerScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        titleSpacing: 20,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20.0,
              backgroundImage: NetworkImage('https://www.facebook.com/saber.farag.509'),
            ),
            SizedBox(
              width: 15.0,
            ),
            Text('Chats',
            style:TextStyle(
              color:Colors.black,
            ),),
          ],
        ),
        actions:[
          IconButton(
              icon:CircleAvatar(
                radius: 15.0,
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.camera_alt,
                  size:16,
                  color:Colors.white,
                ),
              ),
              onPressed: null),
          IconButton(
              icon:CircleAvatar(
                radius: 15.0,
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.edit,
                  size:16,
                  color:Colors.white,
                ),
              ),
              onPressed: null),
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color:Colors.grey[300],
                ),
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text('Search'),
                  ],
                ),
              ),
              SizedBox(
               height: 10,
              ),
              Container(
                height: 90,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                    itemBuilder:(context,index)=> BuildStoryItem(),
                  separatorBuilder: (context,index)=>SizedBox(
                    width: 20,
                  ),
                  itemCount: 5,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                  itemBuilder:(context,index)=>BuildChatItem() ,
                  separatorBuilder:(context,index)=>Padding(
                    padding: const EdgeInsetsDirectional.only(
                      start: 20.0,
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 1,
                      color:Colors.grey[300],
                    ),
                  ),
                  itemCount: 15),
            ],
          ),
        ),
      ),
    );
  }
//1- build item
  // 2- build list
  // 3-add item to list
  Widget BuildChatItem() => Row(
    children: [
      Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage('https://www.facebook.com/saber.farag.509'),
          ),

          Padding(
            padding: const EdgeInsetsDirectional.only(
              bottom:3.0,
              end:3.0,
            ),
            child: CircleAvatar(
              radius: 7.0,
              backgroundColor: Colors.green,
            ),
          ),
        ],
      ),
      SizedBox(
        width: 20,
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Saber Farag',
              style:TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),),
            Row(
              children:[
                Text('hello saber how are you',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,),
                SizedBox(
                  width: 5.0,
                ),
                Container(
                  width:5.0,
                  height: 5.0,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape:BoxShape.circle,
                  ),
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text('02:00 pm'),
              ],
            ),
          ],
        ),
      ),
    ],
  ); //arrow function
 Widget BuildStoryItem() =>   Container(
   child:Column(
     children: [
     CircleAvatar(
     radius: 20.0,
     backgroundImage: NetworkImage('https://www.facebook.com/saber.farag.509'),
   ),
       Container(
         width:90,
         child: Text('saber farag farouk',
         style:TextStyle(
           fontWeight: FontWeight.bold,
           //fontSize: 5,
         ),
         maxLines: 1,
         overflow: TextOverflow.ellipsis,),
       ),
       SizedBox(
  height: 15,
       ),
   ],
   ),

  );
}
