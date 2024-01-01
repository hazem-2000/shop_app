class ShopLoginModel {
  ShopLoginModel();
  bool? status;
  String message="";
  UserData data=UserData();
  ShopLoginModel.fromJson(Map<String,dynamic>json){

    status=json['status'];
    message=json['message'];
    data=(json['data']!=null?UserData.fromJson(json['data']):null)!;

  }

}

class UserData {
  int? id;
  late String name='';
  late String email='';
  late String phone='';
  String?image;
  late String token;
  int?points;
  int?credit;
  UserData();

/*
  UserData(
      {this.id, this.name, this.email, this.phone, this.image, this.token, this.points, this.credit});
*/

  UserData.fromJson(Map<String,dynamic>json){
    id=json['id'];
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    image=json['image'];
    token=json['token'];
    points=json['points'];
    credit=json['credit'];
  }
}