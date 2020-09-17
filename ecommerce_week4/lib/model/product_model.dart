part of 'model.dart';

class ProductModel {
  final String idProduct;
  final String productName;
  final int sellingPrice;
  final String createDate;
  final String cover;
  final String status;
  final String description;

  ProductModel(
      {this.idProduct,
      this.productName,
      this.sellingPrice,
      this.createDate,
      this.cover,
      this.status,
      this.description});

      factory ProductModel.fromJson(Map<String, dynamic> json){
        return ProductModel(
          idProduct: json['idProduct'],
          productName: json['productName'],
          sellingPrice: json['sellingPrice'],
          createDate: json['createDate'],
          cover: json['cover'],
          status: json['status'],
          description: json['description'],

        );
      }
}
