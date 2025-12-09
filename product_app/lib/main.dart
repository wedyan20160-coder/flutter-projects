import 'package:flutter/material.dart';

void main() {
  runApp(ProductApp());
}

class ProductApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Listing',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ProductListPage(),
    );
  }
}


class Product {
  final String name;
  final String description;
  final int price;
  final String imagePath;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
  });
}

final List<Product> products = [
  Product(
    name: 'iPhone',
    description: 'iPhone is the stylist phone ever',
    price: 1000,
    imagePath: 'assets/iphone.png',
  ),
  Product(
    name: 'Pixel',
    description: 'Pixel is the most featureful phone ever',
    price: 800,
    imagePath: 'assets/pixel.png',
  ),
  Product(
    name: 'Laptop',
    description: 'Laptop is most productive development tool',
    price: 2000,
    imagePath: 'assets/laptop.png',
  ),
  Product(
    name: 'Tablet',
    description: 'Tablet is the most useful device ever for meeting',
    price: 1500,
    imagePath: 'assets/tablet.png',
  ),
  Product(
    name: 'Pendrive',
    description: 'iPhone is the stylist phone ever',
    price: 100,
    imagePath: 'assets/pendrive.png',
  ),
];

class ProductListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Listing'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            margin: EdgeInsets.all(20),
            child: ListTile(
              leading: Container(
                width: 200,
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage(product.imagePath),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              title: Text(product.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailPage(product: product),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            Text(
              'الوصف:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(product.description),
            SizedBox(height: 20),
            Text(
              'السعر:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '${product.price} ريال',
              style: TextStyle(fontSize: 20, color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}