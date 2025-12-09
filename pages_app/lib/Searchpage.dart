import 'package:flutter/material.dart';

class Searchpage extends StatefulWidget {
  @override
  _SearchpageState createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  List<Product> products = [
    Product('Laptop', 'Electronics', 'A high-performance laptop with 16GB RAM. ,' ,Icons.computer),
    Product('Running Shoes', 'Footwear', 'Comfortable running shoes for daily use.', Icons.directions_run),
    Product('Smartphone', 'Electronics', 'Latest model with an amazing camera.', Icons.phone_android),
    Product('Backpack', 'Accessories', 'Durable backpack for travel and work.' , Icons.backpack),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            leading: Icon(product.icon),
            title: Text(product.name),
            subtitle: Text(product.category),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ProductDetailsScreen(product: product),
                ),
              );
            },
          );
        },
      ),
    );
  }
}




class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  ProductDetailsScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Category: ${product.category}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              product.description,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class Product {
  final String name;
  final String category;
  final String description;
  final IconData icon;

  Product(this.name, this.category, this.description, this.icon);
}
