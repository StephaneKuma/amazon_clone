import 'package:amazon_clone/src/providers/user_provider.dart';
import 'package:amazon_clone/src/services/product_service.dart';
import 'package:amazon_clone/src/ui/helpers/constants.dart';
import 'package:amazon_clone/src/ui/views/search_view.dart';
import 'package:amazon_clone/src/ui/widgets/custom_button.dart';
import 'package:amazon_clone/src/ui/widgets/stars.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:amazon_clone/src/models/product.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class ProductDetailView extends StatefulWidget {
  const ProductDetailView({
    Key? key,
    required this.product,
  }) : super(key: key);

  static const String name = 'show-product';

  final Product product;

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  final ProductService _productService = ProductService();

  double _avgRating = 0;
  double _userRating = 0;

  @override
  void initState() {
    super.initState();
    double totalRating = 0;
    for (int index = 0; index < widget.product.ratings!.length; index++) {
      totalRating += widget.product.ratings![index].value;
      if (widget.product.ratings![index].userId ==
          Provider.of<UserProvider>(context, listen: false).user.id) {
        _userRating = widget.product.ratings![index].value;
      }
    }

    if (totalRating != 0) {
      _avgRating = totalRating / widget.product.ratings!.length;
    }
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(
      context,
      SearchView.name,
      arguments: query,
    );
  }

  void addToCart() {
    _productService.addToCart(
      context: context,
      product: widget.product,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: kAppBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(7.0),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(
                              left: 6.0,
                            ),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23.0,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10.0),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7.0),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7.0),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black38,
                            width: 1.0,
                          ),
                        ),
                        hintText: 'Search Amazon.in',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                child: const Icon(Icons.mic, color: Colors.black, size: 25.0),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.product.id!,
                  ),
                  Stars(
                    rating: _avgRating,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 10.0,
              ),
              child: Text(
                widget.product.name,
                style: const TextStyle(
                  fontSize: 15.0,
                ),
              ),
            ),
            CarouselSlider(
              items: widget.product.images.map(
                (String image) {
                  return Builder(
                    builder: (BuildContext context) => Image.network(
                      image,
                      fit: BoxFit.contain,
                      height: 200.0,
                    ),
                  );
                },
              ).toList(),
              options: CarouselOptions(
                viewportFraction: 1.0,
                height: 300.0,
              ),
            ),
            Container(
              color: Colors.black12,
              height: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                text: TextSpan(
                  text: 'Deal Price: ',
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: '\$${widget.product.price}',
                      style: const TextStyle(
                        fontSize: 22.0,
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.product.description),
            ),
            Container(
              color: Colors.black12,
              height: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomButton(
                text: 'Buy Now',
                onTap: () {},
              ),
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomButton(
                text: 'Add to Cart',
                onTap: addToCart,
                color: const Color.fromRGBO(254, 216, 19, 1),
              ),
            ),
            const SizedBox(height: 10.0),
            Container(
              color: Colors.black12,
              height: 5.0,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Rate The Product',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            RatingBar.builder(
              initialRating: _userRating,
              minRating: 1.0,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: kSecondaryColor,
              ),
              onRatingUpdate: (rating) {
                _productService.rate(
                  context: context,
                  product: widget.product,
                  rating: rating,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
