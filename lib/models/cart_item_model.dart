import 'package:nike_sneakers/models/shoe.dart';

class CartItemModel {
  final Shoe shoe;
  int quantity;

  CartItemModel({
    required this.shoe,
    this.quantity = 1,
  });

  double get totalPrice => double.parse(shoe.price) * quantity;
}

