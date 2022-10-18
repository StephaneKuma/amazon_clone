import 'package:amazon_clone/src/providers/user_provider.dart';
import 'package:amazon_clone/src/ui/helpers/constants.dart';
import 'package:amazon_clone/src/ui/helpers/utils.dart';
import 'package:amazon_clone/src/ui/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressView extends StatefulWidget {
  const AddressView({
    Key? key,
    required this.totalAmount,
  }) : super(key: key);

  static const String name = 'address';

  final String totalAmount;

  @override
  State<AddressView> createState() => _AddressViewState();
}

class _AddressViewState extends State<AddressView> {
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();

  String addressToBeUsed = "";
  // List<PaymentItem> paymentItems = [];
  // final AddressServices addressServices = AddressServices();

  @override
  void initState() {
    super.initState();
    // paymentItems.add(
    //   PaymentItem(
    //     amount: widget.totalAmount,
    //     label: 'Total Amount',
    //     status: PaymentItemStatus.final_price,
    //   ),
    // );
  }

  @override
  void dispose() {
    super.dispose();
    flatBuildingController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
  }

  // void onApplePayResult(res) {
  //   if (Provider.of<UserProvider>(context, listen: false)
  //       .user
  //       .address
  //       .isEmpty) {
  //     addressServices.saveUserAddress(
  //         context: context, address: addressToBeUsed);
  //   }
  //   addressServices.placeOrder(
  //     context: context,
  //     address: addressToBeUsed,
  //     totalSum: double.parse(widget.totalAmount),
  //   );
  // }

  // void onGooglePayResult(res) {
  //   if (Provider.of<UserProvider>(context, listen: false)
  //       .user
  //       .address
  //       .isEmpty) {
  //     addressServices.saveUserAddress(
  //         context: context, address: addressToBeUsed);
  //   }
  //   addressServices.placeOrder(
  //     context: context,
  //     address: addressToBeUsed,
  //     totalSum: double.parse(widget.totalAmount),
  //   );
  // }

  void payPressed(String addressFromProvider) {
    addressToBeUsed = "";

    bool isForm = flatBuildingController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty ||
        cityController.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            '${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${pincodeController.text}';
      } else {
        throw Exception('Please enter all the values!');
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnackBar(context: context, text:'ERROR');
    }
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: kAppBarGradient,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: const TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                      'OR',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              Form(
                key: _addressFormKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      controller: flatBuildingController,
                      hintText: 'Flat, House no, Building',
                      obscureText: false,
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 10),
                    CustomTextFormField(
                      controller: areaController,
                      hintText: 'Area, Street',
                      obscureText: false,
                      keyboardType: TextInputType.streetAddress,
                    ),
                    const SizedBox(height: 10),
                    CustomTextFormField(
                      controller: pincodeController,
                      hintText: 'Pincode',
                      obscureText: false,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 10),
                    CustomTextFormField(
                      controller: cityController,
                      hintText: 'Town/City',
                      obscureText: false,
                      keyboardType: TextInputType.streetAddress,
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              // ApplePayButton(
              //   width: double.infinity,
              //   style: ApplePayButtonStyle.whiteOutline,
              //   type: ApplePayButtonType.buy,
              //   paymentConfigurationAsset: 'applepay.json',
              //   onPaymentResult: onApplePayResult,
              //   paymentItems: paymentItems,
              //   margin: const EdgeInsets.only(top: 15),
              //   height: 50,
              //   onPressed: () => payPressed(address),
              // ),
              // const SizedBox(height: 10),
              // GooglePayButton(
              //   onPressed: () => payPressed(address),
              //   paymentConfigurationAsset: 'gpay.json',
              //   onPaymentResult: onGooglePayResult,
              //   paymentItems: paymentItems,
              //   height: 50,
              //   style: GooglePayButtonStyle.black,
              //   type: GooglePayButtonType.buy,
              //   margin: const EdgeInsets.only(top: 15),
              //   loadingIndicator: const Center(
              //     child: CircularProgressIndicator(),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
