import 'package:flutter/material.dart';

class HeaderTitle extends StatelessWidget {
  final String title;
  final TextStyle textStyle;
  final EdgeInsets padding;
  final bool isList;

  const HeaderTitle({
    super.key,
    required this.title,
    this.textStyle = const TextStyle(
      fontSize: 20,
      color: Colors.black,
    ),
    this.padding = const EdgeInsets.symmetric(vertical: 10),
    this.isList = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text(
        isList ? "eCommerce / $title Ro'yhati" : "eCommerce / $title",
        style: textStyle.copyWith(color: Colors.black),
      ),
    );
  }
}

class HeaderTitle2 extends StatelessWidget {
  final String title;
  final TextStyle textStyle;
  final EdgeInsets padding;

  const HeaderTitle2({
    super.key,
    required this.title,
    this.textStyle = const TextStyle(
      fontSize: 20,
      color: Colors.white,
    ),
    this.padding = const EdgeInsets.symmetric(vertical: 10),
  });

  @override
  Widget build(BuildContext context) {
    String capitalizedTitle = title[0].toUpperCase() + title.substring(1);
    return Padding(
      padding: padding,
      child: Text(
        capitalizedTitle,
        style: textStyle.copyWith(color: Colors.black),
      ),
    );
  }
}
