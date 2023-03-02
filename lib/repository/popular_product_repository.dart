import 'package:food_app/data/api_client.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:get/get.dart';

class PopularProductRepository extends GetxService{
  final ApiClient apiClient;
  PopularProductRepository({required this.apiClient});

  Future<Response> getPopularProductList()async{
    return await apiClient.getData(AppConstants.POPULAR_PRODUCTS_URI);
  }
}