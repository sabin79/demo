import 'dart:io';
import 'dart:typed_data';

import 'package:demoapp/screens/home_page/home_page.dart';
import 'package:demoapp/screens/profile_page/pages/edit_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DisplayPage extends StatefulWidget {
  @override
  _DisplayPageState createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  String _name = '';
  String _email = '';
  File? _imageFile;
  Uint8List? _image;

  @override
  void initState() {
    super.initState();
    _loadValues();
  }

  Future<void> _pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
        _image = File(image.path).readAsBytesSync();
      });
    }
  }

  void _loadValues() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _name = prefs.getString('name') ?? '';
      _email = prefs.getString('email') ?? '';
    });
  }

  // Navigate back to InputPage for editing
  void _editValues() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InputPage(
          name: _name,
          email: _email,
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
                  child: Stack(
                    children: [
                      _image != null
                          ? Center(
                              child: CircleAvatar(
                                radius: 100,
                                backgroundImage: MemoryImage(_image!),
                              ),
                            )
                          : Icon(
                              Icons.image,
                              size: 300,
                              color: Colors.grey[400],
                            ),
                      Positioned(
                        bottom: -10,
                        right: 160,
                        child: Center(
                          // child: Icon(
                          //   Icons.add_a_photo,
                          //   size: 20,
                          // ),
                          child: IconButton(
                            icon: Icon(
                              Icons.add_a_photo,
                              size: 20,
                              color: Colors.black,
                            ),
                            onPressed: _pickImage,
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                // Center(
                //   child: ClipRRect(
                //     borderRadius: BorderRadius.circular(100),
                //     child: Image.network(
                //       "https://imgs.search.brave.com/xFkz2rHVRFxHB3pOHKPh-9VUyP9DKszbVpTUzIP9HvM/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93YWxs/cGFwZXJzLmNvbS9p/bWFnZXMvZmVhdHVy/ZWQvY29vbC1wcm9m/aWxlLXBpY3R1cmUt/ODdoNDZnY29iamw1/ZTR4dS5qcGc",
                //       height: 175,
                //       width: 175,
                //     ),
                //   ),
                // ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _editValues,
                  child: Text('Edit'),
                ),
                SizedBox(height: 20),
                Text(
                  "name : $_name",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10),
                Text(
                  "email : $_email",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10),
                TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    child: Text("See Your post ")),
                SizedBox(height: 10),
                _name.isNotEmpty && _email.isNotEmpty
                    ? SizedBox()
                    : Text(
                        "Please edit your profile",
                        style: TextStyle(fontSize: 18, color: Colors.red),
                      ),
                SizedBox()
              ],
            )));
  }
}
