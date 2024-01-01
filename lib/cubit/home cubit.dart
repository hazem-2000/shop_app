import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/catagories%20screen.dart';
import 'package:shop_app/cubit/home%20states.dart';
import 'package:shop_app/dio%20helper.dart';
import 'package:shop_app/end%20point.dart';
import 'package:shop_app/fav%20screen.dart';
import 'package:shop_app/products%20screen.dart';
import 'package:shop_app/settings%20screen.dart';
import 'package:shop_app/shop%20model/categories%20model.dart';
import 'package:shop_app/shop%20model/home%20model.dart';
import 'package:shop_app/shop%20model/login%20model.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  int x=0;//count in product screen
  int quant=1;
  int sum=0;
  String token='';


  List<Widget> bottomsScreen = [
    ProductScreen(),
    Categories(),
    FavScreen(),
    SettingsScreen(),
  ];



  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }
  CategoriesModel categoriesModel=CategoriesModel();
   HomeModel  homeModel=HomeModel();
   Map<int,bool>fav={};
   final List<dynamic> card=[];



  void getHomeData() {
    emit(ShopLoadingDataHomeState());

    DioHelper.getData(
        url: 'https://student.valuxapps.com/api/home',


    ).then((value) {
      homeModel=HomeModel.fromJson(value.data);
      //print(homeModel.data!.banners[0]);
      //print(homeModel.status);
      homeModel.data!.products.forEach((element) {
        fav.addAll({
          element.id: element.inFavorate,
        });
      });
      print(fav.toString());
      emit(ShopSuccessDataHomeState());
    }).catchError((error){
      print(error);
      emit(ShopErrorDataHomeState());
    });
  }

  addToCard(String name){

    card.add(name);


    print('hooo $card');
  }

  void incrementQuant(){
    quant++;
    emit(ShopIncrementQ());
  }

  void decrementQuant(){
    quant--;
    emit(ShopDecrementQ());
  }

  void getCatData() {
    emit(ShopLoadingDataHomeState());

    DioHelper.getData(
      url: 'https://student.valuxapps.com/api/categories',


    ).then((value) {
      categoriesModel=CategoriesModel.fromJson(value.data);
      emit(ShopSuccessDataCategoriesState());
    }).catchError((error){
      print(error);
      emit(ShopErrorDataCategoriesState());
    });
  }

  ShopLoginModel userModel=ShopLoginModel();

  void getUserData(){
    emit(ShopLoadingUserDataState());
    DioHelper.getData(url: '  https://student.valuxapps.com/api/profile',token: token).then((value) {
      userModel=ShopLoginModel.fromJson(value.data);
      print(userModel.data.name);
      emit(ShopSuccessUserDataState(userModel));
    }).catchError((error){
      print(error);
      emit(ShopErrorUserDataState());
    });
  }

}
