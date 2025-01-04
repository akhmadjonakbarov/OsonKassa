import 'package:get/get.dart';

class TokenCtl extends GetxController {
  var token = ''.obs;

  void setToken(String newToken) {
    token.value = newToken;
  }
}
