import 'package:amazon_clone/src/ui/helpers/constants.dart';
import 'package:amazon_clone/src/ui/views/edit_profile.dart';
import 'package:amazon_clone/src/ui/widgets/custom_button.dart';
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
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Profil",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            const Greetings(),
            const SizedBox(height: 15),
            _ProfileTile(
              icon: Icons.person_outline,
              title: 'Mon Profil',
              onTap: () {
                Navigator.pushNamed(context, EditProfileView.name);
              },
            ),
            _ProfileTile(
              icon: Icons.shopping_bag_outlined,
              title: 'Mes commandes',
              onTap: () {},
            ),
            _ProfileTile(
              icon: Icons.location_on_outlined,
              title: 'Mes adresses',
              onTap: () {},
            ),
            _ProfileTile(
              icon: Icons.help_outline,
              title: "Centre d'aide",
              onTap: showDeconnexionBottomSheet,
            ),
            _ProfileTile(
              icon: Icons.logout_outlined,
              title: 'Se deconnecter',
              onTap: showDeconnexionBottomSheet,
            ),
          ],
        ),
      ),
    );
  }

  showDeconnexionBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return const DeconnexionBottomSheet();
      },
    );
  }
}

class DeconnexionBottomSheet extends StatelessWidget {
  const DeconnexionBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.3;

    return Container(
      padding: const EdgeInsets.all(20),
      height: height,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          const Text(
            "Se deconnecter",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Etes-vous sur de vouloir vous deconnecter ?",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kUnselectedNavBarColor,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  text: "Annuler",
                  secondary: true,
                  onTap: () => Navigator.pop(context),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: CustomButton(
                  color: Colors.white,
                  text: "Se deconnecter",
                  onTap: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  const _ProfileTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
      ),
    );
  }
}
