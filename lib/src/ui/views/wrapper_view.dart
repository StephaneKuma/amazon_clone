import 'package:amazon_clone/src/ui/helpers/constants.dart';
import 'package:amazon_clone/src/ui/views/account_view.dart';
import 'package:amazon_clone/src/ui/views/home_view.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class WrapperView extends StatefulWidget {
  const WrapperView({super.key});

  static const String name = 'wrapper';

  @override
  State<WrapperView> createState() => _WrapperViewState();
}

class _WrapperViewState extends State<WrapperView> {
  int _view = 0;
  final double _bottomBarWidth = 42.0;
  final double _bottomBarBorderWidth = 5.0;

  final List<Widget> _views = const <Widget>[
    HomeView(),
    AccountView(),
    Center(
      child: Text('Cart View'),
    ),
  ];

  void changeView(int index) {
    setState(() {
      _view = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _views[_view],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _view,
        selectedItemColor: kSelectedNavBarColor,
        unselectedItemColor: kUnselectedNavBarColor,
        backgroundColor: kBackgroundColor,
        iconSize: 28.0,
        onTap: changeView,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Container(
              width: _bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _view == 0 ? kSelectedNavBarColor : kBackgroundColor,
                    width: _bottomBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(Icons.home_outlined),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: _bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _view == 1 ? kSelectedNavBarColor : kBackgroundColor,
                    width: _bottomBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(Icons.person_outline_outlined),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: _bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _view == 2 ? kSelectedNavBarColor : kBackgroundColor,
                    width: _bottomBarBorderWidth,
                  ),
                ),
              ),
              child: Badge(
                elevation: 0,
                badgeContent: const Text('0'),
                badgeColor: kSecondaryColor,
                child: const Icon(Icons.shopping_cart_outlined),
              ),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
