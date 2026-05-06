import 'package:flutter/material.dart';

class ShoppingCartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFDEEF1), // لون الخلفية البينك
      appBar: AppBar(
        title: Text("Shopping Cart", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [Icon(Icons.shopping_cart_outlined, color: Colors.black)],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 3, // عدد المنتجات في العربة
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: ListTile(
                    leading: Icon(Icons.image, size: 50), // هنا هتحطي صوره الورد
                    title: Text("Red Roses Bouquet"),
                    subtitle: Text("750 EGP"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.remove_circle_outline),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text("1"),
                        ),
                        Icon(Icons.add_circle_outline, color: Colors.pink),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // الجزء اللي تحت (Total & Checkout)
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("Total"), Text("1500 EGP")],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[100],
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text("Proceed to Checkout", style: TextStyle(color: Colors.black)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}