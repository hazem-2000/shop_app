import 'package:shop_app/shop%20model/login%20model.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates{}

class ShopChangeBottomNavState extends ShopStates{}

class ShopLoadingDataHomeState extends ShopStates{}

class ShopSuccessDataHomeState extends ShopStates{}

class ShopErrorDataHomeState extends ShopStates{}

class ShopSuccessDataCategoriesState extends ShopStates{}

class ShopErrorDataCategoriesState extends ShopStates{}

class ShopLoadingUserDataState extends ShopStates{}

class ShopSuccessUserDataState extends ShopStates{
  final ShopLoginModel loginModel;

  ShopSuccessUserDataState(this.loginModel);
}

class ShopErrorUserDataState extends ShopStates{}

class ShopIncrementQ extends ShopStates{}

class ShopDecrementQ extends ShopStates{}