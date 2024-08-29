import 'package:amazon_clone/src/providers/user_provider.dart';
import 'package:amazon_clone/src/ui/helpers/constants.dart';
import 'package:amazon_clone/src/ui/views/account_view.dart';
import 'package:amazon_clone/src/ui/views/home_view.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    Center(
      child: Text('Le panier est Vide'),
    ),
    AccountView(),
  ];

  void changeView(int index) {
    setState(() {
      _view = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartLength = Provider.of<UserProvider>(context).user.cart.length;

    return Scaffold(
      body: _views[_view],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _view,
        selectedItemColor: kPrimaryColor,
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
                    color: _view == 0 ? kPrimaryColor : kBackgroundColor,
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
                    color: _view == 1 ? kPrimaryColor : kBackgroundColor,
                    width: _bottomBarBorderWidth,
                  ),
                ),
              ),
              child: badges.Badge(
                badgeContent: Text('$cartLength'),
                badgeStyle: const badges.BadgeStyle(
                  badgeColor: kSecondaryColor,
                  elevation: 0,
                ),
                child: const Icon(Icons.shopping_cart_outlined),
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: _bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _view == 2 ? kPrimaryColor : kBackgroundColor,
                    width: _bottomBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(Icons.person_outline_outlined),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
