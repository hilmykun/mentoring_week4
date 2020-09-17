part of 'network.dart';

class NetworkUrl{
  static String url = "http://192.168.56.1/ecommerce-server";
  static String getProduct(){
    return "$url/getProduct.php";
  }

  static String getProductCategory(){
    return "$url/getProductWithCategory.php";
  }
}