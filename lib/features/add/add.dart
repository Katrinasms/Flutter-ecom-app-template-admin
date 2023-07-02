import 'dart:io';
import 'package:flutter/material.dart';
import 'package:seller_shop/features/add/services/add_service.dart';
import 'package:seller_shop/features/auth/service/auth_services.dart';
import 'package:seller_shop/features/models/products.dart';
import 'package:image_picker/image_picker.dart';

class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);

  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  FocusNode myFocusNode = FocusNode();
  FocusNode myFocusNode1 = FocusNode();
  FocusNode myFocusNode2 = FocusNode();
  final _addProductFormKey = GlobalKey<FormState>();
  final AdminServices adminServices = AdminServices();

  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  late String id;
  late String image;
  File? _image;

  void sellProduct() {
    if (_addProductFormKey.currentState!.validate()) {
      adminServices.sellProduct(
          context: context,
          name: productNameController.text,
          description: descriptionController.text,
          price: double.parse(priceController.text),
          image: _image);
    }
  }

  void editProduct() {
    if (_addProductFormKey.currentState!.validate()) {
      adminServices.editProduct(
        context: context,
        name: productNameController.text,
        description: descriptionController.text,
        price: double.parse(priceController.text),
        id: id,
      );
    }
  }

  Future getImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;

    final imageTemp = File(image.path);

    setState(() {
      this._image = imageTemp;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _product = ModalRoute.of(context)?.settings.arguments;
    final headingText = _product != null ? 'Edit Product' : 'Add Product';
    if (_product != null) {
      final _prod = _product as Product;
      productNameController.text = _prod.name;
      descriptionController.text = _prod.description;
      priceController.text = _prod.price.toString();
      id = _prod.id as String;
      image = _prod.image as String;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(headingText,
            style: TextStyle(fontSize: 30.0, color: Color(0xFF6C6C6C))),
        backgroundColor: Color(0xFFD9D9D9),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 40.0, right: 40.0, top: 30),
            child: Form(
                key: _addProductFormKey,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () => getImage(ImageSource.gallery),
                      child: _product != null
                          ? Image.network(
                              image,
                              height: 250,
                              width: 250,
                              fit: BoxFit.cover,
                            )
                          : _image != null
                              ? Image.file(_image!,
                                  width: 250, height: 250, fit: BoxFit.cover)
                              : Image.network(
                                  'https://picsum.photos/250?image=9',
                                  height: 200,
                                  width: 400,
                                  fit: BoxFit.cover,
                                ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40, bottom: 20.0),
                      child: TextFormField(
                        controller: productNameController,
                        focusNode: myFocusNode1,
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 40, 25, 25),
                                  width: 2.0),
                            ),
                            labelText: 'Product Name',
                            labelStyle: TextStyle(
                                color: myFocusNode1.hasFocus
                                    ? const Color.fromARGB(255, 21, 40, 55)
                                    : Color(0xFF6C6C6C))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: TextFormField(
                        controller: descriptionController,
                        // obscureText: true,
                        focusNode: myFocusNode,
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 40, 25, 25),
                                  width: 2.0),
                            ),
                            labelText: 'Description',
                            labelStyle: TextStyle(
                                color: myFocusNode.hasFocus
                                    ? const Color.fromARGB(255, 21, 40, 55)
                                    : Color(0xFF6C6C6C))),
                      ),
                    ),
                    TextFormField(
                      // obscureText: true,
                      focusNode: myFocusNode2,
                      controller: priceController,
                      decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 40, 25, 25),
                                width: 2.0),
                          ),
                          labelText: 'Price',
                          labelStyle: TextStyle(
                              color: myFocusNode2.hasFocus
                                  ? const Color.fromARGB(255, 21, 40, 55)
                                  : Color(0xFF6C6C6C))),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                          ),
                          onPressed: () {
                            _product != null ? editProduct() : sellProduct();
                            // Navigator.pushNamed(context, '/home');
                          },
                          // _product != null ? editProduct : sellProduct,

                          child: Text(headingText)),
                    ),
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                          ),
                          onPressed: () =>
                              Navigator.pushNamed(context, '/home'),
                          child: Text('Back')),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
