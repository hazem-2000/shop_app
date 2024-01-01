import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/home%20cubit.dart';
import 'package:shop_app/dio%20helper.dart';
import 'package:shop_app/end%20point.dart';
import 'package:shop_app/share%20pref/cach%20helper.dart';
import 'package:shop_app/shop_layout.dart';

import 'cubit/home states.dart';
import 'login.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();//يتاكد كلشي شغال في الميثود بعدين بشغل البرنامج
  DioHelper.init();
  await CacheHelper.init();

  Widget? widget;
  //String? token;
  token=CacheHelper.getData(key:'token');

  if(token!=null){
    widget=ShopLayout();
  }else
    widget=ShopLoginScreen();

  runApp(MyApp(startWidget: widget,));
}

class MyApp extends StatelessWidget {
  final startWidget;
  MyApp({this.startWidget});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context)=>ShopCubit()..getHomeData()..getCatData()..getUserData())
    ],
        child:BlocConsumer<ShopCubit,ShopStates>(
          listener: (context,state){},
          builder: (context,state){
            return MaterialApp(
              debugShowCheckedModeBanner: false,

              home:startWidget,
            );
          },
        )
    );
  }
}


