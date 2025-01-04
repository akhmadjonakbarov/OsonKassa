// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:osonkassa/app/styles/colors.dart';
import 'package:osonkassa/app/styles/text_styles.dart';
import 'package:osonkassa/app/utils/helper/valid_alert.dart';
import 'package:osonkassa/app/utils/texts/button_texts.dart';
import 'package:osonkassa/app/utils/texts/user_texts.dart';
import 'package:flutter/material.dart';

class AddDebtForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController phoneNumberController;
  final TextEditingController phoneNumber2Controller;
  final TextEditingController addressController;
  final Function() onClick;
  final Function() onCancel;

  const AddDebtForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.phoneNumberController,
    required this.phoneNumber2Controller,
    required this.addressController,
    required this.onClick,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: primary,
      title: Text(
        'Qarz qo\'shish',
        style: textStyleBlack18.copyWith(
            fontSize: 25, fontWeight: FontWeight.w800),
      ),
      content: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: UserTexts.fullName,
                  labelStyle: textStyleGrey14,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return validField(UserTexts.fullName);
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: phoneNumberController,
                decoration: InputDecoration(
                  labelText: UserTexts.phone_number,
                  labelStyle: textStyleGrey14,
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return validField(UserTexts.phone_number);
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: phoneNumber2Controller,
                decoration: InputDecoration(
                  labelText: UserTexts.phoneNumber2,
                  labelStyle: textStyleGrey14,
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return UserTexts.phoneNumber2;
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: addressController,
                decoration: InputDecoration(
                  labelText: UserTexts.address,
                  labelStyle: textStyleGrey14,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return validField(UserTexts.address);
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: onCancel,
          child: Text(
            ButtonTexts.cancel,
            style: textStyleBlack14.copyWith(color: Colors.red),
          ),
        ),
        ElevatedButton(
          onPressed: onClick,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent),
          child: Text(
            ButtonTexts.save,
            style: textStyleBlack14,
          ),
        ),
      ],
    );
  }
}
