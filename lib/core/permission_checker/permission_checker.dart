import 'package:flutter/material.dart';

import '../../features/shared/widgets/buttons.dart';
import '../../styles/icons.dart';
import '../../styles/text_styles.dart';
import '../../utils/texts/button_texts.dart';

class PermissionCheckerS {
  static Widget addButton(String role, Function() onClick, Size buttonSize) {
    switch (role) {
      case 'manager' || 'admin':
        return CustomButton2(
          text: ButtonTexts.add,
          icon: AppIcons.plus,
          iconColor: Colors.white,
          buttonBgColor: Colors.blueAccent,
          onClick: () => onClick(),
          buttonSize: buttonSize,
          textStyle: textStyleBlack18.copyWith(
            color: Colors.white,
            fontSize: 20,
          ),
        );
      default:
        return const SizedBox
            .shrink(); // Return empty widget for non-seller roles
    }
  }
}
