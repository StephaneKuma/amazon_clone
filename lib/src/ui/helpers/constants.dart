import 'package:flutter/material.dart';

const String kUrl = "https://admin.afrostand.com";
// https://admin.afrostand.com/api/v1/categories // http://<ipaddress>:3000

// COLORS
const LinearGradient kAppBarGradient = LinearGradient(
  colors: [
    // Color.fromARGB(255, 29, 201, 192),
    // Color.fromARGB(255, 125, 221, 216),
    // Color(0xFF9D7A5F),
    // Color.fromRGBO(72, 39, 13, 1),
    // Color.fromRGBO(159, 135, 101, 1),

    kGreyBackgroundCOlor, kGreyBackgroundCOlor, kGreyBackgroundCOlor
  ],
  stops: [0.5, 1.0, 1.0],
);
const Color kPrimaryColor = Color(0xFF291403);
const Color kSecondaryColor = Color(0xFFfc9f12);
const Color kSecondaryColor2 = Color(0xFFD38B20);
const Color kBackgroundColor = Colors.white;
const Color kGreyBackgroundCOlor = Color(0xffebecee);
Color kSelectedNavBarColor = Colors.cyan[800]!;
const kUnselectedNavBarColor = Colors.grey;

// Shared Preferences
const String kToken = 'x-auth-token';

// STATIC IMAGES
const List<String> kCarouselImages = [
  'https://images-eu.ssl-images-amazon.com/images/G/31/img21/Wireless/WLA/TS/D37847648_Accessories_savingdays_Jan22_Cat_PC_1500.jpg',
  'https://images-eu.ssl-images-amazon.com/images/G/31/img2021/Vday/bwl/English.jpg',
  'https://images-eu.ssl-images-amazon.com/images/G/31/img22/Wireless/AdvantagePrime/BAU/14thJan/D37196025_IN_WL_AdvantageJustforPrime_Jan_Mob_ingress-banner_1242x450.jpg',
  'https://images-na.ssl-images-amazon.com/images/G/31/Symbol/2020/00NEW/1242_450Banners/PL31_copy._CB432483346_.jpg',
  'https://images-na.ssl-images-amazon.com/images/G/31/img21/shoes/September/SSW/pc-header._CB641971330_.jpg',
];

const List<Map<String, String>> kCategoryImages = <Map<String, String>>[
  {
    'title': 'Vêtements',
    'image': 'assets/images/cat_habit.png',
  },
  {
    'title': 'Bijoux',
    'image': 'assets/images/cat_bijou.png',
  },
  {
    'title': 'Décorations',
    'image': 'assets/images/cat_deco.png',
  },
  {
    'title': 'Accessoires',
    'image': 'assets/images/cat_accessoire.png',
  },
  // {
  //   'title': 'Fashion',
  //   'image': 'assets/images/fashion.jpeg',
  // },
];

const maleAvatar =
    "https://img.freepik.com/free-psd/3d-rendering-avatar_23-2150833546.jpg?w=826&t=st=1725017398~exp=1725017998~hmac=60bc4eacd8a1c5d343de3ef030f79e359f11bd5d346fa30198fd542f56625e88";

const femaleAvatar =
    "https://img.freepik.com/free-psd/3d-render-avatar-character_23-2150611698.jpg?w=826&t=st=1725017822~exp=1725018422~hmac=70ced823787c9203aee1d37ed0c5944844e2b5459bb34989106d907869e076fc";
