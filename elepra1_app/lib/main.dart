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
      home: MyHomePage(title: 'السبحة الالكترونية'),
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
  int subhanAllah = 0;
  int alhamdulillah = 0;
  int allahuAkbar = 0;

  void resetAll() {
    setState(() {
      subhanAllah = 0;
      alhamdulillah = 0;
      allahuAkbar = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: resetAll,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildTasbeeh('سبحان الله', subhanAllah, () {
              setState(() {
                subhanAllah++;
              });
            }),
            const SizedBox(height: 20),
            buildTasbeeh('الحمد لله', alhamdulillah, () {
              setState(() {
                alhamdulillah++;
              });
            }),
            const SizedBox(height: 20),
            buildTasbeeh('الله أكبر', allahuAkbar, () {
              setState(() {
                allahuAkbar++;
              });
            }),
          ],
        ),
      ),
    );
  }

  Widget buildTasbeeh(String text, int count, VoidCallback onPressed) {
    return Column(
      children: [
        Text(
          text,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          '$count',
          style: const TextStyle(fontSize: 24, color: Colors.blue),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: onPressed,
          child: const Text('اضغط'),
        ),
      ],
    );
  }
}