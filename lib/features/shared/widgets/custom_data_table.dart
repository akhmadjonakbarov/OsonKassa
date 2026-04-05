import 'package:flutter/material.dart';

import '../../../styles/app_colors.dart';
import '../../../styles/text_styles.dart';
import '../../../styles/themes.dart';
import '../../../utils/media/get_screen_size.dart';

class CustomDataTable extends StatelessWidget {
  final List<String> columns;
  final List<DataRow> rows;
  final EdgeInsets? padding;
  final double? headingRowHeight;
  final double? dataRowHeight;
  final VoidCallback? onRefresh;

  const CustomDataTable({
    super.key,
    required this.columns,
    required this.rows,
    this.padding,
    this.headingRowHeight,
    this.dataRowHeight,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = getScreenSize(context);
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: DataTable(
          headingRowColor: WidgetStateProperty.all(
            ButtonColors.primary.withOpacity(0.15),
          ),
          dataRowColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.hovered)) {
                return AppColors.grey.withOpacity(0.8);
              }
              return AppColors.cardBackground;
            },
          ),
          border: TableBorder.all(
            color: AppColors.divider,
            width: 1,
          ),
          showCheckboxColumn: false,
          headingTextStyle: screenSize.width <= 1370
              ? textStyleBlack18Bold.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                )
              : textStyleBlack18Bold.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
          dataTextStyle: textStyleBlack14.copyWith(
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
          columnSpacing: 25,
          headingRowHeight: headingRowHeight ?? 50,
          dataRowHeight: dataRowHeight ?? 55,
          columns: columns
              .map(
                (e) => DataColumn(
                  label: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      e,
                      textAlign: TextAlign.center,
                      style: TextStyles.style(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  headingRowAlignment: MainAxisAlignment.center,
                ),
              )
              .toList(),
          rows: rows,
        ),
      ),
    );
  }
}
