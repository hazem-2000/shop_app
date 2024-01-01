import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cartScreen.dart';
import 'package:shop_app/cubit/home%20cubit.dart';
import 'package:shop_app/cubit/home%20states.dart';
import 'package:shop_app/search%20screen.dart';
import 'package:shop_app/shop%20model/home%20model.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ShopCubit cubit = ShopCubit.get(context);
          int x = 0;
          return ConditionalBuilder(
            condition: ShopCubit.get(context).homeModel != null,
            builder: (context) =>
                productsBuilder(ShopCubit.get(context).homeModel, context),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        });
  }
}

Widget productsBuilder(HomeModel model, context) => SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          CarouselSlider(
            items: model.data!.banners
                .map((e) => Image(
                      image: NetworkImage(
                          '${model.data!.banners[ShopCubit.get(context).x++]['image']}'),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ))
                .toList(),
            options: CarouselOptions(
              height: 250,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            childAspectRatio: 1 / 1.58,
            children: List.generate(
              model.data!.products.length,
              (index) => Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return CartScreen(
                              image: model.data!.products[index]['image'],
                              name: model.data!.products[index]['name'],
                              price: model.data!.products[index]['price'],
                              oldPrice: model.data!.products[index]['old_price'],
                            );
                          }),
                        );
                        print(model.data!.products[index]['id']);
                      },
                      child: Stack(
                        alignment: AlignmentDirectional.bottomStart,
                        children: [
                          Image(
                            image: NetworkImage(
                                model.data!.products[index]['image']),
                            height: 200,
                            width: double.infinity,
                          ),
                          if (model.data!.products[index]['discount'] != 0)
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 5,
                              ),
                              color: Colors.red,
                              child: Text(
                                'Discount',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model.data!.products[index]['name'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                              height: 1.3,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                '${model.data!.products[index]['price']}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              if (model.data!.products[index]['discount'] != 0)
                                Text(
                                  '${model.data!.products[index]['old_price']}',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              /*Spacer(),
                              IconButton(
                                onPressed: () {

                                },
                                icon: CircleAvatar(
                                  radius: 15,
                                    backgroundColor: Colors.grey,
                                    child: Icon(
                                  Icons.favorite_border,
                                      color: Colors.white,
                                )),
                              ),*/
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
