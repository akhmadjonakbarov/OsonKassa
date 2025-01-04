import '../repository/client_debt_repository.dart';

class ClientDebtService {
  final ClientDebtRepository clientDebtRepository;
  ClientDebtService({required this.clientDebtRepository});

  Future getAll(int client_id) async {
    return clientDebtRepository.getAll(client_id);
  }

  Future<bool> pay(int debt_id) async {
    return clientDebtRepository.pay(debt_id);
  }
}
