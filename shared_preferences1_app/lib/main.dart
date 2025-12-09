import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'الإعدادات',
      home: SettingsPage(),
    );
  }
}

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late TextEditingController _usernameController;
  bool _darkModeEnabled = false;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _loadSettings();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username') ?? '';
    final darkMode = prefs.getBool('darkMode') ?? false;

    setState(() {
      _usernameController.text = username;
      _darkModeEnabled = darkMode;
    });

    print(' تم تحميل الإعدادات من الذاكرة:');
    print('   الاسم: "$username"');
    print('   الوضع الداكن: $darkMode');
  }

  Future<void> _saveSettings() async {
    final username = _usernameController.text.trim();
    final darkMode = _darkModeEnabled;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setBool('darkMode', darkMode);

    print(' تم حفظ الإعدادات:');
    print('   الاسم: "$username"');
    print('   الوضع الداكن: $darkMode');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم حفظ الإعدادات!')),
    );
  }

  Future<void> _clearSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    await prefs.remove('darkMode');

    setState(() {
      _usernameController.clear();
      _darkModeEnabled = false;
    });

    print(' تم مسح الإعدادات من الذاكرة.');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم مسح الإعدادات!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الإعدادات')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'اسم المستخدم',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            SwitchListTile(
              title: const Text('الوضع الداكن'),
              value: _darkModeEnabled,
              onChanged: (bool value) {
                setState(() {
                  _darkModeEnabled = value;
                });
              },
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _saveSettings,
                  child: const Text('حفظ الإعدادات'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _clearSettings,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('مسح الإعدادات'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}