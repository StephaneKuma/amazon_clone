import 'package:amazon_clone/injection_container.dart';
import 'package:amazon_clone/src/services/http_service.dart';
import 'package:amazon_clone/src/ui/helpers/constants.dart';
import 'package:amazon_clone/src/ui/views/search_view.dart';
import 'package:amazon_clone/src/ui/widgets/address_box.dart';
import 'package:amazon_clone/src/ui/widgets/carouserl_images.dart';
import 'package:amazon_clone/src/ui/widgets/deal_of_the_day.dart';
import 'package:amazon_clone/src/ui/widgets/top_categories.dart';
import 'package:flutter/material.dart';

import '../widgets/search.dart';

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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // appBar:
      // PreferredSize(
      //   preferredSize: const Size.fromHeight(60.0),
      //   child: AppBar(
      //     leading: const SizedBox(),
      //     flexibleSpace: Container(
      //       decoration: const BoxDecoration(
      //         gradient: kAppBarGradient,
      //       ),
      //     ),
      //     title:
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       children: <Widget>[
      //         Expanded(
      //           child: Container(
      //             height: 42.0,
      //             // margin: const EdgeInsets.only(left: 15.0),
      //             child: Material(
      //               borderRadius: BorderRadius.circular(0.0),
      //               // elevation: 1.0,
      //               child: TextFormField(
      //                 onFieldSubmitted: navigateToSearchScreen,
      //                 decoration: InputDecoration(
      //                   prefixIcon: InkWell(
      //                     onTap: () {
      //                       // TODO: create on tap function
      //                     },
      //                     child: const Padding(
      //                       padding: EdgeInsets.only(left: 6.0),
      //                       child: Icon(
      //                         Icons.search_outlined,
      //                         color: Colors.black,
      //                         size: 23.0,
      //                       ),
      //                     ),
      //                   ),
      //                   filled: true,
      //                   fillColor: Colors.white,
      //                   contentPadding: const EdgeInsets.only(top: 10.0),
      //                   border: const OutlineInputBorder(
      //                     borderRadius: BorderRadius.all(
      //                       Radius.circular(7.0),
      //                     ),
      //                     borderSide: BorderSide.none,
      //                   ),
      //                   enabledBorder: const OutlineInputBorder(
      //                     borderRadius: BorderRadius.all(
      //                       Radius.circular(7.0),
      //                     ),
      //                     borderSide: BorderSide(
      //                       color: Colors.black38,
      //                       width: 1.0,
      //                     ),
      //                   ),
      //                   hintText: 'Rechercher sur Afro Stand',
      //                   hintStyle: const TextStyle(
      //                     fontWeight: FontWeight.w500,
      //                     fontSize: 14.0,
      //                   ),
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ),
      //         // Container(
      //         //   color: Colors.transparent,
      //         //   height: 42.0,
      //         //   margin: const EdgeInsets.symmetric(horizontal: 10.0),
      //         //   child: const Icon(
      //         //     Icons.mic_outlined,
      //         //     color: Colors.black,
      //         //     size: 25.0,
      //         //   ),
      //         // ),
      //       ],
      //     ),
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 70,
            ),
            Search(),
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
