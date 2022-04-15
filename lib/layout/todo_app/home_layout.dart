import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/components.dart';

import 'package:projects/constants.dart';
import 'package:projects/shared/cubit/cubit.dart';
import 'package:projects/states.dart';
import 'package:sqflite/sqflite.dart';
// 1- creat database
// 2- create tables
// 3- open database
// 4- insert to database
// 5- get from database
// 6- update in database
// 7- delete from database

class HomeLayout extends StatelessWidget {



  var scaffold=GlobalKey<ScaffoldState>();
  var formKey=GlobalKey<FormState>();

  var titleController=TextEditingController();
  var timeController=TextEditingController();
  var dateController=TextEditingController();


  @override
  Widget build(BuildContext context) {
  return  BlocProvider(
   create: (BuildContext context)=>AppCubit()..creatDatabase(),
    child: BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        AppCubit cubit=AppCubit.get(context);
        return Scaffold(
          key:scaffold,
          appBar: AppBar(
            title:Text(cubit.titles[cubit.currentIndex]),
          ),
          body:ConditionalBuilder(
            condition:state is! AppGetDateBaseLoadingState,
         builder:(context)=> cubit.screens[cubit.currentIndex],
          fallback: (context)=>Center(child: CircularProgressIndicator()),
          ),
          floatingActionButton:FloatingActionButton(
            onPressed: ()
            {
               print('saber');
              // if(cubit.isBottomSheetShown)
              // {
              //   if(formKey.currentState.validate()) {
              //     //   insertToDatabase(
              //     //     title: titleController.text,
              //     //     date: dateController.text,
              //     //     time:timeController.text,
              //     //   ).then((value){
              //     //     // setState(()
              //     //     // {
              //     //     // fabIcon=Icons.edit;
              //     //     // });
              //     //     Navigator.pop(context);
              //     //     isBottomSheetShown=false;
              //     //   });
              //     // }
              //   }
              // }else
              // {
              //   scaffold.currentState.showBottomSheet(
              //         (context)=>Container(
              //       color: Colors.grey[300],
              //       padding: EdgeInsets.all(20.0),
              //       child: Form(
              //         key: formKey,
              //         child: Column(
              //           mainAxisSize:MainAxisSize.min,
              //           children: [
              //             defaultFormFeild(
              //               controller: titleController,
              //               type:TextInputType.text,
              //               validate:(String value){
              //                 if(value.isEmpty)
              //                 {
              //                   return'title must not be empty';
              //                 }
              //                 return null;
              //               },
              //               label: 'Task Title',
              //               prefix:Icons.title,
              //             ),
              //             SizedBox(
              //               height: 20.0,
              //             ),
              //             defaultFormFeild(
              //               controller: timeController,
              //               type:TextInputType.datetime,
              //               onTap:(){
              //                 showTimePicker(
              //                     context:context,
              //                     initialTime:TimeOfDay.now()
              //                 ).then((value){
              //                   timeController.text=value.format(context).toString();
              //                   print(value.format(context));
              //                 });
              //               } ,
              //               validate:(String value){
              //                 if(value.isEmpty)
              //                 {
              //                   return'time must not be empty';
              //                 }
              //                 return null;
              //               },
              //               label: 'Task Time',
              //               prefix:Icons.watch_later_outlined,
              //             ),
              //             SizedBox(
              //               height: 20.0,
              //             ),
              //             defaultFormFeild(
              //               controller: dateController,
              //               type:TextInputType.datetime,
              //               onTap:() {
              //                 showDatePicker(
              //                   context: context,
              //                   initialDate:DateTime.now(),
              //                   firstDate: DateTime.now(),
              //                   lastDate: DateTime.parse('2021-05-03'),
              //                 ).then((value){
              //                   print(value.toString());
              //                 });
              //               },
              //               validate:(String value){
              //                 if(value.isEmpty)
              //                 {
              //                   return'date must not be empty';
              //                 }
              //                 return null;
              //               },
              //               label: 'Task date',
              //               prefix:Icons.calendar_today,
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),);
              //   // setState(() {
              //   // fabIcon=Icons.add;
              //   // });
              //   //isBottomSheetShown=true;
              // }
            }
            //child:Icon(fabIcon),
            ),
          bottomNavigationBar: BottomNavigationBar(
            type:BottomNavigationBarType.fixed,
            currentIndex:cubit.currentIndex,
            onTap:(index){
              cubit.changeIndex(index);
            },
            items: [
              BottomNavigationBarItem(
                icon:Icon(
                  Icons.menu,),
                label: 'Tasks',
              ),
              BottomNavigationBarItem(
                icon:Icon(
                  Icons.check_circle_outline,),
                label: 'Done',
              ),
              BottomNavigationBarItem(
                icon:Icon(
                  Icons.archive_outlined,),
                label: 'Archived',
              ),
            ],
          ),
        );
      },
    ),
  );
  }


}




