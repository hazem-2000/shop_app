import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/home%20cubit.dart';
import 'package:shop_app/cubit/home%20states.dart';
import 'package:shop_app/search%20screen.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return SearchScreen();
                  }));
                },
                icon: Icon(Icons.search),
                color: Colors.black,
              )
            ],
            title: Text(
              "Salla",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
          ),
          body: cubit.bottomsScreen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(

            unselectedItemColor: Colors.grey,
            fixedColor: Colors.black,
            backgroundColor: Colors.black,
            onTap: (index) {
              cubit.changeBottom(index);
              cubit.x=0;
              print('hazewwm${cubit.userModel.data.name}');
            },

            currentIndex: cubit.currentIndex,

            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.apps),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.card_travel_outlined),
                label: 'Card',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',

              ),

            ],
          ),

        );
      },
    );
  }
}
