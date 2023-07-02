import 'package:flutter/material.dart';
import 'package:seller_shop/features/add/add.dart';
import 'package:seller_shop/features/add/thank.dart';
import 'package:seller_shop/features/auth/screen/login.dart';
import 'package:seller_shop/features/auth/screen/register.dart';
// import 'package:seller_shop/features/home/bottom_bar.dart';
import 'package:seller_shop/features/home/home.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case '/':
      return MaterialPageRoute(builder: (context) => const Login());
    case '/register':
      return MaterialPageRoute(builder: (context) => const Register());
    case '/home':
      return MaterialPageRoute(builder: (context) => Home());
    case '/add':
      return MaterialPageRoute(builder: (context) => const Add());
    case '/thank':
      return MaterialPageRoute(builder: (context) => const Thank());
    default:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text('Screen Dose Not Exist!'),
                ),
              ));
  }
}
