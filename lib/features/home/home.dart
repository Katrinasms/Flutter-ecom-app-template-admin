import 'package:flutter/material.dart';
import 'package:seller_shop/constants/loader.dart';
import 'package:seller_shop/features/add/add.dart';
import 'package:seller_shop/features/add/services/add_service.dart';
import 'package:seller_shop/features/auth/service/auth_services.dart';
import 'package:seller_shop/features/models/products.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Product> items = [
    Product(
        name: 'Product1',
        provider: 'ProductAdmin1',
        description: "The Product is cute",
        quantity: 1,
        image: "source",
        price: 10),
    Product(
        name: 'Product2',
        provider: 'ProductAdmin2',
        description: "The Product is cute",
        quantity: 1,
        image: "source",
        price: 20),
    Product(
        name: 'Product3',
        provider: 'ProductAdmin3',
        description: "The Product is cute",
        quantity: 1,
        image: "source",
        price: 30),
  ];

  List<Product>? products;
  final AdminServices adminServices = AdminServices();
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  fetchAllProducts() async {
    products = await adminServices.fetchAllProducts(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('ShopShop',
                style: TextStyle(fontSize: 30.0, color: Color(0xFF6C6C6C))),
            backgroundColor: Color(0xFFD9D9D9),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.logout),
                tooltip: 'Show Snackbar',
                onPressed: () => authService.logOut(context),
              ),
            ]),
        body: products == null
            ? const Loader()
            : Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                ),
                child: ListView.builder(
                  itemCount: products?.length,
                  itemBuilder: (context, index) {
                    final productData = products![index];
                    return Padding(
                      padding:
                          const EdgeInsets.only(top: 1.0, left: 10, right: 10),
                      child: Column(
                        children: [
                          Card(
                            color: Colors.grey[200],
                            // Define the shape of the card
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),

                            // Define how the card's content should be clipped
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            // Define the child widget of the card
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                // Add padding around the row widget
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      // Add an image widget to display an image
                                      Image.network(
                                        productData.image,
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.cover,
                                      ),
                                      // Add some spacing between the image and the text
                                      Container(width: 20),
                                      // Add an expanded widget to take up the remaining horizontal space
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            // Add some spacing between the top of the card and the title
                                            Container(height: 5),
                                            // Add a title widget
                                            Text(productData.provider,
                                                style: TextStyle(
                                                    fontSize: 10.0,
                                                    color: Colors.grey[500])),

                                            Text(
                                              productData.name,
                                              style: TextStyle(
                                                  fontSize: 30.0,
                                                  color: Colors.black),
                                            ),

                                            Text(
                                              productData.description,
                                              maxLines: 2,
                                              style: TextStyle(
                                                  fontSize: 10.0,
                                                  color: Colors.grey[500]),
                                            ),
                                            Text(
                                              'USD ' +
                                                  productData.price.toString(),
                                              style: TextStyle(
                                                fontSize: 18.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(height: 1.5, color: Colors.black),

                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const Add(),
                                            // Pass the arguments as part of the RouteSettings. The
                                            // DetailScreen reads the arguments from these settings.
                                            settings: RouteSettings(
                                              arguments: productData,
                                            ),
                                          ),
                                        );
                                      },
                                      // () =>
                                      //     Navigator.pushNamed(context, '/add'),
                                      child: Text('Edit')),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
        floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.pushNamed(context, '/add'),
            child: Icon(Icons.add_shopping_cart),
            backgroundColor: Colors.black),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}
