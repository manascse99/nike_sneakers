import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nike_sneakers/components/shoe_tile.dart';
import 'package:nike_sneakers/models/shoe.dart';
import 'package:nike_sneakers/models/cart.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {

  void addShoeToCart(Shoe shoe){
    Provider.of<Cart>(context, listen: false).addItemToCart(shoe);

    // alert the user that shoe is successfully added yani alert bhejo ki shoe add 
    // hoagaya hai pop up type

    showDialog(context: context, builder: (context)=> AlertDialog(
      title: Text("Successfully added"),
      content: Text("Check your cart"),
    ));
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, value, child) => Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(horizontal: 25),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Search",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                "Classic silhouettes and cutting-edge innovation to build your game from the ground up.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[700],
                ),
              ),
            ),
          ),

         
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                Text(
                  "Hot picks 🔥",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                Text(
                  "See all",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),


          Expanded(
            child: ListView.builder(
              itemCount: value.getShoeList().length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
              
                Shoe shoe = value.getShoeList()[index];

              

                return ShoeTile(
                  shoe: shoe,
                  onTap: () => addShoeToCart(shoe),
                );
              },
            ),
          ),

          const Padding(
            padding: EdgeInsets.only(
              top: 25.0,
              left: 25,
              right: 25,
            ),
            child: Divider(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
