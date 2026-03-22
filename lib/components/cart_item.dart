import 'package:flutter/material.dart';
import 'package:nike_sneakers/models/cart.dart';
import 'package:nike_sneakers/models/cart_item_model.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CartItem extends StatefulWidget {
  CartItemModel cartItem;
   CartItem({super.key, required this.cartItem});

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {

  void incrementQuantity(){
    Provider.of<Cart>(context, listen: false).incrementQuantity(widget.cartItem.shoe);
  }

  void decrementQuantity(){
    Provider.of<Cart>(context, listen: false).decrementQuantity(widget.cartItem.shoe);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          // Shoe Image - bigger
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              widget.cartItem.shoe.imagepath,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 15),
          
          // Shoe details and quantity controls
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Shoe Name
                Text(
                  widget.cartItem.shoe.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),
                
                // Price
                Text(
                  "\$${widget.cartItem.shoe.price}",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                
                // Quantity controls
                Row(
                  children: [
                    // Decrement button
                    GestureDetector(
                      onTap: decrementQuantity,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.remove,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    
                    // Quantity display
                    Text(
                      "${widget.cartItem.quantity}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(width: 15),
                    
                    // Increment button
                    GestureDetector(
                      onTap: incrementQuantity,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Total price for this item
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "\$${widget.cartItem.totalPrice.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 5),
              if (widget.cartItem.quantity > 1)
                Text(
                  "${widget.cartItem.quantity} x \$${widget.cartItem.shoe.price}",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
