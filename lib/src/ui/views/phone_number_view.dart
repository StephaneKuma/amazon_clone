import 'package:amazon_clone/injection_container.dart';
import 'package:amazon_clone/src/services/authentication_service.dart';
import 'package:amazon_clone/src/ui/helpers/utils.dart';
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
  final _formKey = GlobalKey<FormState>();
  String _phoneNumber = "";
  bool isLoading = false;
  final phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final phone = widget.phone;
    if (phone != null) {
      final phoneWithoutCountryCode = widget.phone!.substring(4);
      phoneController.text = phoneWithoutCountryCode;
      _phoneNumber = phone;
    }
    //
  }

  void _authenticate() async {
    if (_formKey.currentState!.validate() && _phoneNumber.isNotEmpty) {
      try {
        setState(() {
          isLoading = true;
        });
        final user = await locator<AuthenticationService>()
            .authenticate(phone: _phoneNumber);
        if (mounted) {
          Navigator.of(context).pushNamed(OtpView.name, arguments: user);
        }
      } catch (e) {
        if (mounted) {
          showSnackBar(
            context: context,
            text: e.toString(),
            type: SnackBarType.error,
          );
        }
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
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
                    Center(
                      child: SizedBox(
                        width: 200,
                        child: Hero(
                          tag: 'Logo',
                          child: Image.asset(
                            'assets/images/logo.png',
                            height: 80,
                          ),
                        ),
                      ),
                    ),
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
                            isLoading: isLoading,
                            btnColor: const Color(0xFFfc9f12),
                            text: 'Valider',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 17),
                            onTap: _authenticate,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 25,
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
