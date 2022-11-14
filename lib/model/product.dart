class Product {

  // String id;
  String? name;
  int? price;
  String? location;
  String? img;

  Product(this.name,this.price,this.location,this.img);

  static Product fromJson (Map<String, dynamic> json){
    return Product(
      json['name'],
      json['price'],
      json['location'],
      json['img']
    );
  }
}