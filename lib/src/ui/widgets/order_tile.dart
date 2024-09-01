import 'package:amazon_clone/src/ui/helpers/constants.dart';
import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  const OrderTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kPrimaryColor.withOpacity(.45),
        border: Border.all(color: kPrimaryColor.withOpacity(.5), width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 20,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 15),
          ...OrderTileProduct.list(),
          const SizedBox(width: 25),
          Expanded(
            child: Column(
              children: [
                for (int i = 0; i < 3; i++)
                  Text(
                    "Article -- -- -- -- -- -- -- --- -- -- ${i + 1}${i != 2 ? "," : ""}",
                    maxLines: 1,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        overflow: TextOverflow.ellipsis),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Column(
            children: [
              Text(
                "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                style: const TextStyle(
                  color: Colors.white60,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              const PriceChip()
            ],
          )
        ],
      ),
    );
  }
}

class PriceChip extends StatelessWidget {
  const PriceChip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: const Text(
        "10 000 F",
        style: TextStyle(
          color: Colors.black,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class OrderTileProduct extends StatelessWidget {
  const OrderTileProduct({
    super.key,
  });

  static List<OrderTileProduct> list() {
    return List.generate(3, (index) => const OrderTileProduct());
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
          height: 40,
          width: 40,
        ),
      ),
    );
  }
}
