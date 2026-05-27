import 'package:get/get.dart';

class En extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          // Dashboard
          'app_title': 'Warehouse Management',

          // Profile AppBar
          'greeting_morning': 'Good morning,',
          'greeting_afternoon': 'Good afternoon,',
          'greeting_evening': 'Good evening,',

          // Home Page
          'warehouse_overview': 'Warehouse Overview',
          'updated_at': 'Updated at: 08:30 AM, 24/10/2023',
          'quick_actions': 'Quick Actions',
          'add_product': 'Add Product',
          'add_category': 'Add Category',
          'category_name': 'Category name',
          'save': 'Save',
          'total_products': 'Total Products',

          // Category Page
          'manage': 'Manage',
          'category': 'Category',
          'search_category': 'Search category',
          'growing': 'growing',
          'delete_category_confirm': 'Are you sure you want to delete this category?',
          'cancel': 'Cancel',
          'confirm': 'Confirm',
          'update_category': 'Update Category',
          'edit': 'Edit',
          'delete': 'Delete',
          'products_count': '@s products',

          // Product Page
          'products': 'Products',
          'in_stock': 'In stock',
          'delete_product_confirm': 'Are you sure you want to delete this product?',
          'sort_filter': 'Sort & Filter',
          'showing_products': 'Showing @s products',
          'newest': 'Newest',
          'all_categories': 'All categories',
          'select_category': 'Select category',
          'all': 'All',

          // Product Info Page
          'add_new_product': 'Add New Product',
          'edit_product': 'Edit Product',
          'product_details': 'Product Details',
          'product_image': 'Product Image',
          'add_image': 'Add Image',
          'enter_product_name': 'Enter product name',
          'product_name': 'Product Name',
          'product_category': 'Product Category',
          'sku_example': 'E.g: SP-001',
          'sku_code': 'SKU/Code',
          'price_hint': 'Enter price',
          'selling_price': 'Selling Price',
          'stock_example': 'E.g: 100',
          'quantity': 'Quantity',
          'product_description_hint': 'Enter product description',
          'description': 'Description',
          'create_new_product': 'Create New Product',
          'save_changes': 'Save Changes',

          // Validation Messages
          'name_required': 'Name is required',
          'code_required': 'Code is required',
          'code_exists': 'Product code already exists',
          'price_required': 'Price is required',
          'price_invalid': 'Invalid price',
          'price_positive': 'Price must be greater than 0',
          'stock_invalid': 'Invalid stock quantity',
          'stock_non_negative': 'Stock must be greater than or equal to 0',
          'category_required': 'Category is required',
          'category_invalid': 'Invalid category',

          // Snackbar Messages
          'add_success': 'Add successful',
          'add_failed': 'Add failed',
          'update_success': 'Update successful',
          'update_failed': 'Update failed',
          'delete_success': 'Delete successful',
          'delete_failed': 'Delete failed',
          'login_success': 'Login successful',
          'login_failed': 'Login failed',
          'register_success': 'Register successful',
          'register_failed': 'Register failed',
          'invalid_credentials': 'Please enter your credentials.',
          'login_locked': 'Account is temporarily locked. Please try again in @s minutes.',
          'login_attempts_left': '@s attempts remaining before lockout.',
          'login_locked_button': 'Locked',
          'no_products_in_category': 'No products found for this category',
          'error_title': 'Error',
          'logout_failed': 'Logout failed',

          // Sort Options
          'sort_name_asc': 'Name: A -> Z',
          'sort_name_desc': 'Name: Z -> A',
          'sort_price_desc': 'Price: High -> Low',
          'sort_price_asc': 'Price: Low -> High',
          'sort_stock_asc': 'Quantity: Low -> High',
          'sort_stock_desc': 'Quantity: High -> Low',

          // Settings
          'settings_title': 'Settings',
          'theme': 'Theme',
          'language': 'Language',
          'system_mode': 'System',
          'system_mode_desc': 'Follow device settings',
          'light_mode': 'Light',
          'light_mode_desc': 'Always use light theme',
          'dark_mode': 'Dark',
          'dark_mode_desc': 'Always use dark theme',
          'logout': 'Logout',
          'logout_confirm': 'Are you sure you want to logout?',
          // Search
          'search_hint': 'Search...',

          // Auth - Login
          'welcome_back': 'Welcome back',
          'login_description': 'Log in to manage your warehouse',
          'username': 'Username',
          'password': 'Password',
          'forgot_password': 'Forgot password?',
          'login': 'Login',
          'no_account': "Don't have an account?",
          'register': 'Register',
          'or_login_with': 'Or login with',
          'help': 'Help',
          'need_help': 'Need help?',
          'contact_support': 'Contact support',

          // Auth - Register
          'register_title': 'Register account',
          'or_register_with': 'Or register with',
        },
      };
}