import 'package:flutter/material.dart';

import '../../utils/media/get_screen_size.dart';

class ManageStoreScreen extends StatelessWidget {
  const ManageStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = getScreenSize(context);
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(vertical: size.height / 5),
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          children: [
            Text("Iltimos do'koningiz turini tanlang"),
          ],
        ),
      ),
    );
  }
}
