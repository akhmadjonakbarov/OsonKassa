import '../../dashboard_views/customer/models/client_model.dart';
import '../../dashboard_views/document/models/document_model.dart';

class ClientDebtModel {
  int id;
  CustomerModel client;
  DocumentModelWithItems document;
  bool is_paid;
  double amount;
  ClientDebtModel({
    required this.client,
    required this.document,
    required this.is_paid,
    required this.id,
    required this.amount,
  });

  ClientDebtModel copyWith({
    CustomerModel? client,
    DocumentModelWithItems? document,
    bool? is_paid,
    double? amount,
    int? id,
  }) {
    return ClientDebtModel(
        client: client ?? this.client,
        document: document ?? this.document,
        is_paid: is_paid ?? this.is_paid,
        amount: amount ?? this.amount,
        id: id ?? this.id);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'client': client.toMap(),
      'document': document.toMap(),
      'is_paid': is_paid,
      'amount': amount,
    };
  }

  factory ClientDebtModel.fromMap(Map<String, dynamic> map) {
    return ClientDebtModel(
      id: map['id'] as int,
      client: CustomerModel.fromMap(map['client'] as Map<String, dynamic>),
      document: DocumentModelWithItems.fromMap(
        map['document'] as Map<String, dynamic>,
      ),
      is_paid: map['is_paid'] as bool,
      amount: double.parse(map['amount'].toString()),
    );
  }

  @override
  String toString() {
    return 'ClientDebtModel(client: $client, document: $document, is_paid: $is_paid, amount: $amount)';
  }
}
