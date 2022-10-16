import 'package:amazon_clone/src/ui/helpers/constants.dart';
import 'package:amazon_clone/src/ui/widgets/greetings.dart';
import 'package:amazon_clone/src/ui/widgets/orders.dart';
import 'package:amazon_clone/src/ui/widgets/top_buttons.dart';
import 'package:flutter/material.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: kAppBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/images/amazon_in.png',
                  width: 120.0,
                  height: 45.0,
                  color: Colors.black,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  children: const <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 15.0),
                      child: Icon(Icons.notifications_outlined),
                    ),
                    Icon(Icons.search_outlined),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: const <Widget>[
          Greetings(),
          SizedBox(height: 10.0),
          TopButtons(),
          SizedBox(height: 20.0),
          Orders(),
          SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
