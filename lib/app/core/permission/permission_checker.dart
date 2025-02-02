import '../../features/auth/models/user_model.dart';

class PermissionChecker {
  static bool hasPermission(List<Role> roles, String action) {
    if (roles.isEmpty || action.isEmpty) {
      return false;
    }
    if (roles.any(
      (role) => role.name == 'admin',
    )) {
      return true;
    }
    return roles.any((role) =>
        role.permissions.any((permission) => permission.action.name == action));
  }
}
