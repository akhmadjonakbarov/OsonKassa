import 'package:osonkassa/app/features/auth/models/user_model.dart';

class PermissionChecker {
  static bool hasPermission(List<RoleModel> permissions, String action) {
    if (permissions.isEmpty || action.isEmpty) {
      return false;
    }
    bool hasPermission = false;
    for (RoleModel role in permissions) {
      for (PermissionModel permission in role.permissions) {
        if (action == permission.action.name) {
          hasPermission = true;
          break;
        }
      }
    }
    return hasPermission;
  }
}
