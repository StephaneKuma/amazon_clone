import 'package:amazon_clone/src/models/product.dart';
import 'package:amazon_clone/src/ui/widgets/stars.dart';
import 'package:flutter/material.dart';

class SearchedProduct extends StatelessWidget {
  final Product product;

  const SearchedProduct({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalRating = 0;

    for (int i = 0; i < product.ratings!.length; i++) {
      totalRating += product.ratings![i].value;
    }

    double avgRating = 0;

    if (totalRating != 0) {
      avgRating = totalRating / product.ratings!.length;
    }

    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: Row(
            children: <Widget>[
              Image.network(
                product.images[0],
                fit: BoxFit.contain,
                height: 135.0,
                width: 135.0,
              ),
              Column(
                children: <Widget>[
                  Container(
                    width: 235.0,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 235.0,
                    padding: const EdgeInsets.only(left: 10.0, top: 5.0),
                    child: Stars(
                      rating: avgRating,
                    ),
                  ),
                  Container(
                    width: 235.0,
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
                    width: 235,
                    padding: const EdgeInsets.only(left: 10.0),
                    child: const Text('Eligible for FREE Shipping'),
                  ),
                  Container(
                    width: 235,
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
      ],
    );
  }
}
