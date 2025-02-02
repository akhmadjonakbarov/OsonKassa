import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osonkassa/app/features/dashboard_views/computer/logic/display/display_controller.dart';
import 'package:osonkassa/app/styles/app_colors.dart';
import 'package:osonkassa/app/utils/texts/button_texts.dart';

import '../../../../styles/text_styles.dart';
import '../../../../utils/helper/button_size_manager.dart';
import '../../../../utils/media/get_screen_size.dart';
import '../../../../utils/texts/table_texts.dart';
import '../../../auth/logic/controllers/auth_ctl.dart';
import '../../../shared/export_commons.dart';
import '../../../shared/widgets/content_view.dart';
import '../logic/computer_ctl.dart';
import 'widgets/requirement_section.dart';

class ComputerView extends StatelessWidget {
  final ComputerCtl computerCtl;
  final AuthCtl authCtl;
  final DisplayController displayController;

  ComputerView(
      {super.key,
      required this.computerCtl,
      required this.authCtl,
      required this.displayController});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _sizeController = TextEditingController();

  void createComputer(Size screenSize) {
    Get.dialog(AlertDialog(
      content: SizedBox(
        width: screenSize.width * 0.4,
        child: ListView(
          padding: EdgeInsets.all(screenSize.height / 100),
          children: const [
            TextField(
              decoration: InputDecoration(
                label: Text("Kompyuter nomi"),
                border: OutlineInputBorder(),
              ),
            ),
            RequirementSection(
              title: "RAM",
            ),
            RequirementSection(
              title: "ROM",
            ),
            RequirementSection(
              title: "ROM",
            ),
          ],
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = getScreenSize(context);
    return ContentView(
      pagination: computerCtl.pagination,
      onChangePage: (pageValue) {},
      title: "Kompyuterlar",
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: screenSize.width * 0.15,
              child: SearchTextField(onChanged: (value) {}),
            ),
            Row(
              children: [
                // ram
                BasicButton(
                  onClick: () {
                    Get.dialog(
                      ManageDetailDialogView(
                        title: "Ram",
                        onAdd: () {
                          Get.dialog(
                            BasicDialog(
                              width: screenSize.width * 0.15,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      HeaderTitle2(
                                          title: "Tezkor xotira qo'shish"),
                                      XButton()
                                    ],
                                  ),
                                  Form(
                                    key: _formKey,
                                    child: TextFormField(
                                      controller: _sizeController,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        labelText: "Size (in GB)",
                                        border: OutlineInputBorder(),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please enter a size";
                                        }
                                        if (int.tryParse(value) == null) {
                                          return "Enter a valid number";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: AddButton(
                                      onClick: () =>
                                          Navigator.of(context).pop(),
                                      textStyle: TextStyles.white(
                                          screenSize.height / 45),
                                      height: ButtonSizeManager.height(context,
                                          height: 0.1 / 2.5),
                                      width: ButtonSizeManager.width(context),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        onSearch: (value) {},
                        searchHintText: "Ram 16gb",
                        children: [
                          Container(
                            margin:
                                EdgeInsets.only(top: screenSize.height / 125),
                            child: CustomDataTable(
                              columns: [
                                TableTexts.index,
                                "Size",
                                TableTexts.buttons
                              ],
                              rows: [],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  text: "Ram",
                  textStyle: TextStyles.white(screenSize.height / 44),
                  height: ButtonSizeManager.height(context),
                  width: ButtonSizeManager.width(context),
                ),
                // rom
                BasicButton(
                  margin: EdgeInsets.symmetric(
                    horizontal: screenSize.width / 95,
                  ),
                  onClick: () {
                    Get.dialog(
                      ManageDetailDialogView(
                        onAdd: () {
                          Get.dialog(
                            BasicDialog(
                              width: screenSize.width * 0.15,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      HeaderTitle2(
                                          title: "Doimiy xotira qo'shish"),
                                      XButton()
                                    ],
                                  ),
                                  Form(
                                    key: _formKey,
                                    child: TextFormField(
                                      controller: _sizeController,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        labelText: "Size (in GB)",
                                        border: OutlineInputBorder(),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please enter a size";
                                        }
                                        if (int.tryParse(value) == null) {
                                          return "Enter a valid number";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: AddButton(
                                      onClick: () =>
                                          Navigator.of(context).pop(),
                                      textStyle: TextStyles.white(
                                          screenSize.height / 45),
                                      height: ButtonSizeManager.height(context,
                                          height: 0.1 / 2.5),
                                      width: ButtonSizeManager.width(context),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        title: "ROM",
                        onSearch: (value) {},
                        searchHintText: "ROM 256gb (sdd)",
                        children: [
                          Container(
                            margin:
                                EdgeInsets.only(top: screenSize.height / 125),
                            child: CustomDataTable(
                              columns: [
                                TableTexts.index,
                                "Size",
                                TableTexts.buttons
                              ],
                              rows: [],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  text: "Rom",
                  textStyle: TextStyles.white(screenSize.height / 44),
                  height: ButtonSizeManager.height(context),
                  width: ButtonSizeManager.width(context),
                ),
                BasicButton(
                  onClick: () {
                    Get.dialog(
                      ManageDetailDialogView(
                        title: "Display",
                        onAdd: () {
                          Get.dialog(StatefulBuilder(
                            builder: (context, setState) => BasicDialog(
                              height: screenSize.height * 0.8,
                              // Adjust height as needed
                              width: screenSize.width * 0.5,
                              // Adjust width as needed
                              child: ListView(
                                padding: EdgeInsets.zero,
                                children: [
                                  const Row(
                                    children: [
                                      HeaderTitle2(title: "Display qo'shish"),
                                      XButton()
                                    ],
                                  ),
                                  SizedBox(height: 16),

                                  // Name Field
                                  TextField(
                                    decoration: InputDecoration(
                                      labelText: "Nomi: IPS, AV, NT",
                                      border: OutlineInputBorder(),
                                    ),
                                    onChanged: (value) {
                                      // Save name value
                                    },
                                  ),
                                  SizedBox(height: 16),

                                  // Refresh Rate Section
                                  const Text(
                                    "O'zgarish darajasini tanlang",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 8),
                                  Obx(
                                    () => ListView.builder(
                                      itemBuilder: (context, index) {
                                        final int refreshRate =
                                            displayController
                                                .refreshRates[index];
                                        return InkWell(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          onTap: () => setState(
                                            () => displayController
                                                .selectRefreshRate(refreshRate),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "$refreshRate hz",
                                                  style: TextStyles.black(),
                                                ),
                                                if (displayController
                                                    .isRefreshRateSelected(
                                                        refreshRate))
                                                  const Icon(Icons.check_box)
                                                else
                                                  const Icon(Icons
                                                      .check_box_outline_blank)
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount:
                                          displayController.refreshRates.length,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  // TextField(
                                  //   decoration: const InputDecoration(
                                  //     labelText:
                                  //         "O'ziz istagan darajani kiriting. Iltimos faqat raqam kiriting",
                                  //     border: OutlineInputBorder(),
                                  //   ),
                                  //   keyboardType: TextInputType.number,
                                  //   onChanged: (value) {
                                  //     setState(() =>
                                  //         displayController.addRefreshRate(
                                  //             int.parse(value.toString())));
                                  //   },
                                  // ),
                                  // SizedBox(height: 16),
                                  //
                                  // // Resolution Section
                                  Text(
                                    "Ekran o'lchami tanlang",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 8),
                                  Obx(
                                    () => ListView.builder(
                                      itemBuilder: (context, index) {
                                        final String refreshRate =
                                            displayController
                                                .resolutions[index];
                                        return InkWell(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          onTap: () => setState(
                                            () => displayController
                                                .selectResolution(refreshRate),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  refreshRate,
                                                  style: TextStyles.black(),
                                                ),
                                                if (displayController
                                                    .isResolutionSelected(
                                                        refreshRate))
                                                  const Icon(Icons.check_box)
                                                else
                                                  const Icon(Icons
                                                      .check_box_outline_blank)
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount:
                                          displayController.resolutions.length,
                                    ),
                                  ),

                                  TextField(
                                    decoration: InputDecoration(
                                      labelText:
                                          "O'ziz istagan o'lchamni kiriting (e.g., 1920x1080)",
                                      border: OutlineInputBorder(),
                                    ),
                                    onChanged: (value) {},
                                  ),
                                  // ],
                                  // SizedBox(height: 16),
                                  //
                                  // // Size Section
                                  const Text(
                                    "Display o'lchami tanlang",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 8),
                                  Obx(
                                    () => ListView.builder(
                                      itemBuilder: (context, index) {
                                        final double dSize =
                                            displayController.dSizes[index];
                                        return InkWell(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          onTap: () => setState(
                                            () => displayController
                                                .selectDSize(dSize),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "$dSize",
                                                  style: TextStyles.black(),
                                                ),
                                                if (displayController
                                                    .isDSizeSelected(dSize))
                                                  const Icon(Icons.check_box)
                                                else
                                                  const Icon(Icons
                                                      .check_box_outline_blank)
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount:
                                          displayController.resolutions.length,
                                    ),
                                  ),
                                  TextField(
                                    decoration: InputDecoration(
                                      labelText:
                                          "O'ziz istagan display o'lchamini kiriting.  (Faqat raqam kiritilsin )",
                                      border: OutlineInputBorder(),
                                    ),
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                            decimal: true),
                                    onChanged: (value) {},
                                  ),
                                ],
                              ),
                            ),
                          ));
                        },
                        onSearch: (value) {},
                        searchHintText:
                            "Display | full hd | 144ghz | 1920x1080",
                        children: [
                          Container(
                            margin:
                                EdgeInsets.only(top: screenSize.height / 125),
                            child: CustomDataTable(
                              columns: [
                                TableTexts.index,
                                "Turlari",
                                "Razmerlar",
                                "Yangilanish ko'rsatgichi",
                                TableTexts.buttons
                              ],
                              rows: [],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  text: "Display",
                  textStyle: TextStyles.white(screenSize.height / 44),
                  height: ButtonSizeManager.height(context),
                  width: ButtonSizeManager.width(context),
                ),
              ],
            ),
            CheckedAddButton(
              onClick: () {
                createComputer(screenSize);
              },
              permission: 'create_computer',
              roles: authCtl.userModel.value.roles,
            )
          ],
        ),
      ],
    );
  }
}
