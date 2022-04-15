
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:projects/layout/news_app/cubit/cubit.dart';

import '../../../components.dart';



class SportsScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var list =NewsCubit.get(context).sports;
    return articleBuilder(list);


      //Container();

    // return BlocConsumer<NewsCubit,NewsStates>
    //   (
    //   listener:(context,state){},
    //   builder:(context,state){
    //
    //     var list=NewsCubit.get(context).sports;
    //     return articleBuilder(list,context);
    //   } ,
    // );
  }
}
