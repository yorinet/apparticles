import 'package:flutter/material.dart';
import 'package:appeasy/route.dart' as route;

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, route.home);
              },
              child: Center(child: Text('Se connecter')),
            ),
          ],
        ),
      ),
    );
  }
}
