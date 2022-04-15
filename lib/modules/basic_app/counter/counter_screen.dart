import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/modules/basic_app/counter/cubit/states.dart';


import 'cubit/cubit.dart';
class Counter_Screen extends StatelessWidget {
  @override

  @override
  Widget build(BuildContext context) {
    
        return BlocProvider(
          create: (BuildContext context)=>CounterCubit(CounterInitialStates()),
          child: BlocConsumer<CounterCubit,CounterStates>(
            listener:(context,state){} ,
            builder:(context,state)
    {
    return Scaffold
    (
    appBar: AppBar
    (
    title:Text
    (
    'Counter',
    ),
    ),
    body:Center(
    child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    TextButton(
    onPressed: ()
    {
    CounterCubit.get(context).minus();

    },
    child:Text('MINUS'),
    ),
    Padding
    (
    padding: const EdgeInsets.symmetric(
    horizontal: 20.0,
    ),
    child: Text('${CounterCubit.get(context).counter}',
    style:TextStyle(
    fontSize: 50.0,
    fontWeight: FontWeight.w900,
    ),),
    ),
    TextButton
    (
    onPressed: ()
    {
    CounterCubit.get(context).plus();
    },
    child:Text('PLUS'),
    ),
    ],
    ),
    ),
    );
    }
     )
    );
  }
  }



