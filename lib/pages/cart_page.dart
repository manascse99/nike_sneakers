import 'package:flutter/material.dart';
import 'package:nike_sneakers/components/cart_item.dart';
import 'package:nike_sneakers/models/cart.dart';
import 'package:nike_sneakers/models/cart_item_model.dart';
import 'package:nike_sneakers/pages/address_page.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(builder: (context,value,child)=>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "My Cart!",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
            ),
            const SizedBox(
              height: 20,
            ),

            Expanded(
              child: value.getUserCart().isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_bag_outlined,
                        size: 80,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Your cart is empty",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                itemCount: value.getUserCart().length,
                itemBuilder: (context,index){
              // get individual cart item
              CartItemModel cartItem = value.getUserCart()[index];
              
              // return the cart items
              return CartItem(
                cartItem: cartItem,
              );

            },),
            ),

            // Total amount section
            if (value.getUserCart().isNotEmpty)
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(20.0),
              margin: const EdgeInsets.only(bottom: 20, top: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Subtotal",
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "\$${value.calculateTotal()}",
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Delivery",
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "Free",
                        style: TextStyle(
                          color: Colors.green[700],
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    height: 30,
                    thickness: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        "\$${value.calculateTotal()}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Checkout button
            if (value.getUserCart().isNotEmpty)
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddressPage(),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(25),
                margin: const EdgeInsets.only(bottom: 20),
                child: const Center(
                  child: Text(
                    "Checkout",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    ),
    );
  }
}
