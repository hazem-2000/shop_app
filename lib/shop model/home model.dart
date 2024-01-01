class HomeModel {
  HomeModel();
  bool? status;
  HomeDataModel? data;
   int x=0;//count in product screen

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel {
  List banners = [];
  List products = [];

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((elements) {
      banners.add(elements);
    });

    json['products'].forEach((elements) {
      products.add(elements);
    });
  }
}

class BannersModel {
   int? id;
   String? image;

  BannersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductsModel {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  bool? inFavorite;
  bool? inCart;

  ProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorite = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
