

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/layout/shop_app/states.dart';
import 'package:projects/models/shop_app/categories_model.dart';
import 'package:projects/models/shop_app/change_favorites_model.dart';
import 'package:projects/models/shop_app/favorites_model.dart';
import 'package:projects/models/shop_app/home_model.dart';
import 'package:projects/models/shop_app/login_model.dart';
import 'package:projects/modules/shop_app/cateogries/cateogries_screen.dart';
import 'package:projects/modules/shop_app/favorities/favorities_screen.dart';
import 'package:projects/modules/shop_app/products/products_screen.dart';
import 'package:projects/modules/shop_app/settings/settings_screen.dart';
import 'package:projects/constants.dart';
import 'package:projects/shared/network/end_points.dart';
import 'package:projects/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget>bottomScreen =
  [
    ProductsScreen(),
    CateogriesScreen(),
    FavoritiesScreen(),
    SettingsScreen(),
  ];

  void ChangeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

 late HomeModel homeModel;
  Map<int,bool> favorites={};
  void getHomeData()
  {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token:token,
    ).then((value)
    {
      homeModel=HomeModel.fromJson(value.data);
      //print(homeModel.status);
      //print(homeModel.data.banners[0].image);
      homeModel.data.products.forEach((element)
      {
        favorites.addAll({
          element.id: element.in_favorites,
        });
      });
      print(favorites.toString());
      emit(ShopSuccessHomeDataState());
    }).catchError((error)
    {
      print(' error in the shopCubit${error.toString()}');
      emit(ShopErrorHomeDataState(error));
    });
  }

  late CategoriesModel categoriesModel;
  void getCategories()
  {
    emit(ShopLoadingCategoriesState());
    DioHelper.getData(
      url: GET_CATEGORIES,
      token:token,
    ).then((value)
    {
      categoriesModel=CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error)
    {
      print(' error in the shopCubit${error.toString()}');
      emit(ShopErrorCategoriesState());
    });
  }

   late ChangeFavoritesModel changeFavoritesModel;
  void changeFavorites(int productId)
  {
    favorites[productId] =! favorites[productId]!;
    emit(ShopChangeFavoritesState());
    DioHelper.postData(
        url: FAVORITES,
        data:{
          'product_id':productId,
        },
      token:token,
    ).then((value)
    {
      changeFavoritesModel=ChangeFavoritesModel.fromJson(value.data);
      print(value.data);
      if(!changeFavoritesModel.status)
      {
        favorites[productId] =! favorites[productId]!;
      }
      else
        {
          getFavorites();
        }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel));
    }
    ).catchError((error)
    {
      favorites[productId] =! favorites[productId]!;
      emit(ShopErrorChangeFavoritesState());
    });
  }

  late FavoritesModel favoritesModel;
  void getFavorites()
  {
    emit(ShopLoadingFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
      token:token,
    ).then((value)
    {
      favoritesModel=FavoritesModel.fromJson(value.data);
      emit(ShopSuccessFavoritesState());
    }).catchError((error)
    {
      print(' error in the shopCubit${error.toString()}');
      emit(ShopErrorFavoritesState());
    });
  }

  late ShopLoginModel userModel;
  void getUserData()
  {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token:token,
    ).then((value)
    {
      userModel=ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessUserDataState(userModel));
    }).catchError((error)
    {
      print(' error in the shopCubit${error.toString()}');
      emit(ShopErrorUserDataState());
    });
  }
  void updateUserData({
    required String name,
    required String email,
    required String phone,
})
  {
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(
      url:UPDATE_PROFILE,
      token:token,
      data:
      {
        'name':name,
        'email':email,
        'phone':phone,
      },
    ).then((value)
    {
      userModel =ShopLoginModel.fromJson(value.data);
      printFullText(userModel.data.name);
      emit(ShopSuccessUpadteUserState(userModel));
    }).catchError((error)
    {
      // print(error.toString());
      emit(ShopErrorUpdateUserState(error));
    });
  }

}


//   CategoriesModel cateogriesModel;
//   void getCategories()
//   {
//
//     DioHelper.getData(
//       url: GET_CATEGORIES,
//
//     ).then((value)
//     {
//       cateogriesModel =CategoriesModel.fromJson(value.data);
//       //printFullText(homeModel.toString());
//       emit(ShopSuccessCategoriesState());
//     }).catchError((error)
//     {
//       print(error.toString());
//       emit(ShopErrorCategoriesState());
//     });
//   }

//
//   ShopLoginModel userModel;
//   void getUserData()
//   {
//     emit(ShopLoadingUserDataState());
//     DioHelper.getData(
//       url: PROFILE,
//       token:token,
//     ).then((value)
//     {
//       userModel =ShopLoginModel.fromJson(value.data);
//       printFullText(userModel.data.name);
//       emit(ShopSuccessUserDataState(userModel));
//     }).catchError((error)
//     {
//     // print(error.toString());
//       emit(ShopErrorUserDataState());
//     });
//   }
//
//
//
// }