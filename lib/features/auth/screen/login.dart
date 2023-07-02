import 'package:flutter/material.dart';
import 'package:seller_shop/features/auth/service/auth_services.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FocusNode myFocusNode = FocusNode();
  FocusNode myFocusNode1 = FocusNode();
  final AuthService authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _signInFormKey = GlobalKey<FormState>();

  void signInUser() {
    authService.signInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 150.0),
            child: Center(
              child: Text('ShopShop', style: TextStyle(fontSize: 60.0)),
            ),
          ),
          Center(
            child: Text('Admin', style: TextStyle(fontSize: 25.0)),
          ),
          Container(
            padding: EdgeInsets.only(top: 100, left: 40.0, right: 40.0),
            child: Form(
                key: _signInFormKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: TextFormField(
                        focusNode: myFocusNode1,
                        controller: _emailController,
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 40, 25, 25),
                                  width: 2.0),
                            ),
                            labelText: 'Enter your Email',
                            labelStyle: TextStyle(
                                color: myFocusNode1.hasFocus
                                    ? const Color.fromARGB(255, 21, 40, 55)
                                    : Color(0xFF6C6C6C))),
                      ),
                    ),
                    TextFormField(
                      obscureText: true,
                      focusNode: myFocusNode,
                      controller: _passwordController,
                      decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 40, 25, 25),
                                width: 2.0),
                          ),
                          labelText: 'Enter your password',
                          labelStyle: TextStyle(
                              color: myFocusNode.hasFocus
                                  ? const Color.fromARGB(255, 21, 40, 55)
                                  : Color(0xFF6C6C6C))),
                    ),
                    const SizedBox(height: 80),
                    SizedBox(
                      width: 100,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                          ),
                          onPressed: signInUser,
                          // () =>
                          //     Navigator.pushNamed(context, '/home'),
                          child: Text('Log In')),
                    ),
                    SizedBox(
                      width: 100,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                          ),
                          onPressed: () =>
                              Navigator.pushNamed(context, '/register'),
                          child: Text('Register')),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
