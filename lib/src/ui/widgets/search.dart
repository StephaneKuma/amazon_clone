import 'package:flutter/material.dart';

import '../views/search_view.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    void navigateToSearchScreen(String query) {
      Navigator.pushNamed(
        context,
        SearchView.name,
        arguments: query,
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Container(
            height: 42.0,
            margin: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Material(
              borderRadius: BorderRadius.circular(0.0),
              // elevation: 1.0,
              child: TextFormField(
                // onFieldSubmitted: navigateToSearchScreen,
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
                  hintText: 'Rechercher sur Afro Stand',
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.0,
                  ),
                ),
              ),
            ),
          ),
        ),
        // Container(
        //   color: Colors.transparent,
        //   height: 42.0,
        //   margin: const EdgeInsets.symmetric(horizontal: 10.0),
        //   child: const Icon(
        //     Icons.mic_outlined,
        //     color: Colors.black,
        //     size: 25.0,
        //   ),
        // ),
      ],
    );
  }
}
