
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/components.dart';
import 'package:projects/layout/news_app/cubit/cubit.dart';
import 'package:projects/layout/news_app/cubit/states.dart';
import 'package:responsive_builder/responsive_builder.dart';
class BusinessScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
         listener:(context,state){},
          builder:(context,state){
            var list =NewsCubit.get(context).business;
            return ScreenTypeLayout(
              mobile:  articleBuilder(list),
              desktop: Row(
                children: [
                  Expanded(child: articleBuilder(list)),
                  if(list.length>0)
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      color:Colors.grey[200],
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          '${list[NewsCubit.get(context).selectBusinessItem]['description']}'
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              breakpoints: ScreenBreakpoints
                (
                desktop:600 ,
                tablet: 600,
                watch:100 ,
              ),
            );
          });
  }
}
