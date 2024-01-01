

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/state.dart';
import 'package:shop_app/shop%20model/login%20model.dart';

import '../dio helper.dart';

class ShopRegisterCubit extends Cubit<ShopLoginState>{
  ShopRegisterCubit(): super (ShopLoginInitialState());

  static ShopRegisterCubit get(context)=>BlocProvider.of(context);
  ShopLoginModel? loginModel;

  void userRegister({required email,required password,name,phone}){
    emit(ShopLoginLoadingState());

    DioHelper.postData(

      url:  'https://student.valuxapps.com/api/register',
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