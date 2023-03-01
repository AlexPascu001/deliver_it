class CartModel {
  int? id;
  String? name;
  int? price;
  String? img;
  int? quantity;
  bool? isAdded;
  String? createdAt;

  CartModel(
      {this.id,
        this.name,
        this.price,
        this.img,
        this.quantity,
        this.isAdded = false,
        this.createdAt
      });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    img = json['img'];
    quantity = json['quantity'];
    isAdded = json['is_added'];
    createdAt = json['created_at'];
  }

}