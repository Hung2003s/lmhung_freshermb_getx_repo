import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiEndpoint {
  // BASE_URL
  static String url = dotenv.env['BASE_URL'] ?? '';

  // API URL
  static String login = '$url/login';
  static String register = '$url/register';
  static String categories = '$url/categories';
  static String product = '$url/products';
}