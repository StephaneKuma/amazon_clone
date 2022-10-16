import 'package:amazon_clone/src/enums/authentication.dart';
import 'package:amazon_clone/src/services/authentication_service.dart';
import 'package:amazon_clone/src/ui/helpers/constants.dart';
import 'package:amazon_clone/src/ui/widgets/custom_button.dart';
import 'package:amazon_clone/src/ui/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class AuthenticationView extends StatefulWidget {
  const AuthenticationView({super.key});

  static const String name = 'authenctication';

  @override
  State<AuthenticationView> createState() => _AuthenticationViewState();
}

class _AuthenticationViewState extends State<AuthenticationView> {
  Authentication _authentication = Authentication.signup;
  final GlobalKey<FormState> _signupFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _signinFormKey = GlobalKey<FormState>();

  final AuthenticationService _authenticationService = AuthenticationService();

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: '');
    _emailController = TextEditingController(text: '');
    _passwordController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGreyBackgroundCOlor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Welcome',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            ListTile(
              tileColor: _authentication == Authentication.signup
                  ? kBackgroundColor
                  : kGreyBackgroundCOlor,
              title: const Text(
                'Create Account',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Radio(
                value: Authentication.signup,
                groupValue: _authentication,
                onChanged: (Authentication? value) =>
                    setState(() => _authentication = value!),
              ),
            ),
            if (_authentication == Authentication.signup)
              Container(
                padding: const EdgeInsets.all(8.0),
                color: kBackgroundColor,
                child: Form(
                  key: _signupFormKey,
                  child: Column(
                    children: <Widget>[
                      CustomTextFormField(
                        controller: _nameController,
                        hintText: 'Name',
                        obscureText: false,
                        keyboardType: TextInputType.name,
                      ),
                      const SizedBox(height: 10.0),
                      CustomTextFormField(
                        controller: _emailController,
                        hintText: 'Email',
                        obscureText: false,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 10.0),
                      CustomTextFormField(
                        controller: _passwordController,
                        hintText: 'Password',
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      const SizedBox(height: 10.0),
                      CustomButton(
                        text: 'Sign Up',
                        onTap: () {
                          if (_signupFormKey.currentState!.validate()) {
                            _authenticationService.signup(
                              context: context,
                              name: _nameController.text,
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ListTile(
              tileColor: _authentication == Authentication.signin
                  ? kBackgroundColor
                  : kGreyBackgroundCOlor,
              title: const Text(
                'Sign In',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Radio(
                value: Authentication.signin,
                groupValue: _authentication,
                onChanged: (Authentication? value) =>
                    setState(() => _authentication = value!),
              ),
            ),
            if (_authentication == Authentication.signin)
              Container(
                padding: const EdgeInsets.all(8.0),
                color: kBackgroundColor,
                child: Form(
                  key: _signinFormKey,
                  child: Column(
                    children: <Widget>[
                      CustomTextFormField(
                        controller: _emailController,
                        hintText: 'Email',
                        obscureText: false,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 10.0),
                      CustomTextFormField(
                        controller: _passwordController,
                        hintText: 'Password',
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      const SizedBox(height: 10.0),
                      CustomButton(
                        text: 'Sign In',
                        onTap: () {
                          if (_signinFormKey.currentState!.validate()) {
                            _authenticationService.signin(
                              context: context,
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
