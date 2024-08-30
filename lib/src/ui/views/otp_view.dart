import 'dart:async';

import 'package:amazon_clone/injection_container.dart';
import 'package:amazon_clone/src/models/user/user.dart';
import 'package:amazon_clone/src/providers/app_provider.dart';
import 'package:amazon_clone/src/services/authentication_service.dart';
import 'package:amazon_clone/src/ui/helpers/utils.dart';
import 'package:amazon_clone/src/ui/views/create_account.dart';
import 'package:amazon_clone/src/ui/views/wrapper_view.dart';
import 'package:amazon_clone/src/ui/widgets/custom_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../helpers/constants.dart';

enum ResendingCodeStatus {
  initial,
  waiting,
  success,
  failed,
}

class OtpView extends StatefulWidget {
  const OtpView({
    super.key,
    required this.user,
  });

  static const String name = 'otp';

  final User user;

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  late Timer _timer;
  int _seconds = 30;
  bool _isRunning = false;
  bool isLoading = false;
  bool bad = false;
  String code = '';
  ResendingCodeStatus resendingCodeStatus = ResendingCodeStatus.initial;

  final _formKey = GlobalKey<FormState>();
  final _pinController = TextEditingController();

  @override
  void initState() {
    super.initState();

    setPhoneNumber();
    _startTimer();
  }

  void setPhoneNumber() async {
    // String? phoneNumber = widget.authUser.user?.phone;

    // setState(() {
    //   _phoneNumber = phoneNumber ?? '';
    // });
  }

  void _startTimer() {
    if (_isRunning) {
      return;
    }
    setState(() {
      _isRunning = true;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_seconds > 0) {
        setState(() {
          _seconds--;
        });
      } else {
        setState(() => _isRunning = false);
        _seconds = 30;
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();

    super.dispose();
  }

  Future<void> _resendOtp() async {
    try {
      _startTimer();
      setState(() {
        resendingCodeStatus = ResendingCodeStatus.waiting;
      });
      await locator<AuthenticationService>().authenticate(
        phone: widget.user.phone!,
      );

      setState(() {
        resendingCodeStatus = ResendingCodeStatus.success;
      });
    } catch (e) {
      setState(() {
        resendingCodeStatus = ResendingCodeStatus.failed;
      });
      if (mounted) {
        showSnackBar(
          context: context,
          text: e.toString(),
          type: SnackBarType.error,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResendingCodeStatus.waiting == resendingCodeStatus
          ? null
          : AppBar(
              leading: _BackButton(
                onPressed: _goToAuthentification,
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
      body: Form(
        key: _formKey,
        child: OverLayLaodingWidget(
          isLoading: resendingCodeStatus == ResendingCodeStatus.waiting,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Center(
              child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      "Vérification",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text.rich(
                      TextSpan(
                        text:
                            "Veuillez entrer le code de vérification envoyé au",
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                        children: [
                          TextSpan(
                            text: " ${widget.user.phone}",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // _goToAuthentification();
                              },
                            style: const TextStyle(
                              fontSize: 15,
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Pinput(
                        controller: _pinController,
                        defaultPinTheme: PinTheme(
                            height: 55,
                            textStyle: const TextStyle(
                                color: Colors.black, fontSize: 16),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(10),
                              border: bad
                                  ? Border.all(width: 1, color: Colors.red)
                                  : Border.all(
                                      width: 0, color: Colors.transparent),
                            )),
                        focusedPinTheme: PinTheme(
                            height: 55,
                            textStyle: const TextStyle(
                                color: Colors.white, fontSize: 18),
                            decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(10),
                              //border: Border.all(width: 1,color: Colors.grey)
                            )),
                        length: 6,
                        validator: (value) {
                          if (value!.length < 6) {
                            return "Code invalide";
                          }
                          return null;
                        },
                        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                        onChanged: (_) {
                          setState(() {
                            bad = false;
                          });
                        },
                        onCompleted: (value) {
                          setState(() {
                            code = value;
                          });
                        },
                        // onSubmitted: (String code) async ,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    CustomButton(
                      btnColor: kSecondaryColor,
                      color: Colors.white,
                      isLoading: isLoading,
                      text: "Envoyer",
                      style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                      onTap: _veryfication,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: _isRunning
                          ? RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "Ressayer dans ",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
                                  TextSpan(
                                    text: " $_seconds secondes",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: kPrimaryColor.withOpacity(.6),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Column(
                              children: <Widget>[
                                const Text(
                                  "Vous n'avez pas reçu de code ?",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                  ),
                                ),
                                TextButton(
                                  onPressed: _resendOtp,
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                    ),
                                    child: Text(
                                      "Renvoyer",
                                      style: TextStyle(
                                        color: kPrimaryColor,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _goToAuthentification() {
    Navigator.pop(
      context,
      OtpView.name,
    );
    // context.router.push(
    //   AuthenticationRoute(
    //     phone: widget.authUser.user?.phone ?? '',
    //   ),
    // );
  }

  void _veryfication() async {
    if (_formKey.currentState!.validate()) {
      try {
        setState(() {
          isLoading = true;
        });
        print(isLoading);
        final user = await locator<AuthenticationService>().otpLogin(
          userId: widget.user.id!,
          otp: code,
        );
        if (user.firstName == null && user.lastName == null) {
          Navigator.pushReplacementNamed(
            context,
            CreateAccountView.name,
            arguments: user,
          );
          return;
        }
        if (mounted) {
          context.read<AppProvider>().setUser(user);
          Navigator.pushNamedAndRemoveUntil(
            context,
            WrapperView.name,
            (route) => false,
          );
        }
      } catch (e) {
        print(e);

        setState(() {
          bad = true;
        });
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({
    required this.onPressed,
  });
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
    );
  }
}

class OverLayLaodingWidget extends StatelessWidget {
  const OverLayLaodingWidget(
      {super.key, required this.child, required this.isLoading});
  final Widget child;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: Colors.black.withOpacity(0.5),
            child: const Center(
              child: CircularProgressIndicator(
                color: kPrimaryColor,
              ),
            ),
          ),
      ],
    );
  }
}
