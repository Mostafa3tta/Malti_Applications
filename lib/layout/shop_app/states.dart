import 'package:projects/models/shop_app/change_favorites_model.dart';
import 'package:projects/models/shop_app/login_model.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates{}

class ShopChangeBottomNavState extends ShopStates{}

class ShopLoadingHomeDataState extends  ShopStates{}
class ShopSuccessHomeDataState extends  ShopStates{}
class ShopErrorHomeDataState extends  ShopStates{
  final String error ;
  ShopErrorHomeDataState(this.error);
}

class ShopLoadingCategoriesState extends  ShopStates{}
class ShopSuccessCategoriesState extends ShopStates{}
 class ShopErrorCategoriesState extends ShopStates{}



 class ShopChangeFavoritesState extends ShopStates{}
class ShopSuccessChangeFavoritesState extends ShopStates{
  late  ChangeFavoritesModel model;
  ShopSuccessChangeFavoritesState(this.model);
}
class ShopErrorChangeFavoritesState extends ShopStates{}

class ShopLoadingFavoritesState extends ShopStates{}
class ShopSuccessFavoritesState extends ShopStates{}
class ShopErrorFavoritesState extends ShopStates{}

class ShopLoadingUserDataState extends ShopStates{}
class ShopErrorUserDataState extends ShopStates{}
class ShopSuccessUserDataState extends ShopStates
{
  late ShopLoginModel loginModel;

  ShopSuccessUserDataState(this.loginModel);
}
 class ShopLoadingUpdateUserState extends ShopStates{}
class ShopSuccessUpadteUserState extends ShopStates{
  final ShopLoginModel loginModel;

  ShopSuccessUpadteUserState(this.loginModel);


}
class ShopErrorUpdateUserState extends ShopStates{
  final String error;
  ShopErrorUpdateUserState(this.error);
}





