import 'package:flutter/material.dart';
import 'package:nike_sneakers/models/shoe.dart';
import 'package:nike_sneakers/models/cart_item_model.dart';

class Cart extends ChangeNotifier{
  // list of shoes for sale
  List<Shoe> shoeShop = [
    Shoe(
      name: 'Zoom FREAK', 
      price: "236", 
      imagepath: "lib/images/zoom.png",
      description: "The Nike Zoom Fly 6 is a lighter, redesigned speed-training hybrid with responsive"
    ),
    Shoe(
      name: 'Air-Freek', 
      price: "500", 
      imagepath: "lib/images/Nike_jordan.png",
      description: "Air Jordan is a popular line of basketball shoes, apparel, and accessories"
    ),
    Shoe(
      name: 'Kyrie', 
      price: "456", 
      imagepath: "lib/images/kyrie.png",
      description: "Irving also incorporated unique 3D graphic elements into the shoe that symbolize different stories from his life."
    ),
    Shoe(
      name: 'KDTREY', 
      price: "250", 
      imagepath: "lib/images/KDTREY.png",
      description: "With its lightweight upper and plush support system, the KD Trey 5 X can help you float like KD, waiting for the perfect moment to drive to the hoop. "
    ),
    Shoe(
      name: 'Air Force 1', 
      price: "320", 
      imagepath: "lib/images/air_force.png",
      description: "The radiance lives on in the Nike Air Force 1, the basketball original that puts a fresh spin on what you know best."
    ),
    

  ];

  // list of items in your cart with quantities
  List<CartItemModel> userCart = [];

  // get list of itmes in your sale

  List<Shoe> getShoeList (){
    return shoeShop;
  }

  // get cart
  List<CartItemModel> getUserCart(){
    return userCart;
  }

  // add items to your cart (increment quantity if exists)
  void addItemToCart(Shoe shoe){
    // Check if shoe already exists in cart
    int existingIndex = userCart.indexWhere((item) => item.shoe.name == shoe.name);
    
    if (existingIndex != -1) {
      // If exists, increment quantity
      userCart[existingIndex].quantity++;
    } else {
      // If not exists, add new item
      userCart.add(CartItemModel(shoe: shoe, quantity: 1));
    }
    notifyListeners();
  }

  // remove item from your cart (decrement quantity or remove if quantity is 1)
  void removeItemFromCart(Shoe shoe){
    int existingIndex = userCart.indexWhere((item) => item.shoe.name == shoe.name);
    
    if (existingIndex != -1) {
      if (userCart[existingIndex].quantity > 1) {
        // If quantity > 1, decrement
        userCart[existingIndex].quantity--;
      } else {
        // If quantity is 1, remove from cart
        userCart.removeAt(existingIndex);
      }
      notifyListeners();
    }
  }

  // increment quantity of a specific item
  void incrementQuantity(Shoe shoe) {
    int existingIndex = userCart.indexWhere((item) => item.shoe.name == shoe.name);
    if (existingIndex != -1) {
      userCart[existingIndex].quantity++;
      notifyListeners();
    }
  }

  // decrement quantity of a specific item
  void decrementQuantity(Shoe shoe) {
    int existingIndex = userCart.indexWhere((item) => item.shoe.name == shoe.name);
    if (existingIndex != -1) {
      if (userCart[existingIndex].quantity > 1) {
        userCart[existingIndex].quantity--;
      } else {
        userCart.removeAt(existingIndex);
      }
      notifyListeners();
    }
  }

  // calculate total
  String calculateTotal(){
    double total = 0;
    for (var cartItem in userCart) {
      total += cartItem.totalPrice;
    }
    return total.toStringAsFixed(2);
  }

  // clear cart
  void clearCart(){
    userCart.clear();
    notifyListeners();
  }

}