import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'السبحة الالكترونية',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'السبحة الالكترونية'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int counter = 0;
  String text = "سبحان الله";

  void _incrementCounter() {
    setState(() {
      counter++;
      if (counter == 33 && text == "سبحان الله") {
        text = "الحمد لله";
        counter = 0;
      } else if (counter == 33 && text == "الحمد لله") {
        text = "الله أكبر";
        counter = 0;
      } else if (counter == 33 && text == "الله أكبر") {
        text = "سبحان الله";
        counter = 0;
      }
    });
  }

  void _resetCounters() {
    setState(() {
      counter = 0;
      text = "سبحان الله";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: _resetCounters,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              text,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              '$counter',
              style: const TextStyle(fontSize: 40),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _incrementCounter,
              child: const Text('اضغط'),
            ),
          ],
        ),
      ),
    );
  }
}