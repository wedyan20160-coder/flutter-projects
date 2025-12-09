import 'package:flutter/material.dart';

void main() {
  runApp(MyList());
}

class MyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ListExample(),
    );
  }
}
class ListExample extends StatelessWidget {
  final List<Map<String, dynamic>> items = [
    {
      "title": "item 1", "subtitle": "subtitle1", "icon": Icons.home, },
    {
      "title": "item 2", "subtitle": "subtitle2", "icon": Icons.star,},
    {
      "title": "item 3", "subtitle": "subtitle3", "icon": Icons.settings, },

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My List"),
        backgroundColor: Colors.green,
      ),

      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(items[index]["icon"], size: 30),
            title: Text(items[index]["title"]),
            subtitle: Text(items[index]["subtitle"]),

            onTap: () {
              print(items[index]['title']);
            },
          );
        },
      ),
    );
  }
}
