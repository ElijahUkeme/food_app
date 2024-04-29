import 'package:food_app/model/customer_model.dart';
import 'package:food_app/repository/customer_repository.dart';
import 'package:get/get.dart';

import '../base/show_custom_message.dart';
import '../model/registration_response_model.dart';
import '../model/sign_up_model.dart';

class CustomerController extends GetxController implements GetxService {
  final CustomerRepository customerRepository;

  CustomerController({required this.customerRepository});

  bool _isLoading = false;
  CustomerModel _customerModel =
      CustomerModel(id: 0, name: "", email: "", phone: "");

  bool get isLoading => _isLoading;
  CustomerModel get customerModel => _customerModel;

  Future<RegistrationResponseModel> getUserInfo(String token) async {
    Response response = await customerRepository.getUserInfo(token);
    late RegistrationResponseModel registrationResponseModel;
    if (response.statusCode == 200) {
      _isLoading = true;
      _customerModel = CustomerModel.fromJson(response.body);
      registrationResponseModel = RegistrationResponseModel(true, "Successful");
    } else {
      registrationResponseModel =
          RegistrationResponseModel(false, response.statusText!);
      //showCustomSnackBar(response.statusText.toString(),title: "Error");
    }
    update();
    return registrationResponseModel;
  }
}
