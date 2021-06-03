import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DeveloperPage extends StatelessWidget {
  const DeveloperPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Mustafa AKIL',
              style: TextStyle(fontSize: 40, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _appbar() {
    return AppBar(title: const Text('Gelistirici'));
  }
}
