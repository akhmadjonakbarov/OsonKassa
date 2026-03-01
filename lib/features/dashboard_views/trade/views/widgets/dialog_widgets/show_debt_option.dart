import 'package:flutter/material.dart';

import '../../../../../../styles/colors.dart';
import '../../../../../../styles/text_styles.dart';
import '../../../../../../utils/media/get_screen_size.dart';
import '../../../../../../utils/texts/button_texts.dart';
import '../../../../../../utils/texts/display_texts.dart';
import '../../../../../shared/widgets/buttons.dart';

class ShowDebtOption extends StatelessWidget {
  final Function() showBuilderDialog;
  final Function() addNewDebtInfoDialog;

  const ShowDebtOption(
      {super.key,
      required this.showBuilderDialog,
      required this.addNewDebtInfoDialog});

  @override
  Widget build(BuildContext context) {
    final screenSize = getScreenSize(context);
    return Container(
      margin: screenSize.width <= 1370
          ? EdgeInsets.symmetric(
              vertical: screenSize.height * 0.39,
              horizontal: screenSize.width * 0.33,
            )
          : EdgeInsets.symmetric(
              vertical: screenSize.height * 0.42,
              horizontal: screenSize.width * 0.35,
            ),
      child: Material(
        borderRadius: BorderRadius.circular(16),
        color: primary,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                DisplayTexts.setDebt,
                style: textStyleBlack28,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmallButtonText(
                    text: ButtonTexts.for_builder,
                    onClick: () {
                      Navigator.of(context).pop();
                      showBuilderDialog();
                    },
                    buttonSize: const Size(200, 60),
                    textStyle: textStyleBlack18,
                  ),
                  SmallButtonText(
                    text: ButtonTexts.add_new,
                    onClick: () {
                      Navigator.of(context).pop();
                      addNewDebtInfoDialog();
                    },
                    buttonSize: const Size(200, 60),
                    textStyle: textStyleBlack18,
                    bgColor: Colors.green,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
