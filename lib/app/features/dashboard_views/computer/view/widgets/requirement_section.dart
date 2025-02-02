
import 'package:flutter/material.dart';

import '../../../../../styles/text_styles.dart';
import '../../../../../utils/media/get_screen_size.dart';

class RequirementSection extends StatelessWidget {
  const RequirementSection({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final screenSize = getScreenSize(context);
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: screenSize.height / 85,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyles.black(),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Text(
                    "256gb ${index % 2 == 1 ? "(hdd)" : "(sdd)"}",
                    style: TextStyles.black(fontSize: screenSize.height / 55),
                  ),
                  Checkbox(
                    value: false,
                    onChanged: (value) {},
                  )
                ],
              );
            },
            itemCount: 25,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 4,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
            ),
          )
        ],
      ),
    );
  }
}
