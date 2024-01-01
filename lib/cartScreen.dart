import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/home%20cubit.dart';
import 'package:shop_app/cubit/home%20states.dart';

class CartScreen extends StatelessWidget {
  final String image;
  final String name;
  dynamic price;
  dynamic oldPrice;

  CartScreen(
      {required this.image,
      required this.name,
      required this.price,
      required this.oldPrice});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        int totalPrice=price*ShopCubit.get(context).quant;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image(
                  image: NetworkImage(image),
                  height: 200,
                  width: double.infinity,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        //maxLines: 2,
                        //overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                          height: 1.3,
                        ),
                      ),
                      Row(
                        children: [
                          Text('old price : '),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '$oldPrice',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Text(
                    'Total price : $totalPrice',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                    child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 214, 225, 237),
                            borderRadius: BorderRadius.circular(10)),
                        height: 40,
                        width: 40,
                        //color: Colors.grey,
                        child: Center(
                          child: Text(
                            '${ShopCubit.get(context).quant}',
                            style: TextStyle(fontSize: 20),
                          ),
                        ))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Material(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 25,
                      clipBehavior: Clip.antiAlias,
                      child: MaterialButton(
                        minWidth: 150,
                        onPressed: () {
                          ShopCubit.get(context).x=0;
                          ShopCubit.get(context).decrementQuant();
                        },
                        color: Color.fromARGB(255, 26, 114, 201),
                        height: 50,
                        child: Text(
                          '-'.toUpperCase(),
                          style: TextStyle(
                              fontSize: 25, color: Colors.white),
                        ),
                      ),
                    ),
                    /*SizedBox(
                                    width: 40,
                                  ),*/
                    Spacer(),
                    SizedBox(
                      height: 150,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Material(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 25,
                          clipBehavior: Clip.antiAlias,
                          child: MaterialButton(
                            minWidth: 150,
                            onPressed: () {
                              ShopCubit.get(context).x=0;
                              ShopCubit.get(context).incrementQuant();
                            },
                            color:
                            Color.fromARGB(255, 26, 114, 201),
                            height: 50,
                            child: Text(
                              '+'.toUpperCase(),
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                Material(
                  elevation: 25,
                  child: MaterialButton(
                    onPressed: () {
                      ShopCubit.get(context).sum+=totalPrice;
                      print('sum = ${ ShopCubit.get(context).sum}');
                      ShopCubit.get(context).addToCard(name);
                      Navigator.pop(context, ShopCubit.get(context).sum);
                    },
                    color:Color.fromARGB(255, 26, 114, 201),
                    height: 50,
                    child: Text(
                      'add to card'.toUpperCase(),
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },

    );
  }
}
