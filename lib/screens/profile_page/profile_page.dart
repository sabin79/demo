import 'package:demoapp/screens/profile_page/pages/edit_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DisplayPage extends StatefulWidget {
  @override
  _DisplayPageState createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  String _textField1 = '';
  String _textField2 = '';

  @override
  void initState() {
    super.initState();
    _loadValues();
  }

  // Load stored values from SharedPreferences
  void _loadValues() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _textField1 = prefs.getString('textField1') ?? '';
      _textField2 = prefs.getString('textField2') ?? '';
    });
  }

  // Navigate back to InputPage for editing
  void _editValues() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InputPage(
          initialText1: _textField1,
          initialText2: _textField2,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Profile Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  "https://imgs.search.brave.com/xFkz2rHVRFxHB3pOHKPh-9VUyP9DKszbVpTUzIP9HvM/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93YWxs/cGFwZXJzLmNvbS9p/bWFnZXMvZmVhdHVy/ZWQvY29vbC1wcm9m/aWxlLXBpY3R1cmUt/ODdoNDZnY29iamw1/ZTR4dS5qcGc",
                  height: 175,
                  width: 175,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              _textField1,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              _textField2,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _editValues,
              child: Text('Edit'),
            ),
          ],
        ),
      ),
    );
  }
}
