import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/core/firebase_utils.dart';
import 'package:to_do_app/core/page_route_names.dart';
import 'package:to_do_app/services/snack_bar_service.dart';

import '../../core/setting_provider.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  var formKey = GlobalKey<FormState>();
  var fullNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool isObsecure = true;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingProvider>(context);
    var lang = AppLocalizations.of(context)!;
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context);
    var screenHeight = mediaQuery.size.height;
    var screenWidth = mediaQuery.size.width;
    var secondaryColor =
        provider.isDark() ? const Color(0xFF141922) : Colors.white;
    var textColor = provider.isDark() ? Colors.white : Colors.black;
    var backgroundColor =
        provider.isDark() ? const Color(0xFF091731) : const Color(0xFFDFECDB);
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        image: const DecorationImage(
          image: AssetImage("assets/images/auth_background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            lang.registration,
            style: theme.textTheme.titleLarge?.copyWith(fontSize: 33),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: screenHeight * .25,
                  ),
                  TextFormField(
                    controller: fullNameController,
                    cursorColor: theme.primaryColor,
                    cursorErrorColor: Colors.red,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.w500,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "invalid E-mail";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: lang.fullName,
                      labelStyle: theme.textTheme.titleLarge?.copyWith(
                        color: theme.primaryColor,
                      ),
                      suffixIcon: Icon(Icons.person, color: theme.primaryColor,),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: theme.primaryColor, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: theme.primaryColor, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * .04,
                  ),
                  TextFormField(
                    controller: emailController,
                    cursorColor: theme.primaryColor,
                    cursorErrorColor: Colors.red,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.w500,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "invalid email";
                      }

                      var regex = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

                      if (!regex.hasMatch(value)) {
                        return "invalid email";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: lang.email,
                      labelStyle: theme.textTheme.titleLarge?.copyWith(
                        color: theme.primaryColor,
                      ),
                      suffixIcon: Icon(Icons.email, color: theme.primaryColor,),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: theme.primaryColor, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: theme.primaryColor, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * .04,
                  ),
                  TextFormField(
                    controller: passwordController,
                    cursorColor: theme.primaryColor,
                    cursorErrorColor: Colors.red,
                    obscureText: isObsecure,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.w500,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "invalid E-mail";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: lang.password,
                      labelStyle: theme.textTheme.titleLarge?.copyWith(
                        color: theme.primaryColor,
                      ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            isObsecure = !isObsecure;
                            setState(() {});
                          },
                          icon: isObsecure
                              ? Icon(Icons.visibility, color: theme.primaryColor,)
                              :  Icon(Icons.visibility_off, color: theme.primaryColor,),
                        ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: theme.primaryColor, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: theme.primaryColor, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),

                  ),
                  SizedBox(
                    height: screenHeight * .08,
                  ),
                  FilledButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        EasyLoading.show();
                        FirebaseUtils.createAccount(
                                emailController.text, passwordController.text)
                            .then(
                          (value) {
                            print(value);
                            if (value) {
                              EasyLoading.dismiss();
                              SnackBarService.showSuccessMessage(
                                  "Account has been created successfully");
                              Navigator.pop(context);
                            }
                          },
                        );
                      }
                    },
                    style: FilledButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * .06, vertical: 12),
                      backgroundColor: theme.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          lang.createAnAccount,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward,
                          size: 30,
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
}
