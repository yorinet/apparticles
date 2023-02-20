import 'package:flutter/material.dart';
import 'package:appeasy/route.dart' as route;
//import 'globals.dart' as globals;

void main() {
  //globals.isLoggedIn = true;
  runApp(const AppEasy());
}

class AppEasy extends StatelessWidget {
  const AppEasy({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      title: 'Easy APP',
      onGenerateRoute: route.controller,
      initialRoute: route.loginPage,
    );
  }
}
