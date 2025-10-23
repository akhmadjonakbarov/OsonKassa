import 'package:get/get.dart';
import 'translated_texts.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          // General
          'app_name': 'CRM System',
          'hello': 'Hello',
          'welcome': 'Welcome to the CRM system',
          'logout': 'Logout',
          'settings': 'Settings',
          'language': 'Language',

          // Authentication
          'login': 'Login',
          'email': 'Email',
          'password': 'Password',
          'forgot_password': 'Forgot password?',
          'sign_in': 'Sign In',
          'sign_out': 'Sign Out',

          // Dashboard
          'dashboard': 'Dashboard',
          'total_clients': 'Total Clients',
          'total_sales': 'Total Sales',
          'recent_activity': 'Recent Activity',

          // Clients
          'clients': 'Clients',
          'add_client': 'Add Client',
          'edit_client': 'Edit Client',
          'delete_client': 'Delete Client',
          'client_details': 'Client Details',
          'client_name': 'Client Name',
          'client_email': 'Client Email',
          'client_phone': 'Client Phone',

          // Products
          'products': 'Products',
          'add_product': 'Add Product',
          'edit_product': 'Edit Product',
          'delete_product': 'Delete Product',
          'product_name': 'Product Name',
          'product_price': 'Product Price',
          'product_description': 'Product Description',

          // total price
          'total_products': 'Total Products',
          'total_price': 'Total Price',

          // Sales
          'sales': 'Sales',
          'add_sale': 'Add Sale',
          'sale_amount': 'Sale Amount',
          'sale_date': 'Sale Date',

          // Tasks
          'tasks': 'Tasks',
          'add_task': 'Add Task',
          'edit_task': 'Edit Task',
          'delete_task': 'Delete Task',
          'task_title': 'Task Title',
          'task_description': 'Task Description',
          'task_due_date': 'Due Date',

          // Notifications
          'notifications': 'Notifications',
          'mark_all_as_read': 'Mark all as read',
          'new_notification': 'New Notification',

          // Reports
          'reports': 'Reports',
          'generate_report': 'Generate Report',
          'report_type': 'Report Type',
          'report_date': 'Report Date',

          // User Management
          'users': 'Users',
          'add_user': 'Add User',
          'edit_user': 'Edit User',
          'delete_user': 'Delete User',
          'user_role': 'User Role',
          'user_permissions': 'User Permissions',

          // Support
          'support': 'Support',
          'contact_support': 'Contact Support',
          'faq': 'FAQ',
          'terms_conditions': 'Terms & Conditions',
          'privacy_policy': 'Privacy Policy',

          // Errors
          'error': 'Error',
          'no_internet': 'No internet connection',
          'invalid_credentials': 'Invalid email or password',
        },
        'uz_UZ': {
          // General
          'app_name': 'CRM Tizimi',
          'hello': 'Salom',
          'welcome': 'CRM tizimiga xush kelibsiz',
          'logout': 'Chiqish',
          'settings': 'Sozlamalar',
          'language': 'Til',

          // Authentication
          TranslatedTexts.auth.login: 'Kirish',
          TranslatedTexts.auth.email: 'Elektron pochta',
          TranslatedTexts.auth.password: 'Parol',
          TranslatedTexts.auth.forgotPassword: 'Parolni unutdingizmi?',
          TranslatedTexts.auth.signIn: 'Kirish',
          TranslatedTexts.auth.signOut: 'Chiqish',
          TranslatedTexts.auth.signUp: 'Ro‘yxatdan o‘tish',

          // Dashboard
          'dashboard': 'Boshqaruv paneli',
          'total_clients': 'Jami mijozlar',
          'total_sales': 'Jami savdo',
          'recent_activity': 'So‘nggi faoliyat',

          // Clients
          TranslatedTexts.customer.customers: 'Mijozlar',
          TranslatedTexts.customer.add: 'Mijoz qo‘shish',
          TranslatedTexts.customer.edit: 'Mijozni tahrirlash',
          TranslatedTexts.customer.delete: 'Mijozni o‘chirish',
          TranslatedTexts.customer.name: 'Mijoz nomi',
          TranslatedTexts.customer.email: 'Mijoz elektron pochtasi',
          TranslatedTexts.customer.phone: 'Mijoz telefoni',

          // Products
          TranslatedTexts.product.products: 'Mahsulotlar',
          TranslatedTexts.product.add: 'Mahsulot qo‘shish',
          TranslatedTexts.product.edit: 'Mahsulotni tahrirlash',
          TranslatedTexts.product.delete: 'Mahsulotni o‘chirish',
          TranslatedTexts.product.name: 'Mahsulot nomi',
          TranslatedTexts.product.price: 'Mahsulot narxi',
          TranslatedTexts.product.description: 'Mahsulot tavsifi',
          TranslatedTexts.product.totalValueOfProducts:
              'Mahsulotlarning umumiy qiymati',

          // total price
          'total_products': 'Jami mahsulotlar',
          'total_price': 'Jami narx',
          'total_qty': 'Jami soni',
          'total_income_price': 'Jami kelgan narxi',
          'total_sale_price': 'Jami savdo narxi',

          // Sales
          TranslatedTexts.sale.sales: 'Savdo',
          TranslatedTexts.sale.add: 'Savdo qo‘shish',
          TranslatedTexts.sale.amount: 'Savdo summasi',
          TranslatedTexts.sale.date: 'Savdo sanasi',

          //Debts
          TranslatedTexts.debt.debts: 'Qarzdorliklar',
          TranslatedTexts.debt.paid: 'To‘langan',
          TranslatedTexts.debt.notPaid: 'To‘lanmagan',

          //Payments
          TranslatedTexts.payment.confirmPayment: 'To‘lovni tasdiqlash',
          TranslatedTexts.payment.paymentSuccess:
              'To‘lov muvaffaqiyatli amalga oshirildi',
          TranslatedTexts.payment.paymentFailed: 'To‘lov amalga oshmadi',
          TranslatedTexts.payment.areYouSureToPay:
              'To‘lashga ishonchingiz komilmi?',

          // Tasks
          'tasks': 'Vazifalar',
          'add_task': 'Vazifa qo‘shish',
          'edit_task': 'Vazifani tahrirlash',
          'delete_task': 'Vazifani o‘chirish',
          'task_title': 'Vazifa sarlavhasi',
          'task_description': 'Vazifa tavsifi',
          'task_due_date': 'Muddat',

          // Notifications
          'notifications': 'Bildirishnomalar',
          'mark_all_as_read': 'Hammasini o‘qilgan deb belgilash',
          'new_notification': 'Yangi bildirishnoma',

          // Reports
          TranslatedTexts.report.reports: 'Hisobotlar',
          TranslatedTexts.report.salesReport: 'Savdo hisoboti',
          TranslatedTexts.report.productReport: 'Mahsulotlar hisobotlari',
          TranslatedTexts.report.customerReport: 'Mijozlar hisoboti',
          TranslatedTexts.report.builderReport: 'Quruvchi hisoboti',
          TranslatedTexts.report.providerReport: 'Ta’minotchi hisoboti',
          TranslatedTexts.report.dailyReport: 'Kunlik hisobot',
          TranslatedTexts.report.weeklyReport: 'Haftalik hisobot',
          TranslatedTexts.report.monthlyReport: 'Oylik hisobot',
          TranslatedTexts.report.yearlyReport: 'Yillik hisobot',

          // Text Fields
          TranslatedTexts.textFields.fullName: 'Familya Ism',
          TranslatedTexts.textFields.phoneNumber: 'Telefon raqami',
          TranslatedTexts.textFields.phoneNumber2: 'Qo‘shimcha telefon raqami',
          TranslatedTexts.textFields.address: 'Manzil',
          TranslatedTexts.textFields.email: 'Elektron pochta',
          TranslatedTexts.textFields.password: 'Parol',
          TranslatedTexts.textFields.confirmPassword: 'Parolni tasdiqlang',
          TranslatedTexts.textFields.name: 'Nomi',
          TranslatedTexts.textFields.description: 'Tavsif',
          TranslatedTexts.textFields.amount: 'Miqdor',
          TranslatedTexts.textFields.date: 'Sana',
          TranslatedTexts.textFields.firstName: 'Ism',
          TranslatedTexts.textFields.lastName: 'Familiya',

          // User Management
          TranslatedTexts.users.users: 'Foydalanuvchilar',
          TranslatedTexts.users.add: 'Foydalanuvchi qo‘shish',
          TranslatedTexts.users.edit: 'Foydalanuvchini tahrirlash',
          TranslatedTexts.users.delete: 'Foydalanuvchini o‘chirish',
          TranslatedTexts.users.role: 'Foydalanuvchi roli',
          TranslatedTexts.users.permissions: 'Foydalanuvchi ruxsatlari',
          TranslatedTexts.buttons.edit: 'Tahrirlash',
          TranslatedTexts.alerts.enter_price: 'Narxni kiriting',

          // Support
          'support': 'Yordam',
          'contact_support': 'Yordam bilan bog‘lanish',
          'faq': 'Tez-tez so‘raladigan savollar',
          'terms_conditions': 'Foydalanish shartlari',
          'privacy_policy': 'Maxfiylik siyosati',

          // Errors
          'error': 'Xatolik',
          'no_internet': 'Internet aloqasi yo‘q',
          'invalid_credentials': 'Noto‘g‘ri elektron pochta yoki parol',
          TranslatedTexts.errors.pleaseEnterNumber: 'Iltimos, raqam kiriting!',

          'documents': 'Hujjatlar',

          // Table Fields
          TranslatedTexts.table.index: 'T/r',
          TranslatedTexts.table.name: 'Ism',
          TranslatedTexts.table.phoneNumber: 'Telefon raqam',
          TranslatedTexts.table.phoneNumber2: 'Qo‘shimcha telefon raqam',
          TranslatedTexts.table.address: 'Manzil',
          TranslatedTexts.table.buttons: 'Tugmalar',
          TranslatedTexts.table.qty: 'Miqdor',
          TranslatedTexts.table.incomePrice: 'Kelish narxi',
          TranslatedTexts.table.salePrice: 'Sotish narxi',
          TranslatedTexts.table.total: 'Jami',
          TranslatedTexts.table.typeOfProduct: 'Mahsulot turi',
          TranslatedTexts.table.totalOfProduct: 'Mahsulotlar soni',
          TranslatedTexts.table.documentType: 'Hujjat turi',
          TranslatedTexts.table.seeDetail: 'Tafsilotlarni ko‘rish',
          TranslatedTexts.table.category: 'Kategoriya',
          TranslatedTexts.table.status: 'Holat',
          TranslatedTexts.table.currency: 'Valyuta',
          TranslatedTexts.table.addingTime: 'Qo‘shilgan vaqt',
          TranslatedTexts.table.date: 'Sana',
          TranslatedTexts.table.isPaid: 'To‘langan',
          TranslatedTexts.table.debt: 'Qarz',
          TranslatedTexts.table.totalValue: 'Umumiy qiymat',
          TranslatedTexts.table.totalProfit: 'Umumiy foyda',
          TranslatedTexts.table.totalAmountPrice: 'Umumiy summa',
          TranslatedTexts.table.company: 'Kompaniya',
          TranslatedTexts.table.product: 'Mahsulot',
          TranslatedTexts.table.barcode: 'Shtrix-kod',
          TranslatedTexts.table.unit: 'O‘lchov birligi',

          // Buttons
          TranslatedTexts.buttons.enter: 'Kirish',
          TranslatedTexts.buttons.register: 'Ro‘yxatdan o‘tish',
          TranslatedTexts.buttons.search: 'Qidirish',
          TranslatedTexts.buttons.cancel: 'Bekor qilish',
          TranslatedTexts.buttons.save: 'Saqlash',
          TranslatedTexts.buttons.delete: 'O‘chirish',
          TranslatedTexts.buttons.add: 'Qo‘shish',
          TranslatedTexts.buttons.edit: 'Tahrirlash',
          TranslatedTexts.buttons.back: 'Orqaga',
          TranslatedTexts.buttons.update: 'Yangilash',
          TranslatedTexts.buttons.forDebt: 'Qarz uchun',
          TranslatedTexts.buttons.pay: 'To‘lash',
          TranslatedTexts.buttons.close: 'Yopish',
          TranslatedTexts.buttons.forBuilder: 'Quruvchi uchun',
          TranslatedTexts.buttons.exit: 'Chiqish',
          TranslatedTexts.buttons.confirm: 'Tasdiqlash',

          // Enters (Input hints/prompts)
          TranslatedTexts.alerts.enter_price: 'Narxni kiriting',
          TranslatedTexts.alerts.enter_name: 'Nomini kiriting',
          TranslatedTexts.alerts.enter_description: 'Tavsifni kiriting',
          TranslatedTexts.alerts.enter_amount: 'Miqdorini kiriting',
          TranslatedTexts.alerts.enter_date: 'Sana kiriting',
          TranslatedTexts.alerts.enter_client: 'Mijozni tanlang',
          TranslatedTexts.alerts.enter_product: 'Mahsulotni tanlang',
          TranslatedTexts.alerts.enter_category: 'Kategoriya tanlang',
          TranslatedTexts.alerts.enter_provider: 'Ta’minotchini tanlang',
          TranslatedTexts.alerts.enter_full_name: 'To‘liq ismni kiriting',
          TranslatedTexts.alerts.enter_phone_number:
              'Telefon raqamini kiriting',
          TranslatedTexts.alerts.enter_phone_number2:
              'Qo‘shimcha telefon raqamini kiriting',
          TranslatedTexts.alerts.enter_first_name: 'Ismni kiriting',
          TranslatedTexts.alerts.enter_last_name: 'Familiyani kiriting',
          TranslatedTexts.alerts.enter_currency: 'Valyutani tanlang',
          TranslatedTexts.alerts.enter_unit: 'O‘lchov birligini kiriting',
          TranslatedTexts.alerts.enter_qty: 'Soni kiriting',
          TranslatedTexts.alerts.enter_email: ' Elektron pochtani kiriting',

          // profits
          TranslatedTexts.profit.profit: 'Foyda',
          TranslatedTexts.profit.totalProfit: 'Umumiy foyda',
          TranslatedTexts.profit.totalIncome: 'Umumiy daromad',
          TranslatedTexts.profit.totalExpense: 'Umumiy xarajat',
          TranslatedTexts.profit.profitMargin: 'Foyda marjasi',
          TranslatedTexts.profit.profitPercentage: 'Foyda foizi',
          TranslatedTexts.profit.weeklyProfit: 'Haftalik foyda',
          TranslatedTexts.profit.monthlyProfit: 'Oylik foyda',
          TranslatedTexts.profit.yearlyProfit: 'Yillik foyda',
          TranslatedTexts.profit.profitByCategory: 'Kategoriya bo‘yicha foyda',
          TranslatedTexts.profit.profitByProduct: 'Mahsulot bo‘yicha foyda',

          // Statistics
          TranslatedTexts.statistics.statistics: 'Statistika',
          TranslatedTexts.statistics.salesStatistics: 'Savdo Statistikasi',
          TranslatedTexts.statistics.weeklySalesStatistics:
              'Haftalik savdo statistikasi',
          TranslatedTexts.statistics.monthlySalesStatistics:
              'Oylik savdo statistikasi',
          TranslatedTexts.statistics.yearlySalesStatistics:
              'Yillik savdo statistikasi',
          TranslatedTexts.statistics.salesByCategory:
              'Kategoriya bo‘yicha savdo',
          TranslatedTexts.statistics.salesByProduct: 'Mahsulot bo‘yicha savdo',
          'discount': 'Chegirma',
          'enter discount': 'Chegirmani kiriting',
          'discount_price': 'Chegirmadagi narx',
          'payment_info': "To'lov ma'lumotlari",
          "for_debt": "Qarzga",
          "select_customer_required": "Mijozni tanlashingiz shart",
          "select_customer_optional": "Mijozni tanlash ixtiyoriy",
          'store': 'Ombor',
          'note': 'Spiska',
          'add new document': 'Yangi hujjat qo‘shish',
        },
        'ru_RU': {
          // General
          'app_name': 'CRM Система',
          'hello': 'Привет',
          'welcome': 'Добро пожаловать в CRM систему',
          'logout': 'Выйти',
          'settings': 'Настройки',
          'language': 'Язык',

          // Authentication
          'login': 'Вход',
          'email': 'Электронная почта',
          'password': 'Пароль',
          'forgot_password': 'Забыли пароль?',
          'sign_in': 'Войти',
          'sign_out': 'Выйти',

          // Dashboard
          'dashboard': 'Панель управления',
          'total_clients': 'Всего клиентов',
          'total_sales': 'Общие продажи',
          'recent_activity': 'Недавняя активность',

          // Clients
          'clients': 'Клиенты',
          'add_client': 'Добавить клиента',
          'edit_client': 'Редактировать клиента',
          'delete_client': 'Удалить клиента',
          'client_details': 'Детали клиента',
          'client_name': 'Имя клиента',
          'client_email': 'Эл. почта клиента',
          'client_phone': 'Телефон клиента',

          // Products
          'products': 'Продукты',
          'add_product': 'Добавить продукт',
          'edit_product': 'Редактировать продукт',
          'delete_product': 'Удалить продукт',
          'product_name': 'Название продукта',
          'product_price': 'Цена продукта',
          'product_description': 'Описание продукта',

          // Sales
          'sales': 'Продажи',
          'add_sale': 'Добавить продажу',
          'sale_amount': 'Сумма продажи',
          'sale_date': 'Дата продажи',

          // Tasks
          'tasks': 'Задачи',
          'add_task': 'Добавить задачу',
          'edit_task': 'Редактировать задачу',
          'delete_task': 'Удалить задачу',
          'task_title': 'Название задачи',
          'task_description': 'Описание задачи',
          'task_due_date': 'Срок выполнения',

          // Notifications
          'notifications': 'Уведомления',
          'mark_all_as_read': 'Отметить все как прочитанные',
          'new_notification': 'Новое уведомление',

          // Reports
          'reports': 'Отчеты',
          'generate_report': 'Создать отчет',
          'report_type': 'Тип отчета',
          'report_date': 'Дата отчета',

          // User Management
          'users': 'Пользователи',
          'add_user': 'Добавить пользователя',
          'edit_user': 'Редактировать пользователя',
          'delete_user': 'Удалить пользователя',
          'user_role': 'Роль пользователя',
          'user_permissions': 'Права пользователя',

          // Support
          'support': 'Поддержка',
          'contact_support': 'Связаться с поддержкой',
          'faq': 'Часто задаваемые вопросы',
          'terms_conditions': 'Условия использования',
          'privacy_policy': 'Политика конфиденциальности',

          // Errors
          'error': 'Ошибка',
          'no_internet': 'Нет подключения к интернету',
          'invalid_credentials': 'Неверный email или пароль',
        },
      };
}
