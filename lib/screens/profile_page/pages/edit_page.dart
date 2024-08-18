import 'package:demoapp/widgets/bottom_nav_bar_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InputPage extends StatefulWidget {
  final String initialText1;
  final String initialText2;

  InputPage({this.initialText1 = '', this.initialText2 = ''});

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize controllers with provided values
    _nameController.text = widget.initialText1;
    _emailController.text = widget.initialText2;
  }

  // Save values to SharedPreferences
  void _saveValues() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('textField1', _nameController.text);
    await prefs.setString('textField2', _emailController.text);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => BottomNavigationPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveValues,
              child: Text('Save '),
            ),
          ],
        ),
      ),
    );
  }
}
