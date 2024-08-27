import 'package:amazon_clone/src/providers/user_provider.dart';
import 'package:amazon_clone/src/ui/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressBox extends StatelessWidget {
  const AddressBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: 40,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            kSecondaryColor2,
            kSecondaryColor,
          ],
          stops: [0.5, 1.0],
        ),
      ),
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: <Widget>[
          const Icon(
            Icons.location_on_outlined,
            size: 20,
            color: Colors.white,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                'Livrer à ${user.name} - ${user.address}',
                style: const TextStyle(
                    fontWeight: FontWeight.w500, color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: 5,
              top: 2,
            ),
            child: Icon(
              Icons.arrow_drop_down_outlined,
              size: 18,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
