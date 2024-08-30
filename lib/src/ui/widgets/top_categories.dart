import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../injection_container.dart';
import '../../models/category.dart';
import '../../services/category_service.dart';
import '../helpers/constants.dart';
import '../views/category_products_view.dart';

class TopCategories extends StatefulWidget {
  const TopCategories({Key? key}) : super(key: key);

  @override
  State<TopCategories> createState() => _TopCategoriesState();
}

class _TopCategoriesState extends State<TopCategories> {
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

  late List<Category> categories;

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchCategoriesData();
    //
  }

  void _fetchCategoriesData() async {
    //
    try {
      setState(() {
        isLoading = true;
      });
      categories = await locator<CategoryService>().listOfCategories();
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e);
    } finally {
      setState(() {
        isLoading = false;
      });
    }

    //
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? SizedBox(
            height: 130,
            width: double.infinity,
            child: Center(
              child: SizedBox(
                width: 25,
                height: 25,
                child: CircularProgressIndicator(
                  color: kSecondaryColor,
                  backgroundColor: (kPrimaryColor).withOpacity(.3),
                  strokeWidth: 2,
                ),
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: SizedBox(
                height: 130.0,
                child: ListView.builder(
                  itemCount: kCategoryImages.length,
                  scrollDirection: Axis.horizontal,
                  itemExtent: 100.0,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => navigateToCategoryPage(
                      context: context,
                      category: categories[index].name,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: CachedNetworkImage(
                              imageUrl: categories[index].image,
                              fit: BoxFit.cover,
                              height: 80.0,
                              width: 80.0,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          categories[index].name,
                          maxLines: 1,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
