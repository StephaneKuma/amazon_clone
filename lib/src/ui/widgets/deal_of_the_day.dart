import 'package:amazon_clone/src/models/product.dart';
import 'package:amazon_clone/src/services/product_service.dart';
import 'package:amazon_clone/src/ui/views/product_detail_view.dart';
import 'package:amazon_clone/src/ui/widgets/loader.dart';
import 'package:flutter/material.dart';

class DealOfTheDay extends StatefulWidget {
  const DealOfTheDay({Key? key}) : super(key: key);

  @override
  State<DealOfTheDay> createState() => _DealOfTheDayState();
}

class _DealOfTheDayState extends State<DealOfTheDay> {
  Product? product;

  final ProductService _productService = ProductService();

  @override
  void initState() {
    super.initState();
    // fetchDealOfTheDay();
  }

  void fetchDealOfTheDay() async {
    // product = await _productService.dealOfTheDay(context: context);
    setState(() {});
  }

  void navigateToDetailScreen() {
    Navigator.pushNamed(
      context,
      ProductDetailView.name,
      arguments: product,
    );
  }

  @override
  Widget build(BuildContext context) {
    // print(product);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
      ),
      child: GestureDetector(
        onTap: () {}, // navigateToDetailScreen,
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(left: 0, top: 15),
              child: const Text(
                'L\'offre spécial de ce jour',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            // Image.network(
            //   product!.images[0],
            //   height: 235,
            //   fit: BoxFit.fitHeight,
            // ),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.asset(
                      "assets/images/products/image_afrostand5.jpg",
                      height: 235,
                      fit: BoxFit.fitHeight),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 70,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black87.withOpacity(0.4),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                    child: const IntrinsicHeight(
                      child: Column(
                        children: [
                          Expanded(
                            child: Text(
                              'Modèle boubou femme africaine',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '25000 F CFA \n',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 20,
            ),
            // Container(
            //   alignment: Alignment.topLeft,
            //   padding: const EdgeInsets.only(left: 15, top: 5, right: 40),
            //   child: const Text(
            //     'Rivaan',
            //     maxLines: 2,
            //     overflow: TextOverflow.ellipsis,
            //   ),
            // ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.asset(
                      "assets/images/products/image_afrostand.jpg",
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.asset(
                      "assets/images/products/image_afrostand1.jpg",
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.asset(
                      "assets/images/products/image_afrostand3.jpg",
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.asset(
                      "assets/images/products/image_afrostand4.jpg",
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,
                    ),
                  ),
                ],
                // product!.images
                //     .map(
                //       (e) => Image.network(
                //         e,
                //         fit: BoxFit.fitWidth,
                //         width: 100,
                //         height: 100,
                //       ),
                //     )
                //     .toList(),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 15,
              ).copyWith(left: 15),
              alignment: Alignment.topLeft,
              child: Text(
                'Voir plus ',
                style: TextStyle(
                  color: Colors.cyan[800],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    // product!.id == null
    //   ? const Loader()
    //   : product!.name.isEmpty
    //       ? const SizedBox()
    //       : GestureDetector(
    //           onTap: navigateToDetailScreen,
    //           child: Column(
    //             children: [
    //               Container(
    //                 alignment: Alignment.topLeft,
    //                 padding: const EdgeInsets.only(left: 10, top: 15),
    //                 child: const Text(
    //                   'Deal of the day',
    //                   style: TextStyle(fontSize: 20),
    //                 ),
    //               ),
    //               Image.asset("assets/images/slide_1.jpg",
    //                   height: 235, fit: BoxFit.fitHeight),
    //               // Image.network(
    //               //   product!.images[0],
    //               //   height: 235,
    //               //   fit: BoxFit.fitHeight,
    //               // ),
    //               Container(
    //                 padding: const EdgeInsets.only(left: 15),
    //                 alignment: Alignment.topLeft,
    //                 child: const Text(
    //                   '\$100',
    //                   style: TextStyle(fontSize: 18),
    //                 ),
    //               ),
    //               Container(
    //                 alignment: Alignment.topLeft,
    //                 padding:
    //                     const EdgeInsets.only(left: 15, top: 5, right: 40),
    //                 child: const Text(
    //                   'Rivaan',
    //                   maxLines: 2,
    //                   overflow: TextOverflow.ellipsis,
    //                 ),
    //               ),
    //               SingleChildScrollView(
    //                 scrollDirection: Axis.horizontal,
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: product!.images
    //                       .map(
    //                         (e) => Image.network(
    //                           e,
    //                           fit: BoxFit.fitWidth,
    //                           width: 100,
    //                           height: 100,
    //                         ),
    //                       )
    //                       .toList(),
    //                 ),
    //               ),
    //               Container(
    //                 padding: const EdgeInsets.symmetric(
    //                   vertical: 15,
    //                 ).copyWith(left: 15),
    //                 alignment: Alignment.topLeft,
    //                 child: Text(
    //                   'See all deals',
    //                   style: TextStyle(
    //                     color: Colors.cyan[800],
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         );
  }
}
