import 'package:flutter/material.dart';
import 'package:shop_app/cubit/home%20cubit.dart';

class FavScreen extends StatelessWidget {
  const FavScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget buildItem(int index) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [

            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Container(
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        "${ShopCubit.get(context).card[index]}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if(index==ShopCubit.get(context).card.length-1)
                      Text(
                        "Total price : ${ ShopCubit.get(context).sum}",
                        style: TextStyle(color: Colors.red,fontSize: 20),
                      ),
                    if(index==ShopCubit.get(context).card.length-1)
                      Material(
                        elevation: 25,
                        child: MaterialButton(
                          onPressed: () {

                          },
                          color:Color.fromARGB(255, 26, 114, 201),
                          height: 50,
                          child: Text(
                            'Check out'.toUpperCase(),
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ),
                        ),
                      ),

                  ],
                ),
              ),
            )
          ],
        ),
      );
    }

    return ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildItem(index),
        separatorBuilder: (context, index) => Divider(),
        itemCount: ShopCubit.get(context).card.length);
  }
}
