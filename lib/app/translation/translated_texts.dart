class TranslatedTexts {
  final appName = 'app_name';
  final hello = 'hello';
  static const welcome = 'welcome';
  final logout = 'logout';
  final settings = 'settings';
  final language = 'language';

  final error = 'error';
  final noInternet = 'no_internet';
  final invalidCredentials = 'invalid_credentials';

  static _Auth get auth => _Auth();

  static _Dashboard get dashboard => _Dashboard();

  static _Product get product => _Product();

  static _Sale get sale => _Sale();

  static _Errors get errors => _Errors();

  static _Buttons get buttons => _Buttons();

  static _Users get users => _Users();

  static _Alerts get alerts => _Alerts();

  static _Customer get customer => _Customer();

  static _Report get report => _Report();

  static _Table get table => _Table();

  static _TextFields get textFields => _TextFields();

  static _Debt get debt => _Debt();

  static _Payment get payment => _Payment();

  static _Profit get profit => _Profit();

  static _Statistics get statistics => _Statistics();
}

class _Buttons {
  final enter = 'enter';
  final register = 'register';
  final search = 'search';
  final cancel = 'cancel';
  final save = 'save';
  final delete = 'delete';
  final add = 'add';
  final edit = 'edit';
  final back = 'back';
  final update = 'update';
  final forDebt = 'for_debt';
  final pay = 'pay';
  final close = 'close';
  final forBuilder = 'for_builder';
  final exit = 'exit';
  final confirm = 'confirm';
}

class _Users {
  final users = 'users';
  final add = 'add_user';
  final edit = 'edit_user';
  final delete = 'delete_user';
  final name = 'user_name';
  final email = 'user_email';
  final phone = 'user_phone';
  final role = 'user_role';
  final permissions = 'user_permissions';
}

class _Errors {
  final noInternet = 'no_internet';
  final invalidCredentials = 'invalid_credentials';
  final serverError = 'server_error';
  final unknownError = 'unknown_error';
  final pleaseEnterNumber = 'please_enter_number';
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

class _Alerts {
  final enter_price = 'enter_price';
  final enter_name = 'enter_name';
  final enter_full_name = 'enter_full_name';
  final enter_phone_number = 'enter_phone_number';
  final enter_phone_number2 = 'enter_phone_number2';
  final enter_first_name = 'enter_first_name';
  final enter_last_name = 'enter_last_name';
  final enter_email = 'enter_email';
  final enter_description = 'enter_description';
  final enter_amount = 'enter_amount';
  final enter_date = 'enter_date';
  final enter_client = 'enter_client';
  final enter_product = 'enter_product';
  final enter_category = 'enter_category';
  final enter_provider = 'enter_provider';
  final enter_builder = 'enter_builder';
  final enter_currency = 'enter_currency';
  final enter_unit = 'enter_unit';
  final enter_qty = 'enter_qty';
}

class _Customer {
  final customers = 'customers';
  final add = 'add_customer';
  final edit = 'edit_customer';
  final delete = 'delete_customer';
  final name = 'customer_name';
  final email = 'customer_email';
  final phone = 'customer_phone';
}

class _Report {
  final reports = 'reports';
  final salesReport = 'sales_report';
  final productReport = 'product_report';
  final customerReport = 'customer_report';
  final builderReport = 'builder_report';
  final providerReport = 'provider_report';
  final dailyReport = 'daily_report';
  final weeklyReport = 'weekly_report';
  final monthlyReport = 'monthly_report';
  final yearlyReport = 'yearly_report';
}

class _Product {
  final products = 'products';
  final add = 'add_product';
  final edit = 'edit_product';
  final delete = 'delete_product';
  final name = 'product_name';
  final price = 'product_price';
  final description = 'product_description';
  final totalValueOfProducts = 'total_value_of_products';
}

class _Sale {
  final sales = 'sales';
  final add = 'add_sale';
  final amount = 'sale_amount';
  final date = 'sale_date';
}

class _Table {
  final index = 'index';
  final name = 'name';
  final number = 'number';
  final phoneNumber = 'phone_number';
  final phoneNumber2 = 'phone_number2';
  final address = 'address';
  final buttons = 'buttons';
  final qty = 'qty';
  final incomePrice = 'income_price';
  final salePrice = 'sale_price';
  final total = 'total';
  final typeOfProduct = 'type_of_product';
  final totalOfProduct = 'total_of_product';
  final documentType = 'document_type';
  final seeDetail = 'see_detail';
  final category = 'category';
  final status = 'status';
  final currency = 'currency';
  final addingTime = 'adding_time';
  final date = 'date';
  final isPaid = 'is_paid';
  final debt = 'debt';
  final totalValue = 'total_value';
  final totalProfit = 'total_profit';
  final totalAmountPrice = 'total_amount_price';
  final company = 'company';
  final product = 'product';
  final barcode = 'barcode';
  final unit = 'unit';
}

class _TextFields {
  final String fullName = "full_name";
  final String phoneNumber = "phone_number";
  final String phoneNumber2 = "phone_number2";
  final String address = "address";
  final String email = "email";
  final String password = "password";
  final String confirmPassword = "confirm_password";
  final String name = "name";
  final String description = "description";
  final String amount = "amount";
  final String date = "date";
  final firstName = 'first_name';
  final lastName = 'last_name';
}

class _Debt {
  final String debts = "debts";
  final String paid = "paid";
  final String notPaid = "not_paid";
  final String extraNumber = "extra_number";
  final String noExtraNumber = "no_extra_number";
}

class _Payment {
  final confirmPayment = 'confirm_payment';
  final paymentSuccess = 'payment_success';
  final paymentFailed = 'payment_failed';
  final areYouSureToPay = 'are_you_sure_to_pay';
}

class _Profit {
  final String profit = "profit";
  final String totalProfit = "total_profit";
  final String totalIncome = "total_income";
  final String totalExpense = "total_expense";
  final String profitMargin = "profit_margin";
  final String profitPercentage = "profit_percentage";
  final weeklyProfit = "weekly_profit";
  final monthlyProfit = "monthly_profit";
  final String yearlyProfit = "yearly_profit";
  final String profitByCategory = "profit_by_category";
  final String profitByProduct = "profit_by_product";
}

class _Statistics {
  final String statistics = "statistics";
  final weeklySalesStatistics = "weekly_sales_statistics";
  final monthlySalesStatistics = "monthly_sales_statistics";
  final String yearlySalesStatistics = "yearly_sales_statistics";
  final String salesByCategory = "sales_by_category";
  final String salesByProduct = "sales_by_product";
}
