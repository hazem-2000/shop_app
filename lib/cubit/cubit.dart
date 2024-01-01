

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/state.dart';
import 'package:shop_app/dio%20helper.dart';
import 'package:shop_app/shop%20model/login%20model.dart';


class ShopLoginCubit extends Cubit<ShopLoginState>{
  ShopLoginCubit(): super (ShopLoginInitialState());

  static ShopLoginCubit get(context)=>BlocProvider.of(context);
  ShopLoginModel? loginModel;

  void userLogin({required email,required password,name,phone}){
    emit(ShopLoginLoadingState());

    DioHelper.postData(

      url:  'https://student.valuxapps.com/api/login',
      data: {
        'email':email,
        'password':password,
        'name':name,
        'phone':phone
      },

    ).then((value) {
      print(value.data);
      loginModel= ShopLoginModel.fromJson(value.data);
     // print(loginModel!.data!.token);
      //print(loginModel!.message);
      emit(ShopLoginSuccessState(loginModel!));
    } ).catchError((error){
      print(error);
      emit(ShopLoginErrorState(error.toString()));
    });

  }
}