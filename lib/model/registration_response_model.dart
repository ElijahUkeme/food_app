
class RegistrationResponseModel{
  bool _isSuccess;
 String _message;
 RegistrationResponseModel(this._isSuccess,this._message);

 String get message =>_message;
 bool get isSuccess => _isSuccess;
}