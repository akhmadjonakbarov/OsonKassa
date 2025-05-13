import 'package:get/get.dart';

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
          'login': 'Kirish',
          'email': 'Elektron pochta',
          'password': 'Parol',
          'forgot_password': 'Parolni unutdingizmi?',
          'sign_in': 'Tizimga kirish',
          'sign_out': 'Chiqish',

          // Dashboard
          'dashboard': 'Boshqaruv paneli',
          'total_clients': 'Jami mijozlar',
          'total_sales': 'Jami savdo',
          'recent_activity': 'So‘nggi faoliyat',

          // Clients
          'clients': 'Mijozlar',
          'add_client': 'Mijoz qo‘shish',
          'edit_client': 'Mijozni tahrirlash',
          'delete_client': 'Mijozni o‘chirish',
          'client_details': 'Mijoz tafsilotlari',
          'client_name': 'Mijoz nomi',
          'client_email': 'Mijoz elektron pochtasi',
          'client_phone': 'Mijoz telefoni',

          // Products
          'products': 'Mahsulotlar',
          'add_product': 'Mahsulot qo‘shish',
          'edit_product': 'Mahsulotni tahrirlash',
          'delete_product': 'Mahsulotni o‘chirish',
          'product_name': 'Mahsulot nomi',
          'product_price': 'Mahsulot narxi',
          'product_description': 'Mahsulot tavsifi',

          // Sales
          'sales': 'Savdo',
          'add_sale': 'Savdo qo‘shish',
          'sale_amount': 'Savdo summasi',
          'sale_date': 'Savdo sanasi',

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
          'reports': 'Hisobotlar',
          'generate_report': 'Hisobot yaratish',
          'report_type': 'Hisobot turi',
          'report_date': 'Hisobot sanasi',

          // User Management
          'users': 'Foydalanuvchilar',
          'add_user': 'Foydalanuvchi qo‘shish',
          'edit_user': 'Foydalanuvchini tahrirlash',
          'delete_user': 'Foydalanuvchini o‘chirish',
          'user_role': 'Foydalanuvchi roli',
          'user_permissions': 'Foydalanuvchi ruxsatlari',

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
