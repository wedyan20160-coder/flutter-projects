import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SharedPage(),
  ));
}

class SharedPage extends StatefulWidget {
  const SharedPage({super.key});

  @override
  State<SharedPage> createState() => _SharedPageState();
}

class _SharedPageState extends State<SharedPage> {
  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();

  Future<void> _storeData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('TextField1', _controller1.text.trim());
    _controller1.clear();
  }

  Future<void> _getData() async {
    final prefs = await SharedPreferences.getInstance();
    final text = prefs.getString('TextField1') ?? '';
    _controller2.text = text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SharedPreferences'),
        backgroundColor: Colors.grey[600],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _controller1,
              decoration: InputDecoration(labelText: 'الحقل الأول'),
            ),
            ElevatedButton(
              onPressed: _storeData,
              child: Text('تخزين'),
            ),
            TextField(
              controller: _controller2,
              decoration: InputDecoration(labelText: 'الحقل الثاني'),
            ),
            ElevatedButton(
              onPressed: _getData,
              child: Text('جلب'),
            ),
          ],
        ),
      ),
    );
  }
}
