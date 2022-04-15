import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:projects/modules/bmi_app/bmi_result/bmi_result_screen.dart';

class BmiScreen extends StatefulWidget {

  @override
  _BmiScreenState createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  bool isMale=true;
  double height=120.0;
  double weight=40.0;
  int age=20;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text(
          'BMI Calculator',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child:Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          isMale=true;
                        });
                      },
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                             // border:BoxBorder.c,
                             Image(
                               image:AssetImage('assets/images/male.png'),
                               height: 90.0,
                               width: 90.0,
                             ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Text('MALE',
                                style:TextStyle(
                                  color:Colors.black,
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                ),),
                            ],
                          ),
                        ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color:isMale?Colors.blue:Colors.grey[400],
                      ),
                      ),
                    ),
                  ),
                   SizedBox(
                     width: 20.0,
                   ),
                   Expanded(
                     child: GestureDetector(
                       onTap: (){
                         setState(() {
                           isMale=false;
                         });
                       },
                       child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // border:BoxBorder.c,
                              Image(
                                image:AssetImage('assets/images/female.png'),
                                height: 90.0,
                                width: 90.0,
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Text('FEMALE',
                                style:TextStyle(
                                  color:Colors.black,
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                ),),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color:!isMale?Colors.blue:Colors.grey[400],
                        ),
                  ),
                     ),
                   ),
                ],
              ),
            ),
          ), 
           Expanded(
             child: Padding(
               padding: const EdgeInsets.symmetric(
                   horizontal: 20.0,),
               child: Container(
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Text('HEIGHT',
                     style:TextStyle(
                       fontSize: 30.0,
                       fontWeight: FontWeight.bold,
                     ),),
                     SizedBox(
                       height: 5.0,
                     ),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                       crossAxisAlignment:CrossAxisAlignment.baseline,
                       textBaseline:TextBaseline.alphabetic ,
                       children: [
                         Text('${height.round()}',
                           style:TextStyle(
                             fontSize: 40.0,
                             fontWeight: FontWeight.bold,
                           ),
                         ),
                         SizedBox(
                           width: 5.0,
                         ),
                         Text('CM',
                         style: TextStyle(
                           fontSize: 25.0,
                           fontWeight: FontWeight.bold,
                         ),),
                       ],
                     ),
                     Slider(value:height,
                         max: 220.0,
                         min: 80.0,
                         onChanged: (value)
                         {
                       setState(() {
                         height=value;
                       });

                         },)
                   ],
                 ),
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(10.0),
                   color:Colors.grey[400],
                 ),
               ),
             ),
           ),
           Expanded(
             child:Padding(
               padding: const EdgeInsets.all(20.0),
               child: Row(
                 children: [
                   Expanded(
                     child: Container(
                       child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                         //crossAxisAlignment: CrossAxisAlignment.center,
                         children:[
                       Text(' WEIGHT',
                         style:TextStyle(
                           fontSize: 30.0,
                           fontWeight: FontWeight.bold,
                         ),),
                       Text('${weight.round()}',
                         style:TextStyle(
                           fontSize: 40.0,
                           fontWeight: FontWeight.bold,
                         ),
                       ),
                       Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                       children:[
                         FloatingActionButton(onPressed:(){
                           setState(() {
                             weight--;
                           });
                         },
                           heroTag: 'weight-',
                         mini:true,
                         child:Icon(Icons.remove),),
                       FloatingActionButton(onPressed:(){
                         setState(() {
                           weight++;
                         });
                       },
                         heroTag: 'weight+',
                         mini:true,
                         child:Icon(Icons.add),),
                           ],),
               ],
           ),
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(20.0),
                         color:Colors.grey[400],
                       ),
                     ),
                   ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                         //crossAxisAlignment: CrossAxisAlignment.center,
                         children:[
                           Text('AGE',
                             style:TextStyle(
                               fontSize: 30.0,
                               fontWeight: FontWeight.bold,
                             ),),
                           Text('${age.round()}',
                             style:TextStyle(
                               fontSize: 40.0,
                               fontWeight: FontWeight.bold,
                             ),
                           ),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children:[
                               FloatingActionButton(onPressed:(){
                                 setState(() {
                                   age--;
                                 });
                               },
                                 heroTag: 'age-',
                                 mini:true,
                                 child:Icon(Icons.remove),),
                               FloatingActionButton(
                                 onPressed:(){
                                   setState(() {
                                     age++;
                                   });
                               },
                                 heroTag: 'age+',
                                 mini:true,
                                 child:Icon(Icons.add),),
                             ],),
                         ],
                   ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color:Colors.grey[400],
                        ),
                      ),
                    ),
                 ],
          ),
             ),
           ),
          Container(
            color:Colors.blue,
            width: double.infinity,
            height: 70.0,
            child: MaterialButton(onPressed:(){
              var result=weight/pow(height/100,2);
              print(result.round());
           Navigator.push(context,
           MaterialPageRoute(
             builder:(context)=>BmiResultScreen(
               result:result.round(),
               age:age,
               isMale:isMale,
             )
             ,),
             );
            },
            child:Text('Calculator',
            style:TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color:Colors.white
            ),),),
          )
        ],
      ),
    );
  }
}
