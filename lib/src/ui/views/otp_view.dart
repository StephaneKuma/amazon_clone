import 'dart:async';

import 'package:amazon_clone/src/ui/widgets/custom_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../helpers/constants.dart';

enum ResendingCodeStatus {
  initial,
  waiting,
  success,
  failed,
}

class OtpView extends StatefulWidget {
  const OtpView({super.key});

  static const String name = 'otp';

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  late Timer _timer;
  int _seconds = 30;
  bool _isRunning = false;
  late String _phoneNumber = "";
  bool isLoading = false;
  bool bad = false;
  String? code;
  ResendingCodeStatus resendingCodeStatus = ResendingCodeStatus.initial;

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
      // await locator<AuthenticationService>().authenticate(
      //   request: AuthenticationRequest(
      //     phone: _phoneNumber,
      //   ),
      // );
      setState(() {
        resendingCodeStatus = ResendingCodeStatus.success;
      });
    } catch (e) {
      setState(() {
        resendingCodeStatus = ResendingCodeStatus.failed;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Une erreur c' est produite ressayer"),
          backgroundColor: Colors.red,
        ));
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
      body: OverLayLaodingWidget(
        isLoading: isLoading,
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
                      text: "Veuillez entrer le code de vérification envoyé au",
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                      children: [
                        TextSpan(
                          text: _phoneNumber,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              _goToAuthentification();
                            },
                          style: const TextStyle(
                            fontSize: 15,
                            color: kPrimaryColor,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Pinput(
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
                    isLoading: isLoading,
                    text: "Envoyer",
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                    onTap: () {},
                    // fn: () async {
                    //   {
                    //     if (code != null) {
                    //       setState(() {
                    //         isLoading = true;
                    //       });

                    //       final request = OtpLoginRequest(
                    //         userId: widget.authUser.user!.id!,
                    //         otp: code!,
                    //       );
                    //       final response =
                    //           await locator<AuthenticationService>()
                    //               .otpLogin(request: request);
                    //       if (response != null && response.statusCode == 200) {
                    //         var user = await locator<UserService>()
                    //             .read(userId: response.data!.user!.id!);

                    //         if (user == null) {
                    //           if (mounted) {
                    //             context.router.push(
                    //               AuthenticationRoute(),
                    //             );
                    //           }
                    //         } else if (user.firstName == null ||
                    //             user.lastName == null) {
                    //           if (mounted) {
                    //             context.router.replace(
                    //                 AccountSetupRoute(userId: user.id!));
                    //           }
                    //         } else {
                    //           if (mounted) {
                    //             Future.delayed(const Duration(seconds: 3)).then(
                    //               (value) => context.router.replace(
                    //                 WrapperRoute(user: user),
                    //               ),
                    //             );
                    //           }
                    //         }
                    //       } else {
                    //         setState(() {
                    //           bad = true;
                    //         });
                    //       }
                    //     }

                    //     setState(() {
                    //       isLoading = false;
                    //     });
                    //   }
                    // },
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
                                  text: "Vous recevrez un code par SMS dans",
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
                                onPressed: () {
                                  _resendOtp();
                                },
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
                ],
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
