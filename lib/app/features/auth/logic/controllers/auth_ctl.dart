import 'package:get/get.dart';
import 'package:osonkassa/app/utils/helper/log_helper.dart';

import '../../../../config/app_paths.dart';
import '../../../../core/display/user_notifier.dart';
import '../../../../core/enums/type_of_snackbar.dart';
import '../../../../utils/helper/secure_storage.dart';
import '../../models/user.dart';
import '../repository/auth_repo.dart';
import '../services/auth_service.dart';

class AuthCtl extends GetxController {
  var error = ''.obs;
  var userModel = User.empty().obs;
  var accessToken = "".obs;

  final AuthService _authService = AuthService(authRepo: AuthRepo());
  final SecureStorage _secureStorage = SecureStorage();

  void auth() async {
    try {
      String? userModelData = await _secureStorage.read("userModel");
      String? _accessToken = await _secureStorage.read("token");

      if (userModelData != null && _accessToken != null) {
        User user = User.fromJson(userModelData);
        Get.toNamed(AppPaths.dashboard);

        userModel(user);
        accessToken.value = _accessToken;
      }
    } catch (e) {
      print(e);
      Get.snackbar("Error", e.toString());
    }
  }

  void login({required String email, required String password}) async {
    try {
      Map<String, dynamic> userMap =
          await _authService.login(login: email, password: password);
      final user = userMap['user'];
      if (user != null) {
        final userModelData = user.toJson();
        await _secureStorage.write("userModel", userModelData);
        await _secureStorage.write("token", userMap['token']);
        Get.toNamed(AppPaths.dashboard);
        userModel(user);
        accessToken.value = userMap['token'];
        LogHelper.logInfo(user.toString());
      } else {
        Get.snackbar("Error", "Wrong login or password");
      }
    } catch (e) {
      print(e);
      Get.snackbar("Error", e.toString());
    }
  }

  void register({
    required String email,
    required String password,
    required String password2,
    required String last_name,
    required String first_name,
  }) async {
    try {
      String? userModelData;
      if (password == password2) {
        User? user = await _authService.register(
          email: email,
          password: password,
          first_name: first_name,
          last_name: last_name,
          password2: password2,
        );

        if (user != null) {
          Get.toNamed(AppPaths.dashboard);
          userModelData = user.toJson();
          await _secureStorage.write("userModel", userModelData);
          userModel(user);
        } else {
          Get.snackbar("Error", "Registration failed");
        }
      } else {
        Get.snackbar("Error", "Passwords do not match");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  void resetPassword(
      {required String email, required String new_password}) async {
    try {
      bool isChanged = await _authService.changePassword(
          email: email, new_password: new_password);
      if (isChanged) {
        UserNotifier.showSnackBar(
          label: "Parol o'zgartirildi! Iltimos qaytadan tizimga kiring!",
          type: TypeOfSnackBar.success,
        );
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  void logout() {
    _secureStorage.delete("userModel");
    userModel(User.empty());
    Get.offNamed(AppPaths.auth);
  }
}
