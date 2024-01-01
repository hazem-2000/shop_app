import 'package:dio/dio.dart';
import 'package:shop_app/end%20point.dart';

class DioHelper {
  static Dio dio=Dio();

  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: LOGIN,
          receiveDataWhenStatusError: true,
         ),
    );
  }



  static Future<Response> getData(

      {required String url,  dynamic query,String lang="en",String? token}) async {
    dio.options.headers = {
      'Content-Type':'application/json',
      "lang":lang,
      "Authorization":token??'',
    };
    return await dio.get(url, queryParameters: query??null);
  }

  static Future<Response> postData(
      {required String url,  Map<String,dynamic>? query, required Map<String,dynamic> data,String lang="ar",String? token}) async {
    dio.options.headers={
      'Content-Type':'application/json',
      "lang":lang,
      "Authorization":token??'',
    };
    return await dio.post(url, queryParameters: query, data: data);
  }
}
