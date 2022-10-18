import 'package:amazon_clone/src/models/product.dart';
import 'package:amazon_clone/src/providers/user_provider.dart';
import 'package:amazon_clone/src/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartProduct extends StatefulWidget {
  final int index;
  const CartProduct({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  final ProductService _productService =
      ProductService();

  void increaseQuantity(Product product) {
    _productService.addToCart(
      context: context,
      product: product,
    );
  }

  void decreaseQuantity(Product product) {
    _productService.removeFromCart(
      context: context,
      product: product,
    );
  }

  @override
  Widget build(BuildContext context) {
    final productCart = context.watch<UserProvider>().user.cart[widget.index];
    final product = Product.fromMap(productCart['product']);
    final quantity = productCart['quantity'];

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: Row(
            children: [
              Image.network(
                product.images[0],
                fit: BoxFit.contain,
                height: 135.0,
                width: 135.0,
              ),
              Column(
                children: [
                  Container(
                    width: 235,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10.0, top: 5.0),
                    child: Text(
                      '\$${product.price}',
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 235.0,
                    padding: const EdgeInsets.only(left: 10.0),
                    child: const Text('Eligible for FREE Shipping'),
                  ),
                  Container(
                    width: 235.0,
                    padding: const EdgeInsets.only(left: 10.0, top: 5.0),
                    child: const Text(
                      'In Stock',
                      style: TextStyle(
                        color: Colors.teal,
                      ),
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.black12,
                ),
                child: Row(
                  children: <Widget>[
                    InkWell(
                      onTap: () => decreaseQuantity(product),
                      child: Container(
                        width: 35.0,
                        height: 32.0,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.remove,
                          size: 18.0,
                        ),
                      ),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12, width: 1.5),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: Container(
                        width: 35.0,
                        height: 32.0,
                        alignment: Alignment.center,
                        child: Text(
                          quantity.toString(),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => increaseQuantity(product),
                      child: Container(
                        width: 35.0,
                        height: 32.0,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.add,
                          size: 18.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
