import 'package:amazon_clone/src/ui/helpers/constants.dart';
import 'package:amazon_clone/src/ui/widgets/circle_container.dart';
import 'package:amazon_clone/src/ui/widgets/custom_button.dart';
import 'package:amazon_clone/src/ui/widgets/order_tile.dart';
import 'package:flutter/material.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Panier',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: const [
          CircleContainer(
            color: kSecondaryColor,
            size: 30,
            child: Text(
              "3",
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 20,
          top: 20,
          bottom: 10,
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 10);
                },
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return const CartItemTile();
                },
              ),
            ),
            const TotalPrice(),
            const SizedBox(height: 5),
            CustomButton(
              color: Colors.white,
              btnColor: kPrimaryColor,
              text: "Continuer",
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class TotalPrice extends StatelessWidget {
  const TotalPrice({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
        top: 15,
        bottom: 10,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      child: const Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Prix de livraison",
                style: TextStyle(),
              ),
              Text(
                "500 FCFA",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          Divider(
            color: Colors.black38,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Prix total",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              Row(
                children: [
                  Text(
                    "10 000 FCFA",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

class CartItemTile extends StatelessWidget {
  const CartItemTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 20,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              "assets/images/cat_accessoire.png",
              width: 80,
              height: 80,
            ),
          ),
          const SizedBox(width: 15),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sac en pagne",
                  maxLines: 1,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      overflow: TextOverflow.ellipsis),
                ),
                Text(
                  "Sac en pagne très propre et pratique pour femme",
                  maxLines: 1,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      overflow: TextOverflow.ellipsis),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PriceChip(),
                    Row(
                      children: [
                        CircleContainer(
                          size: 24,
                          color: Colors.white,
                          child: Icon(
                            Icons.add,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: 5),
                        CircleContainer(
                          color: kSecondaryColor,
                          size: 40,
                          child: Text("1"),
                        ),
                        SizedBox(width: 5),
                        CircleContainer(
                          size: 24,
                          color: Colors.white,
                          child: Icon(
                            Icons.remove,
                            size: 20,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CartItemTileProduct extends StatelessWidget {
  const CartItemTileProduct({
    super.key,
  });

  static List<CartItemTileProduct> list() {
    return List.generate(3, (index) => const CartItemTileProduct());
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      widthFactor: 0.5,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          "assets/images/cat_accessoire.png",
          height: 30,
          width: 30,
        ),
      ),
    );
  }
}
