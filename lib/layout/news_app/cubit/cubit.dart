import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/layout/news_app/cubit/states.dart';
import 'package:projects/modules/news_app/business/business_screen.dart';
import 'package:projects/modules/news_app/science/science_screen.dart';
import 'package:projects/modules/news_app/sports/sports_screen.dart';

import 'package:projects/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(InitialState());

  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItem = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.business,
      ),
      label: 'Business',),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: 'Sports',),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'Science',),
  ];

  List<Widget>screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    if (index == 1)
      getSportsData();
    else if (index == 2)
      getScienceData();
    emit(NewsChangeBottomNav());
  }

  List<dynamic> business = [];
  int selectBusinessItem=0;
  // List<bool> businessSelectedItem = [];

  void getBusinessData() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'business',
          'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
        }).then((value) {
      business = value.data['articles'];
      // business.forEach((element) {
      //   businessSelectedItem.add(false);
      // });
      emit(NewsGetBusinessSucessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error));
    });
  }
  void selectedBusinessItem(index)
  {
    // for(int i=0;i<businessSelectedItem.length;i++)
    // {
    //   if(i==index)
    //     businessSelectedItem[i]=true;
    //   else
    //     businessSelectedItem[i]=false;
    // }
    selectBusinessItem=index;
    emit(NewsSelectBusinessItemState());
  }

  List<dynamic> sports = [];

  void getSportsData() {
    emit(NewsGetSportsLoadingState());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'sports',
          'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
        }).then((value) {
      sports = value.data['articles'];
      emit(NewsGetSportsSucessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSportsErrorState(error));
    });
  }

  List<dynamic> science = [];

  void getScienceData() {
    emit(NewsGetScienceLoadingState());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'science',
          'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
        }).then((value) {
      science = value.data['articles'];
      emit(NewsGetScienceSucessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetScienceErrorState(error));
    });
  }

  List<dynamic> search = [];

  void getSearchData(String value) {
    search=[];
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(
        url: 'v2/everything',
        query: {
          'q': '$value',
          'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
        }).then((value) {
      search = value.data['articles'];
      emit(NewsGetSearchSucessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState(error));
    });
  }
}




