import '../../models/user_model.dart';
import '../repository/auth_repo.dart';

class AuthService {
  AuthRepo authRepo;

  AuthService({required this.authRepo});

  Future<UserModel?> login(
      {required String login, required String password}) async {
    try {
      return await authRepo.login(email: login, password: password);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel?> register({
    required String email,
    required String password,
    required String password2,
    required String last_name,
    required String first_name,
  }) async {
    try {
      return await authRepo.register(
        email: email,
        password: password,
        password2: password2,
        last_name: last_name,
        first_name: first_name,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> changePassword(
      {required String email, required String new_password}) async {
    return await authRepo.changePassword(
        email: email, new_password: new_password);
  }
}
