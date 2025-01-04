import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';

import '../../features/dashboard_views/document/models/doc_item_model.dart';
import '../../utils/formatter_functions/format_phone_number.dart';
import '../../utils/formatter_functions/formatter_currency.dart';
import '../../utils/formatter_functions/formatter_date.dart';

class PosPrinterManager {
  final String printerIp;
  final int port;
  late NetworkPrinter _printer;
  late CapabilityProfile _profile;

  final String _storeName = "Shukurjon Elektro Market";

  PosPrinterManager({required this.printerIp, this.port = 9100});

  Future<void> initPrinter() async {
    _profile = await CapabilityProfile.load();
    _printer = NetworkPrinter(PaperSize.mm80, _profile);
  }

  Future<bool> _connectPrinter() async {
    final result = await _printer.connect(printerIp, port: port);
    return result == PosPrintResult.success;
  }

  disconnectPrinter() {
    _printer.disconnect();
  }

  Future<void> printSoldReceipt(List<DocItemModel> items) async {
    try {
      if (await _connectPrinter()) {
        // Print Header
        _printer.text(
          _storeName,
          styles: const PosStyles(
            align: PosAlign.center,
            height: PosTextSize.size2,
            width: PosTextSize.size2,
            fontType: PosFontType.fontA,
            bold: true,
          ),
        );

// Add a larger free space
        _printer.text(
          '',
          styles: const PosStyles(
            height: PosTextSize.size2,
          ),
        );

// Print Date and Contact Info
        _printer.text(
          'Sana: ${formatDate(DateTime.now().toString())}',
          styles: const PosStyles(
            align: PosAlign.center,
            fontType: PosFontType.fontB,
          ),
        );

        _printer.text(
          'Murojat uchun: ${formatPhoneNumber("905885195")}',
          styles: const PosStyles(
            align: PosAlign.center,
            fontType: PosFontType.fontB,
            bold: true,
          ),
        );

// Free space
        _printer.text(
          '',
        );

// Double Line
        _printer.hr(ch: "=");

// Free space
        _printer.text(
          '',
        );

// Product List (unchanged)
        double total = 0;
        int index = 0;
        for (var item in items) {
          double price_selected = item.selling_price;
          final itemTotal = item.qty * price_selected;
          total += itemTotal;
          index++;

          // Print Product Name with Index
          _printer.text(
            '$index.  ${item.item.name}',
            styles: const PosStyles(
              align: PosAlign.left,
              height: PosTextSize.size1,
              width: PosTextSize.size1,
              fontType: PosFontType.fontA,
              bold: true,
            ),
          );

          // Add Padding/Margin between the product name and the quantity-price-total line
          _printer.text(
            '',
          );

          // Print Quantity, Price, and Total
          _printer.text(
            '${item.qty} x ${formatUZSNumber(item.selling_price, isAddWord: false)}     ${formatUZSNumber(itemTotal, isAddWord: false)}',
            styles: const PosStyles(
              align: PosAlign.center,
              height: PosTextSize.size1,
              width: PosTextSize.size1,
              fontType: PosFontType.fontA,
            ),
          );

          _printer.hr();
        }

// Free space
        _printer.text(
          '',
        );

// Double Line after Products
        _printer.hr(ch: "=");

// Print Total
        _printer.text(
          'Jami: ${formatUZSNumber(total, isAddWord: false)}',
          styles: const PosStyles(
            align: PosAlign.center,
            height: PosTextSize.size2,
            width: PosTextSize.size2,
            fontType: PosFontType.fontB,
            bold: true,
          ),
        );

// Free space
        _printer.text(
          '',
          styles: const PosStyles(
            height: PosTextSize.size2,
          ),
        );

// Print Footer
        _printer.text(
          'Xaridingiz uchun rahmat!',
          styles: const PosStyles(
            align: PosAlign.center,
            fontType: PosFontType.fontA,
            bold: true,
          ),
        );

// Cut the paper after printing
        _printer.cut();

// Optional: Delay and disconnect the printer
        await Future.delayed(const Duration(seconds: 2));
        disconnectPrinter();
      }
    } catch (e) {
      print('Failed to connect to printer');
    }
  }

