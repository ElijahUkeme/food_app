import 'package:food_app/data/api_client.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:get/get.dart';

class CustomerRepository{
  final ApiClient apiClient;

  CustomerRepository({required this.apiClient});

  Future<Response> getUserInfo(String token) async {
    return await apiClient.getData(AppConstants.CUSTOMER_INFO_URI+token);
  }
}