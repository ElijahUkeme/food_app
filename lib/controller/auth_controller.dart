import 'package:food_app/base/show_custom_message.dart';
import 'package:food_app/model/registration_response_model.dart';
import 'package:food_app/model/sign_up_model.dart';
import 'package:food_app/repository/auth_repository.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final AuthRepository authRepository;

  AuthController({
    required this.authRepository
});
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<RegistrationResponseModel>registration(SignUpModel signUpModel) async {
    _isLoading = true;
    update();
    Response response = await authRepository.registration(signUpModel);
    late RegistrationResponseModel registrationResponseModel;
    if(response.statusCode==201){
      authRepository.saveUserToken(response.body["token"]);
      registrationResponseModel = RegistrationResponseModel(true, response.body["message"]);
      showCustomSnackBar(response.body["message"],title: "Success");
    }else{
      registrationResponseModel = RegistrationResponseModel(false, response.statusText!);
      showCustomSnackBar(response.body["message"],title: "Error");
    }
    _isLoading = false;
    update();
    return registrationResponseModel;
  }

  Future<RegistrationResponseModel>login(String email, String password) async {
    _isLoading = true;
    update();
    Response response = await authRepository.login(email,password);
    late RegistrationResponseModel registrationResponseModel;
    if(response.statusCode==200){

      authRepository.saveUserToken(response.body["token"]);
      print("The token from the auth controller is "+response.body["token"]);
      registrationResponseModel = RegistrationResponseModel(true, response.body["message"]);
      showCustomSnackBar(response.body["message"],title: "Success");
    }else{
      registrationResponseModel = RegistrationResponseModel(false, response.statusText!);
      showCustomSnackBar(response.body["message"],title: "Error");
    }
    _isLoading = false;
    update();
    return registrationResponseModel;
  }
  void saveUserNumberAndPassword(String number, String password){
    authRepository.saveUserNumberAndPassword(number, password);
  }
  bool userLoggedIn(){
    print("The token from the controller is "+AppConstants.TOKEN);
    return authRepository.userLoggedIn();
  }

  String getUserToken(){
    return authRepository.retrieveUserToken();
  }
  bool clearSharedData(){
    return authRepository.clearSharedData();
  }
}