  Future<void> printProductDoc(List<DocItemModel> items) async {
    try {
      if (await _connectPrinter()) {
        // Print Header
        _printer.text(
          _storeName,
          styles: const PosStyles(
            align: PosAlign.center,
            height: PosTextSize.size2,
            width: PosTextSize.size2,
            fontType: PosFontType.fontA,
            bold: true,
          ),
        );

// Add a larger free space
        _printer.text(
          '',
          styles: const PosStyles(
            height: PosTextSize.size2,
          ),
        );

// Print Date and Contact Info
        _printer.text(
          'Sana: ${formatDate(DateTime.now().toString())}',
          styles: const PosStyles(
            align: PosAlign.center,
            fontType: PosFontType.fontB,
          ),
        );

        _printer.text(
          'Murojat uchun: ${formatPhoneNumber("905885195")}',
          styles: const PosStyles(
            align: PosAlign.center,
            fontType: PosFontType.fontB,
            bold: true,
          ),
        );

// Free space
        _printer.text(
          '',
        );

// Double Line
        _printer.hr(ch: "=");

// Free space
        _printer.text(
          '',
        );

// Product List (unchanged)
        double total = 0;
        int index = 0;
        for (var item in items) {
          double price_selected = item.selling_price;
          final itemTotal = item.qty * price_selected;
          total += itemTotal;
          index++;

          // Print Product Name with Index
          _printer.text(
            '$index.  ${item.item.name}',
            styles: const PosStyles(
              align: PosAlign.left,
              height: PosTextSize.size1,
              width: PosTextSize.size1,
              fontType: PosFontType.fontA,
              bold: true,
            ),
          );

          // Add Padding/Margin between the product name and the quantity-price-total line
          _printer.text(
            '',
          );

          // Print Quantity, Price, and Total
          _printer.text(
            '${item.qty} x ${formatUZSNumber(price_selected, isAddWord: false)}     ${formatUZSNumber(itemTotal, isAddWord: false)}',
            styles: const PosStyles(
              align: PosAlign.center,
              height: PosTextSize.size1,
              width: PosTextSize.size1,
              fontType: PosFontType.fontA,
            ),
          );

          _printer.hr();
        }

// Free space
        _printer.text(
          '',
        );

// Double Line after Products
        _printer.hr(ch: "=");

// Print Total
        _printer.text(
          'Jami: ${formatUZSNumber(total, isAddWord: false)}',
          styles: const PosStyles(
            align: PosAlign.center,
            height: PosTextSize.size2,
            width: PosTextSize.size2,
            fontType: PosFontType.fontB,
            bold: true,
          ),
        );

// Free space
        _printer.text(
          '',
          styles: const PosStyles(
            height: PosTextSize.size2,
          ),
        );

// Print Footer
        _printer.text(
          'Xaridingiz uchun rahmat!',
          styles: const PosStyles(
            align: PosAlign.center,
            fontType: PosFontType.fontA,
            bold: true,
          ),
        );

// Cut the paper after printing
        _printer.cut();

// Optional: Delay and disconnect the printer
        await Future.delayed(const Duration(seconds: 2));
        disconnectPrinter();
      }
    } catch (e) {
      print('Failed to connect to printer');
    }
  }
}

//         // Print Header
//         _printer.text(
//           'Your Store Name',
//           styles: const PosStyles(
//             align: PosAlign.center,
//             height: PosTextSize.size2,
//             width: PosTextSize.size2,
//             fontType: PosFontType.fontA,
//           ),
//         );
//
// // Free Space
//         _printer.text(
//           '',
//         );
//
// // Print Date
//         _printer.text(
//           'Sana: ${formatDate(DateTime.now().toString())}',
//           styles: const PosStyles(
//             align: PosAlign.center,
//             fontType: PosFontType.fontA,
//           ),
//         );
//         _printer.text(
//           'Murojat uchun: ${formatPhoneNumber("905885195")}',
//           styles: const PosStyles(
//             align: PosAlign.center,
//             fontType: PosFontType.fontA,
//             bold: true,
//           ),
//         );
//
// // Free Space
//         _printer.text(
//           '',
//         );
//
// // Double Line
//         _printer.hr(ch: "=");
//
// // Free Space
//         _printer.text(
//           '',
//         );
//
// // Print Items
//         double total = 0;
//         int index = 0;
//         for (var item in items) {
//           final itemTotal = item.qty * item.selling_price;
//           total += itemTotal;
//           index++;
//           // Product Name in big and bold font
//           // Print Product Name with Index
//           _printer.text(
//             '$index.  ${item.name}',
//             styles: const PosStyles(
//               align: PosAlign.left,
//               height: PosTextSize.size1,
//               width: PosTextSize.size1,
//               fontType: PosFontType.fontA,
//               bold: true,
//             ),
//           );
//
// // Add Padding/Margin between the product name and the quantity-price-total line
//           _printer.text(
//             '',
//             styles: const PosStyles(
//               align: PosAlign.left,
//               height: PosTextSize.size1,
//               // size1 is usually the smallest
//               width: PosTextSize.size1,
//               // keep it at size1 for both height and width
//               fontType: PosFontType
//                   .fontB, // fontB is usually smaller and more condensed
//             ),
//           );
//
// // Print Quantity, Price, and Total
//           _printer.text(
//             '${item.qty} x ${formatUZSNumber(item.selling_price)}     ${formatUZSNumber(itemTotal)}',
//             styles: const PosStyles(
//               align: PosAlign.center,
//               height: PosTextSize.size1,
//               width: PosTextSize.size1,
//               fontType: PosFontType.fontA,
//             ),
//           );
//
//           _printer.hr();
//         }
//
// // Free Space
//         _printer.text(
//           '',
//         );
//
// // Double Line after Products
//         _printer.hr(
//           ch: "=",
//         );
//
// // Print Total
//         _printer.text(
//           'Jami: ${formatUZSNumber(total, isAddWord: true)}',
//           styles: const PosStyles(
//             align: PosAlign.center,
//             height: PosTextSize.size2,
//             width: PosTextSize.size2,
//             fontType: PosFontType.fontB,
//           ),
//         );
//
// // Free Space
//         _printer.text(
//           '',
//         );
//
// // Print Footer
//         _printer.text(
//           'Xaridingiz uchun rahmat!',
//           styles: const PosStyles(
//             align: PosAlign.center,
//             bold: true,
//             fontType: PosFontType.fontA,
//           ),
//         );
