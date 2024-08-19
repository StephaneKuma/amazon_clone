import 'package:amazon_clone/src/ui/views/otp_view.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../widgets/custom_button.dart';

class PhoneNumberView extends StatefulWidget {
  const PhoneNumberView({super.key, this.phone});

  static const String name = 'phoneNumber';
  final String? phone;

  @override
  State<PhoneNumberView> createState() => _PhoneNumberViewState();
}

class _PhoneNumberViewState extends State<PhoneNumberView> {
  //
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _phoneNumber = "";
  bool isLoading = false;
  late final phoneController = TextEditingController();

  @override
  void initState() {
    final phone = widget.phone;
    if (phone != null) {
      final phoneWithoutCountryCode = widget.phone!.substring(4);
      phoneController.text = phoneWithoutCountryCode;
      _phoneNumber = phone;
    }
    //
    super.initState();
  }

  @override
  void dispose() {
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Expanded(
                  child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Center(
                    //   child: SizedBox(
                    //     width: 200,
                    //     child: Hero(
                    //       tag: 'Logo',
                    //       child: Image.asset('assets/images/logo.png'),
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 60,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          IntlPhoneField(
                            invalidNumberMessage: "Invalid phone number",
                            autofocus: widget.phone != null,
                            controller: phoneController,
                            decoration: const InputDecoration(
                                counter: Offstage(),
                                hintText: "Téléphone",
                                contentPadding: EdgeInsets.only(top: 12)),
                            initialCountryCode: 'TG',
                            onCountryChanged: (value) {
                              // final selectedCountryCode =
                              //     AppStrings.countries[value.dialCode]; for url;
                              // if (selectedCountryCode == null) {
                              //   Future.microtask(() {
                              //     AppUtils.showNotSupportedCountryDialog();
                              //   });
                              //   return;
                              // }

                              // A REVOIR
                              // final url = countries[value.dialCode]!;
                              // StorageManager.saveData(
                              //     defaulthiveBox, currentUrl, url);

                              // Endpoints.instance.setBaseUrl(url);
                            },
                            onChanged: (value) {
                              setState(
                                () => _phoneNumber = value.completeNumber,
                              );
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          CustomButton(
                            btnColor: const Color(0xFFfc9f12),
                            text: 'Valider',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 17),
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                OtpView.name,
                              );
                              // if (_signinFormKey.currentState!.validate()) {
                              //   _authenticationService.signin(
                              //     context: context,
                              //     email: _emailController.text,
                              //     password: _passwordController.text,
                              //   );
                              // }
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    )
                  ],
                ),
              )),
              // Text('data 2'),
            ],
          ),
        ),
      ),
    );
  }
}
