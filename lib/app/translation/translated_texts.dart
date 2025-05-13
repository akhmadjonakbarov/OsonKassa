class TranslatedTexts {
  static const appName = 'app_name';
  static const hello = 'hello';
  static const welcome = 'welcome';
  static const logout = 'logout';
  static const settings = 'settings';
  static const language = 'language';

  static const error = 'error';
  static const noInternet = 'no_internet';
  static const invalidCredentials = 'invalid_credentials';

  static _Auth get auth => _Auth();
  static _Dashboard get dashboard => _Dashboard();
  static _Client get client => _Client();
  static _Product get product => _Product();
  static _Sale get sale => _Sale();
}

class _Auth {
  final login = 'login';
  final email = 'email';
  final password = 'password';
  final forgotPassword = 'forgot_password';
  final signIn = 'sign_in';
  final signOut = 'sign_out';
  final signUp = 'sign_up';
}

class _Dashboard {
  final dashboard = 'dashboard';
  final totalClients = 'total_clients';
  final totalSales = 'total_sales';
  final recentActivity = 'recent_activity';
}

class _Client {
  final clients = 'clients';
  final add = 'add_client';
  final edit = 'edit_client';
  final delete = 'delete_client';
  final details = 'client_details';
  final name = 'client_name';
  final email = 'client_email';
  final phone = 'client_phone';
}

class _Product {
  final products = 'products';
  final add = 'add_product';
  final edit = 'edit_product';
  final delete = 'delete_product';
  final name = 'product_name';
  final price = 'product_price';
  final description = 'product_description';
}

class _Sale {
  final sales = 'sales';
  final add = 'add_sale';
  final amount = 'sale_amount';
  final date = 'sale_date';
}
