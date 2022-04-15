import'package:flutter/material.dart';
class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.teal,
        leading:Icon(Icons.menu),
        title:Text('First App'),
        actions:[
          IconButton(
              icon:Icon(Icons.notification_important),
              onPressed:notification,
          ),
          IconButton(
              icon: Icon(Icons.search),
              onPressed: (){
                print('is searched');
              },
          ),
        ],
        centerTitle: true,
        elevation: 0.0,
      ),
      body:Column(
        children: [
          Image(
          image:NetworkImage
            (
                "https://cdn.pixabay.com/photo/2015/04/19/08/33/flower-729512_960_720.jpg",
          ),
            height: 300.0,
            width:300.0,
            fit: BoxFit.cover,
          ),
        ],
      )

    );
  }
void notification(){
    print('notification clicked');
}
}

