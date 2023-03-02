import 'package:food_app/data/api_client.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:get/get.dart';

class RecommendedProductRepository extends GetxService{
  final ApiClient apiClient;
  RecommendedProductRepository({required this.apiClient});

  Future<Response> getRecommendedProductList()async{
    return await apiClient.getData(AppConstants.RECOMMENDED_PRODUCTS_URI);
  }
}