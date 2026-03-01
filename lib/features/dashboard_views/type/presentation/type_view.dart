import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osonkassa/features/dashboard_views/type/presentation/controller/type_controller.dart';
import 'package:osonkassa/features/dashboard_views/type/presentation/widgets/type_table.dart';

import '../../../../core/permission/permissions.dart';
import '../../../../utils/media/get_screen_size.dart';
import '../../../auth/logic/controllers/auth_ctl.dart';
import '../../../shared/widgets/buttons.dart';
import '../../../shared/widgets/content_view.dart';
import '../../../shared/widgets/data_list.dart';

class TypeView extends StatefulWidget {
  final AuthCtl authCtl;

  const TypeView({super.key, required this.authCtl});

  @override
  State<TypeView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<TypeView> {
  TypeController typeController = Get.find<TypeController>();

  @override
  void initState() {
    typeController.getTypes();
    super.initState();
  }

  void showAddTypeDialog({
    required void Function(String name) onSubmit,
  }) {
    final TextEditingController nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text(
            "Add New Type".tr, // Assuming you're using a translation extension
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          backgroundColor: Colors.white,
          contentPadding: const EdgeInsets.fromLTRB(
              18, 8, 18, 16), // Bottom padding for better spacing
          content: Column(
            mainAxisSize: MainAxisSize
                .min, // Vital: Keeps dialog from expanding to full screen
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: "Enter type name",
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.blueAccent),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  // Cancel Button
                  Expanded(
                    child: TextButton(
                      // Modern look uses TextButton for negative actions
                      onPressed: () => Navigator.of(context).pop(),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text("cancel".tr),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Save Button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        final name = nameController.text.trim();
                        if (name.isEmpty) {
                          // Standard Flutter Snackbar
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please enter a type name"),
                              backgroundColor: Colors.redAccent,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                          return;
                        }
                        onSubmit(name);
                        Navigator.of(ctx).pop(); // Replaces Get.back()
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text("save".tr),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = getScreenSize(context);
    return ContentView(
      onChangePage: (p0) {
        typeController.selectPage(p0);
      },
      title: "Bo'limlar Ro'yhati",
      pagination: typeController.pagination,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CheckedAddButton(
              onClick: () => showAddTypeDialog(
                onSubmit: (name) {
                  typeController.createType(name);
                },
              ),
              permission: Permissions.create_category.name.toLowerCase(),
              roles: widget.authCtl.userModel.value.roles,
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: screenSize.height / 60,
          ),
          child: Obx(
            () => DataList(
              isLoading: typeController.loading.value,
              isNotEmpty: typeController.types.isNotEmpty,
              child: TypeTable(
                typeController: typeController,
                types: typeController.types,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
