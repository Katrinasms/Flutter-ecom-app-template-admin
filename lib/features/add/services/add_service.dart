import 'dart:convert';
import 'dart:io';
import 'package:seller_shop/features/home/home.dart';
import 'package:seller_shop/features/models/products.dart';
import 'package:seller_shop/features/utils/http_error_handle.dart';
import 'package:seller_shop/features/utils/snackbar.dart';
import 'package:seller_shop/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:seller_shop/constants/global_variables.dart';
import 'package:cloudinary_public/cloudinary_public.dart';

class AdminServices {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required image,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      final cloudinary = CloudinaryPublic('denfgaxvg', 'uszbstnu');
      String imageUrl = '';
      CloudinaryResponse res1 = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(image.path, folder: name),
      );
      imageUrl = res1.secureUrl;

      Product product = Product(
        name: name,
        description: description,
        provider: userProvider.user.name,
        quantity: 1,
        image: imageUrl,
        price: price,
      );
      http.Response res = await http.post(
        Uri.parse('$uri/admin/add-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: product.toJson(),
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Product Added Successfully!');
          Navigator.pushNamed(context, '/home');
          // Navigator.pop(context);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void editProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required String id,
    required String image,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      print('hi edit');
      print('hi' + name);
      Product product = Product(
          name: name,
          description: description,
          provider: userProvider.user.name,
          quantity: 1,
          image: image,
          price: price,
          id: id);
      print(product.provider);
      http.Response res = await http.post(
        Uri.parse('$uri/admin/edit-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: product.toJson(),
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Product Edited Successfully!');
          Navigator.pushNamed(context, '/home');
          // Navigator.pop(context);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    String name = userProvider.user.name;
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/admin/get-products/$name'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }
}
