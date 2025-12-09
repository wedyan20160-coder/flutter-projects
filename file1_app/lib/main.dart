import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyFile());
}

class MyFile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignInPage(),
    );
  }
}

Future<File> _getFile() async {
  final dir = await getApplicationSupportDirectory();
  return File('${dir.path}/sign_file.txt');
}

Future<void> save(String username, String password, String department) async {
  final file = await _getFile();

  String line =
      "username_$username, password_$password, department_$department\n";

  await file.writeAsString(line, mode: FileMode.append);
}

Future<bool> checkValue(String username, String password) async {
  final file = await _getFile();

  if (!file.existsSync()) return false;

  List<String> lines = await file.readAsLines();

  for (var line in lines) {
    if (line.contains("username_$username") && line.contains("password_$password")) {
      return true;
    }
  }
  return false;
}

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign In")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: username,
              decoration: InputDecoration(labelText: "Username"),
            ),
            TextField(
              controller: password,
              obscureText: true,
              decoration: InputDecoration(labelText: "Password"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Login"),
              onPressed: () async {
                bool ok = await checkValue(username.text, password.text);

                if (ok) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => HomePage(username.text),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Invalid username or password")),
                  );
                }
              },
            ),
            TextButton(
              child: Text("Create new account"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SignUpPage()),
                );
              },
            ),
            TextButton(
              child: Text("Reset Password"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ResetPasswordPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController department = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: username,
              decoration: InputDecoration(labelText: "Username"),
            ),
            TextField(
              controller: password,
              decoration: InputDecoration(labelText: "Password"),
            ),
            TextField(
              controller: department,
              decoration: InputDecoration(labelText: "Department"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Save"),
              onPressed: () async {
                await save(
                  username.text,
                  password.text,
                  department.text,
                );

                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Account created successfully!")),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final String username;
  HomePage(this.username);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Center(
        child: Text(
          "Welcome, $username!",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  TextEditingController username = TextEditingController();
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Reset Password")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: username,
              decoration: InputDecoration(labelText: "Username"),
            ),
            TextField(
              controller: oldPassword,
              decoration: InputDecoration(labelText: "Old Password"),
            ),
            TextField(
              controller: newPassword,
              decoration: InputDecoration(labelText: "New Password"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Update"),
              onPressed: () async {
                bool ok = await checkValue(username.text, oldPassword.text);

                if (!ok) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Incorrect old password")),
                  );
                  return;
                }

                final file = await _getFile();
                List<String> lines = await file.readAsLines();

                file.writeAsStringSync("");

                for (var line in lines) {
                  if (line.contains("username_${username.text}")) {
                    await save(username.text, newPassword.text, "updated");
                  } else {
                    await file.writeAsString("$line\n", mode: FileMode.append);
                  }
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Password updated!")),
                );

                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
