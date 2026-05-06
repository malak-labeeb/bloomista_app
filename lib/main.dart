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
      home: const CategoriesScreen(),
    );
  }
}

//////////////////////////////////////
/// 1) CATEGORIES SCREEN
//////////////////////////////////////

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        backgroundColor: Colors.pink.shade100,
        elevation: 0,
        title: const Text("Categories", style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 30,
          mainAxisSpacing: 30,
          children: [
            categoryCircle(context, "Anniversary", Icons.star),
            categoryCircle(context, "Birthday", Icons.cake),
            categoryCircle(context, "Apology", Icons.favorite),
            categoryCircle(context, "Seasonal", Icons.local_florist),
          ],
        ),
      ),
    );
  }

  Widget categoryCircle(BuildContext context, String title, IconData icon) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ProductDetailsScreen(),
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.pink.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 45, color: Colors.pink),
          ),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

//////////////////////////////////////
/// 2) PRODUCT DETAILS SCREEN
//////////////////////////////////////

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        backgroundColor: Colors.pink.shade100,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Product Details",
            style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),

          /// الصورة
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                "assets/rose.jpg",
                height: 240,
                width: 240,
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(height: 10),

          /// dots
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Dot(active: true),
              Dot(),
              Dot(),
            ],
          ),

          const SizedBox(height: 20),

          /// النص (مترتب صح + خط كبير)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                
                

                /// العنوان
                Text(
                  "The best selling bouquet",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 8),
                /// السعر الأول
                Text(
                  "1,500 EGP",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink,
                  ),
                ),

                SizedBox(height: 8),

                /// الوصف
                Text(
                  "A unique handmade masterpiece featuring 50 elegant red satin roses. Crafted with precision to be a truly one-of-a-kind gift that lasts forever.",
                  style: TextStyle(
                    fontSize: 22,
                    height: 1.9,
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),

          /// الزرار
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  "Add to cart",
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//////////////////////////////////////
/// DOT
//////////////////////////////////////

class Dot extends StatelessWidget {
  final bool active;
  const Dot({this.active = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: active ? 12 : 8,
      height: active ? 12 : 8,
      decoration: BoxDecoration(
        color: active ? Colors.pink : Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }
}