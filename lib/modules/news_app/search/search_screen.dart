import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/components.dart';
import 'package:projects/layout/news_app/cubit/cubit.dart';
import 'package:projects/layout/news_app/cubit/states.dart';
class SearchScreen extends StatelessWidget {
  var searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener:(context,state){},
      builder: (context,state){
        return  BlocConsumer<NewsCubit,NewsStates>(
          listener: (context,state){},
          builder: (context,state){
            var list=NewsCubit.get(context).search;
            return Scaffold(
              appBar: AppBar(),
              body:Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: defaultFormFeild(
                        controller: searchController,
                        type:TextInputType.text,
                        onChange: (value){
                          NewsCubit.get(context).getSearchData(value);
                        },
                        validate:(String value)
                        {
                          if(value.isEmpty){
                            return'search must not be empty';
                          }
                          return null;
                        },
                        label:'Search',
                        prefix:Icons.search),
                  ),
                  Expanded(child: articleBuilder(list,isSearch:true)),
                ],
              ),
            );          },
        );
      },
    );
  }
}

