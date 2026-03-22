import 'package:flutter/material.dart';
import 'package:nike_sneakers/components/bottom_nav.dart';
import 'package:nike_sneakers/pages/cart_page.dart';
import 'package:nike_sneakers/pages/shop_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = const [
    ShopPage(),
    CartPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Padding(
              padding: EdgeInsets.only(left: 12.0),
              child: Icon(Icons.menu, color: Colors.black),
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.grey[900],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.grey[900],
                  alignment: Alignment.center,
                  child: Image.asset(
                    "lib/images/nike.png",
                    color: Colors.white,
                    height: 120,
                  ),
                ),
                Divider(color: Colors.grey[800]),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    leading: const Icon(Icons.home, color: Colors.white),
                    title: const Text("Home",
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.pop(context);
                      setState(() {
                        _selectedIndex = 0;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    leading: const Icon(Icons.info, color: Colors.white),
                    title: const Text("About",
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("About"),
                          content: const Text("Coming Soon"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("OK"),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, bottom: 25),
              child: ListTile(
                leading: const Icon(Icons.logout, color: Colors.white),
                title: const Text("Logout",
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: MyBottomNavBar(
        onTabChange: (index) => navigateBottomBar(index),
      ),
    );
  }
}
