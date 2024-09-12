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

class EditProfileView extends StatefulWidget {
  static const name = '/editProfile';
  const EditProfileView({
    super.key,
  });

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _firstNameController,
      _lastNameController,
      _dateOfBirthController,
      _emailController,
      _phoneController;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

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
    final user = context.read<AppProvider>().user!;
    _firstNameController = TextEditingController(text: user.firstName);
    _lastNameController = TextEditingController(text: user.lastName);
    _emailController = TextEditingController(text: user.email);
    _phoneController = TextEditingController(text: user.phone);
    _dateOfBirthController = TextEditingController(text: user.birthday);
    final gender = Gender.values.byName(user.gender!);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon profil'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
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
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Telephone',
                ),
              ),
              const SizedBox(height: 10),
              if (_emailController.text.isNotEmpty)
                TextFormField(
                  validator: AppValidators.validateOptionalEmail,
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                ),
              const SizedBox(height: 10),
              TextFormField(
                // validator: AppValidators.required,
                controller: _dateOfBirthController,
                canRequestFocus: false,
                onTap: _onSelectDate,
                decoration: const InputDecoration(
                  labelText: 'Date de naissance',
                ),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField(
                onSaved: (value) {},
                validator: (value) {
                  return AppValidators.required(value?.toString());
                },
                decoration: InputDecoration(
                    label: Text(gender.label),
                    contentPadding: const EdgeInsets.only(
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
                onChanged: (value) {},
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
                      // final user = widget.user.copyWith(
                      //   firstName: _firstNameController.text,
                      //   lastName: _lastNameController.text,
                      //   email: _emailController.text,
                      //   birthday: _dateOfBirthController.text,
                      //   gender: gender?.name,
                      // );
                      // context.read<AppProvider>().setUser(user);
                      if (mounted) {
                        Navigator.pushNamedAndRemoveUntil(
                          // ignore: use_build_context_synchronously
                          context,
                          WrapperView.name,
                          (route) => false,
                        );
                      }
                    }
                  } catch (e) {
                    if (mounted) {
                      showSnackBar(
                        // ignore: use_build_context_synchronously
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
