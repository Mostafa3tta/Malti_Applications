
import 'package:projects/models/shop_app/login_model.dart';

abstract  class SocialRegisterStates{}

class ShopRegisterInitialState extends SocialRegisterStates{}
class ShopRegisterLoadingState extends SocialRegisterStates{}
class ShopRegisterSuccessState extends SocialRegisterStates{
  late ShopLoginModel loginModel;

  ShopRegisterSuccessState(this.loginModel);

}
class ShopRegisterErrorState extends SocialRegisterStates{
  late String error;
  ShopRegisterErrorState(this.error);
}

class ShopChangePasswordState extends SocialRegisterStates{}

