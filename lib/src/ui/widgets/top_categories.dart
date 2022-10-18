import 'package:amazon_clone/src/ui/helpers/constants.dart';
import 'package:amazon_clone/src/ui/views/category_products_view.dart';
import 'package:flutter/material.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({Key? key}) : super(key: key);

  void navigateToCategoryPage({
    required BuildContext context,
    required String category,
  }) {
    Navigator.pushNamed(
      context,
      CategoryProductsView.name,
      arguments: category,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      child: ListView.builder(
        itemCount: kCategoryImages.length,
        scrollDirection: Axis.horizontal,
        itemExtent: 75.0,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => navigateToCategoryPage(
            context: context,
            category: kCategoryImages[index]['title']!,
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: Image.asset(
                    kCategoryImages[index]['image']!,
                    fit: BoxFit.cover,
                    height: 40.0,
                    width: 40.0,
                  ),
                ),
              ),
              Text(
                kCategoryImages[index]['title']!,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
