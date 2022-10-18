import 'dart:io';

import 'package:amazon_clone/src/services/product_service.dart';
import 'package:amazon_clone/src/ui/helpers/constants.dart';
import 'package:amazon_clone/src/ui/helpers/utils.dart';
import 'package:amazon_clone/src/ui/widgets/custom_button.dart';
import 'package:amazon_clone/src/ui/widgets/custom_text_form_field.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class CreateProductView extends StatefulWidget {
  const CreateProductView({super.key});

  static const String name = 'create-product';

  @override
  State<CreateProductView> createState() => _CreateProductViewState();
}

class _CreateProductViewState extends State<CreateProductView> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  final ProductService _productService = ProductService();

  String category = 'Mobiles';
  List<File> images = <File>[];
  final GlobalKey<FormState> _productFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }

  List<String> categories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion'
  ];

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

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
          title: const Text(
            'Add Product',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _productFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                const SizedBox(height: 20.0),
                images.isNotEmpty
                    ? CarouselSlider(
                        items: images.map(
                          (i) {
                            return Builder(
                              builder: (BuildContext context) => Image.file(
                                i,
                                fit: BoxFit.cover,
                                height: 200.0,
                              ),
                            );
                          },
                        ).toList(),
                        options: CarouselOptions(
                          viewportFraction: 1.0,
                          height: 200.0,
                        ),
                      )
                    : GestureDetector(
                        onTap: selectImages,
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(10.0),
                          dashPattern: const <double>[10.0, 4.0],
                          strokeCap: StrokeCap.round,
                          child: Container(
                            width: double.infinity,
                            height: 150.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.folder_open,
                                  size: 40.0,
                                ),
                                const SizedBox(height: 15.0),
                                Text(
                                  'Select Product Images',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                const SizedBox(height: 30.0),
                CustomTextFormField(
                  controller: productNameController,
                  hintText: 'Product Name',
                  obscureText: false,
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 10.0),
                CustomTextFormField(
                  controller: descriptionController,
                  hintText: 'Description',
                  maxLines: 7,
                  obscureText: false,
                  keyboardType: TextInputType.multiline,
                ),
                const SizedBox(height: 10.0),
                CustomTextFormField(
                  controller: priceController,
                  hintText: 'Price',
                  obscureText: false,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10.0),
                CustomTextFormField(
                  controller: quantityController,
                  hintText: 'Quantity',
                  obscureText: false,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10.0),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    value: category,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items:
                        categories.map<DropdownMenuItem<String>>((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        category = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 10.0),
                CustomButton(
                  text: 'Sell',
                  onTap: () {
                    if (_productFormKey.currentState!.validate() &&
                        images.isNotEmpty) {
                      _productService.store(
                        context: context,
                        name: productNameController.text,
                        description: descriptionController.text,
                        price: double.parse(priceController.text),
                        quantity: double.parse(quantityController.text),
                        category: category,
                        images: images,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
