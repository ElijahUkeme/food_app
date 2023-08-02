
import 'package:food_app/utils/app_constants.dart';
import 'package:get/get.dart';

class ApiClient extends GetConnect implements GetxService{
  late String token;
  final String appBaseUrl;
  late Map<String,String> _mainHeaders;
  ApiClient({required this.appBaseUrl}){
    baseUrl = appBaseUrl;
    timeout=Duration(minutes: 5);
    token = AppConstants.TOKEN;
    _mainHeaders = {
      'Content-type':'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }
  updateHeader(String token){
    _mainHeaders = {
      'Content-type':'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }
  Future<Response> getData(String uri) async {
    try{
      Response response =await get(uri);
      return response;
    }catch(e){
      print("Error from the api client is "+e.toString());
      return Response(statusCode: 1,statusText: e.toString());

    }
  }
  Future<Response> postData(String uri,dynamic body) async {
    print("Inside api client body "+body.toString());
    try{
      Response response = await post(uri, body,headers: _mainHeaders);
      print("Inside api client response "+response.toString());
      return response;
    }catch(e){
      print("Error from the post request is "+e.toString());
      return Response(statusCode: 1,statusText: e.toString());
    }
  }
}