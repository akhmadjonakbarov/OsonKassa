// ignore_for_file: deprecated_member_use

import 'package:osonkassa/app/styles/colors.dart';
import 'package:osonkassa/app/utils/media/get_screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../styles/text_styles.dart';

class CustomButton extends StatefulWidget {
  final String icon;
  final double iconWidth;
  final double iconHeight;
  final Color? iconColor;
  final String text;
  final Size buttonSize;
  final TextStyle textStyle;
  final Color buttonBgColor;
  final Function() onClick;
  final bool isSelecte;
  final int count;

  const CustomButton({
    super.key,
    required this.text,
    required this.icon,
    required this.buttonBgColor,
    required this.onClick,
    this.iconColor,
    required this.buttonSize,
    required this.textStyle,
    this.isSelecte = false,
    this.iconHeight = 20,
    this.iconWidth = 20,
    this.count = 0,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  late Color buttonColor;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = getScreenSize(context);
    setState(() {
      buttonColor = widget.isSelecte == true ? bgButtonColor : secondary;
    });
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        fixedSize: widget.buttonSize,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // <-- Radius
        ),
      ),
      onPressed: widget.onClick,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                widget.icon,
                color: widget.iconColor,
                width: widget.iconWidth,
                height: widget.iconHeight,
              ),
              const SizedBox(width: 8), // Add some space between icon and text
              if (screenSize.width <= 1370)
                FittedBox(
                  child: Text(
                    widget.text,
                    softWrap: true,
                    style: widget.textStyle.copyWith(
                      fontSize: widget.isSelecte == true ? 16 : 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              else
                FittedBox(
                  child: Text(
                    widget.text,
                    style: widget.textStyle.copyWith(
                      fontSize: widget.isSelecte == true ? 18 : 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
            ],
          ),
          if (widget.count != 0)
            Container(
              width: 45,
              height: 38,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  color: Colors.yellow, shape: BoxShape.circle),
              child: Text(
                widget.count.toString(),
                style: textStyleBlack18Bold,
              ),
            )
        ],
      ),
    );
  }
}

class CustomButton2 extends StatefulWidget {
  final String? icon;
  final double iconWidth;
  final double iconHeight;
  final Color iconColor;
  final String text;
  final Size buttonSize;
  final TextStyle textStyle;

  final Color buttonBgColor;
  final Function() onClick;
  final bool isSelecte;

  const CustomButton2({
    super.key,
    required this.text,
    this.icon,
    required this.buttonBgColor,
    required this.onClick,
    this.iconColor = Colors.black,
    required this.buttonSize,
    required this.textStyle,
    this.isSelecte = false,
    this.iconHeight = 20,
    this.iconWidth = 20,
  });

  @override
  State<CustomButton2> createState() => _CustomButton2State();
}

class _CustomButton2State extends State<CustomButton2> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.buttonBgColor,
        fixedSize: widget.buttonSize,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // <-- Radius
        ),
      ),
      onPressed: widget.onClick,
      child: widget.icon == null
          ? FittedBox(
              child: Text(
                widget.text,
                style: widget.textStyle,
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.icon != null)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        widget.icon!,
                        color: widget.iconColor,
                        width: widget.iconWidth,
                        height: widget.iconHeight,
                      ),
                      const SizedBox(width: 8),
                    ],
                  ), // Add some space between icon and text
                FittedBox(
                  child: Text(
                    widget.text,
                    style: widget.textStyle,
                  ),
                ),
              ],
            ),
    );
  }
}

class SmallButtonText extends StatelessWidget {
  final String text;
  final Size buttonSize;
  final TextStyle textStyle;
  final bool isNegative;
  final Color? bgColor;
  final Function() onClick;

  const SmallButtonText(
      {super.key,
      this.isNegative = false,
      required this.text,
      required this.onClick,
      required this.buttonSize,
      required this.textStyle,
      this.bgColor});

  @override
  Widget build(BuildContext context) {
    Color buttonColor =
        isNegative == true ? Colors.red.shade700 : bgButtonColor;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor ?? buttonColor,
        fixedSize: buttonSize,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // <-- Radius
        ),
      ),
      onPressed: onClick,
      child: Text(
        text,
        style: textStyle.copyWith(color: Colors.white),
      ),
    );
  }
}

class DialogTextButton extends StatelessWidget {
  final String text;

  final TextStyle textStyle;
  final bool isNegative;
  final Color? bgColor;
  final Function() onClick;

  const DialogTextButton({
    super.key,
    this.isNegative = false,
    required this.text,
    required this.onClick,
    required this.textStyle,
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    Color buttonColor =
        isNegative == true ? Colors.red.shade700 : bgButtonColor;
    return TextButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor ?? buttonColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // <-- Radius
        ),
      ),
      onPressed: onClick,
      child: Text(
        text,
        style: textStyle.copyWith(color: Colors.white),
      ),
    );
  }
}

class AddingMinusingButton extends StatelessWidget {
  final Function() onClick;
  final double iconSize;
  final Color iconColor;
  final IconData icon;

  const AddingMinusingButton({
    super.key,
    required this.onClick,
    this.iconSize = 20,
    this.iconColor = Colors.white,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Icon(
        icon,
        color: iconColor,
        size: iconSize,
      ),
    );
  }
}

class DeleteIconButton extends StatelessWidget {
  final Function() onDelete;
  final Color iconColor;

  const DeleteIconButton({
    super.key,
    required this.onDelete,
    this.iconColor = Colors.red,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.delete,
        color: iconColor,
      ),
      onPressed: onDelete,
    );
  }
}

class EditIconButton extends StatelessWidget {
  final Function() onEdit;
  final Color iconColor;

  const EditIconButton({
    super.key,
    required this.onEdit,
    this.iconColor = Colors.green,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.edit,
        color: iconColor,
      ),
      onPressed: onEdit,
    );
  }
}