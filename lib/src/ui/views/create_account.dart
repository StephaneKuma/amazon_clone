import 'package:amazon_clone/injection_container.dart';
import 'package:amazon_clone/main.dart';
import 'package:amazon_clone/src/enums/gender.dart';
import 'package:amazon_clone/src/models/user/user.dart';
import 'package:amazon_clone/src/providers/app_provider.dart';
import 'package:amazon_clone/src/services/authentication_service.dart';
import 'package:amazon_clone/src/services/user_service.dart';
import 'package:amazon_clone/src/ui/helpers/constants.dart';
import 'package:amazon_clone/src/ui/helpers/utils.dart';
import 'package:amazon_clone/src/ui/views/wrapper_view.dart';
import 'package:amazon_clone/src/ui/widgets/custom_button.dart';
import 'package:amazon_clone/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateAccountView extends StatefulWidget {
  static const name = '/createAccount';
  final User user;
  const CreateAccountView({
    super.key,
    required this.user,
  });

  @override
  State<CreateAccountView> createState() => _CreateAccountViewState();
}

class _CreateAccountViewState extends State<CreateAccountView> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _dateOfBirthController = TextEditingController();
  final _emailController = TextEditingController();
  Gender? gender;
  bool isLoading = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _dateOfBirthController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Détails personnels",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 48),
              TextFormField(
                validator: AppValidators.validateName,
                controller: _lastNameController,
                decoration: const InputDecoration(
                  labelText: 'Nom',
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                validator: AppValidators.validateName,
                controller: _firstNameController,
                decoration: const InputDecoration(
                  labelText: 'Prenom',
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                validator: AppValidators.validateOptionalEmail,
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                validator: AppValidators.required,
                controller: _dateOfBirthController,
                canRequestFocus: false,
                onTap: _onSelectDate,
                decoration: const InputDecoration(
                  labelText: 'Date de naissance',
                ),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField(
                onSaved: (value) {
                  setState(() {
                    gender = value;
                  });
                },
                validator: (value) {
                  return AppValidators.required(value?.toString());
                },
                decoration: const InputDecoration(
                    label: Text("Sexe"),
                    contentPadding: EdgeInsets.only(
                      bottom: 12,
                      top: 12,
                    )),
                isExpanded: true,
                items: Gender.values.map((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(e.label),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    gender = value;
                  });
                },
              ),
              const SizedBox(height: 48),
              CustomButton(
                text: "Continuer",
                btnColor: kSecondaryColor,
                onTap: () async {
                  try {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      final user = widget.user.copyWith(
                        firstName: _firstNameController.text,
                        lastName: _lastNameController.text,
                        email: _emailController.text,
                        birthday: _dateOfBirthController.text,
                        gender: gender?.name,
                      );
                      await locator<UserService>().updateUser(user: user);
                      context.read<AppProvider>().setUser(user);
                      if (mounted) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          WrapperView.name,
                          (route) => false,
                        );
                      }
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
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  _onSelectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (date != null) {
      setState(() {
        _dateOfBirthController.text = date.toIso8601String().split("T").first;
      });
    }
  }
}
