import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osonkassa/features/dashboard_views/store/logic/store_ctl.dart';

import '../../../../../styles/text_styles.dart';

class ProductSearchBar extends StatelessWidget {
  const ProductSearchBar({
    super.key,
    required this.barCodeController,
    required this.addressFocusNode,
    required this.storeCtl,
    required this.searchProductDialog,
  });
  final Function() searchProductDialog;
  final StoreCtl storeCtl;
  final TextEditingController barCodeController;
  final FocusNode addressFocusNode;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: barCodeController,
            focusNode: addressFocusNode,
            onChanged: (value) => storeCtl.searchProduct(value, inStore: true),
            onSubmitted: (value) {
              storeCtl.searchProduct(value);
              barCodeController.clear();
              FocusScope.of(context).requestFocus(addressFocusNode);
            },
            style: textStyleBlack18,
            decoration: InputDecoration(
              prefixIcon: const Icon(
                CupertinoIcons.barcode,
                color: Colors.blueAccent,
              ),
              suffixIcon: IconButton(
                icon: const Icon(CupertinoIcons.clear_thick_circled,
                    color: Colors.grey),
                onPressed: () {
                  barCodeController.clear();
                  storeCtl.searchProduct("");
                },
              ),
              hintText: "Scan or Enter Barcode...",
              hintStyle: textStyleBlack18.copyWith(color: Colors.grey.shade500),
              filled: true,
              fillColor: Colors.grey.shade100,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Colors.blueAccent),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        ElevatedButton.icon(
          onPressed: () => searchProductDialog(),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            elevation: 3,
          ),
          icon: const Icon(CupertinoIcons.search, size: 20),
          label: Text("search".tr),
        )
      ],
    );
  }
}
