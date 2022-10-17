import 'package:amazon_clone/src/ui/helpers/constants.dart';
import 'package:amazon_clone/src/ui/views/search_view.dart';
import 'package:amazon_clone/src/ui/widgets/address_box.dart';
import 'package:amazon_clone/src/ui/widgets/carouserl_images.dart';
import 'package:amazon_clone/src/ui/widgets/deal_of_the_day.dart';
import 'package:amazon_clone/src/ui/widgets/top_categories.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  static const String name = 'home';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(
      context,
      SearchView.name,
      arguments: query,
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
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 42.0,
                  margin: const EdgeInsets.only(left: 15.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(7.0),
                    elevation: 1.0,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {
                            // TODO: create on tap function
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(left: 6.0),
                            child: Icon(
                              Icons.search_outlined,
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
                        hintText: 'Sreach Amazon.in',
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
                height: 42.0,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                child: const Icon(
                  Icons.mic_outlined,
                  color: Colors.black,
                  size: 25.0,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const <Widget>[
            AddressBox(),
            SizedBox(height: 10.0),
            TopCategories(),
            SizedBox(height: 10),
            CarouselImages(),
            DealOfTheDay(),
          ],
        ),
      ),
    );
  }
}
