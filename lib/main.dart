import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bloomista App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
      ),
      home: const CatalogScreen(),
    );
  }
}

//////////////////////////////////////
/// 1) CATALOG SCREEN
//////////////////////////////////////
class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  // قائمة السلة الحقيقية
  final List<Map<String, String>> cartItems = [];

  final List<Map<String, String>> flowerList = const [
    {
      "name": "Blue Roses",
      "price": "850 EGP",
      "img": "assets/blue.png",
      "discount": "-10%",
    },
    {
      "name": "Golden Roses",
      "price": "1200 EGP",
      "img": "assets/gold.png",
      "discount": "-15%",
    },
    {
      "name": "Red & White",
      "price": "950 EGP",
      "img": "assets/red_white.png",
      "discount": "-20%",
    },
    {
      "name": "Red Roses",
      "price": "750 EGP",
      "img": "assets/red.png",
      "discount": "-5%",
    },
  ];

  void addToCart(Map<String, String> product) {
    setState(() {
      cartItems.add(product);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${product['name']} added to cart!"),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        backgroundColor: Colors.pink.shade100,
        title: const Text(
          "Bloomista Shop",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.pink,
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ShoppingCartScreen(cartItems: cartItems),
                  ),
                ).then((_) => setState(() {})),
              ),
              if (cartItems.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.red,
                    child: Text(
                      "${cartItems.length}",
                      style: const TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SearchBar(
              hintText: "Search for bouquets...",
              leading: const Icon(Icons.search, color: Colors.pink),
              backgroundColor: WidgetStateProperty.all(Colors.white),
              elevation: WidgetStateProperty.all(1),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: flowerList.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  product: flowerList[index],
                  onAdd: () => addToCart(flowerList[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Map<String, String> product;
  final VoidCallback onAdd;
  const ProductCard({super.key, required this.product, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // الحل الصحيح - Expanded لتوزيع المساحة بشكل مرن
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(product['img']!, fit: BoxFit.contain),
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  product['name']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 2),
                if (product['discount'] != null &&
                    product['discount']!.isNotEmpty)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        product['discount']!,
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        product['price']!,
                        style: const TextStyle(
                          color: Colors.pink,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  )
                else
                  Text(
                    product['price']!,
                    style: const TextStyle(
                      color: Colors.pink,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                const SizedBox(height: 6),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 30),
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: onAdd,
                  child: const Text("Add", style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//////////////////////////////////////
/// 2) SHOPPING CART SCREEN
//////////////////////////////////////
class ShoppingCartScreen extends StatefulWidget {
  final List<Map<String, String>> cartItems;
  const ShoppingCartScreen({super.key, required this.cartItems});

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  late List<Map<String, String>> localCartItems;

  @override
  void initState() {
    super.initState();
    localCartItems = List.from(widget.cartItems);
  }

  void removeFromCart(int index) {
    setState(() {
      localCartItems.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Item removed from cart!"),
        duration: Duration(seconds: 1),
      ),
    );
  }

  int getTotalPrice() {
    int total = 0;
    for (var item in localCartItems) {
      String priceStr = item['price']!.replaceAll(' EGP', '');
      total += int.parse(priceStr);
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        backgroundColor: Colors.pink.shade100,
        title: const Text("Your Cart"),
        centerTitle: true,
      ),
      body: localCartItems.isEmpty
          ? const Center(child: Text("Your cart is empty!"))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: localCartItems.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          leading: Image.asset(
                            localCartItems[index]['img']!,
                            width: 50,
                            height: 50,
                            fit: BoxFit.contain,
                          ),
                          title: Text(
                            localCartItems[index]['name']!,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(localCartItems[index]['price']!),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                            ),
                            onPressed: () => removeFromCart(index),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total Amount",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${getTotalPrice()} EGP",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.pink,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: localCartItems.isEmpty
                            ? null
                            : () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text("Checkout"),
                                    content: Text(
                                      "Total amount: ${getTotalPrice()} EGP\n\nThank you for shopping at Bloomista!",
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text("Close"),
                                      ),
                                    ],
                                  ),
                                );
                              },
                        child: const Text(
                          "Checkout",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
