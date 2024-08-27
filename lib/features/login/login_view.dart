import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/core/firebase_utils.dart';
import 'package:to_do_app/core/page_route_names.dart';
import 'package:to_do_app/services/snack_bar_service.dart';

import '../../core/setting_provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isObsecure = true;
  bool passwordValidation = true;
  bool emailValidation = true;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var auth = FirebaseAuth.instance;
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
            lang.login,
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
                    height: screenHeight * .2,
                  ),
                  Text(
                    lang.welcome,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: textColor,
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * .06,
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
                        emailValidation = false;
                        return "invalid E-mail";
                      }

                      var regex = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

                      if (!regex.hasMatch(value)) {
                        emailValidation = false;
                        return "invalid E-mail";
                      }
                      emailValidation = true;
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: lang.email,
                      labelStyle: theme.textTheme.titleLarge?.copyWith(
                        color:
                            emailValidation ? theme.primaryColor : Colors.red,
                      ),
                      suffixIcon: Icon(
                        Icons.email,
                        color:
                            emailValidation ? theme.primaryColor : Colors.red,
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
                        borderSide:
                            const BorderSide(color: Colors.red, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.red, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.04,
                  ),
                  TextFormField(
                    controller: passwordController,
                    cursorColor: theme.primaryColor,
                    cursorErrorColor: Colors.red,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.w500,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        passwordValidation = false;
                        return "invalid Password";
                      }
                      passwordValidation = true;
                      return null;
                    },
                    obscureText: isObsecure,
                    decoration: InputDecoration(
                      labelText: lang.password,
                      labelStyle: theme.textTheme.titleLarge?.copyWith(
                        color: passwordValidation
                            ? theme.primaryColor
                            : Colors.red,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          isObsecure = !isObsecure;
                          setState(() {});
                        },
                        icon: isObsecure
                            ? Icon(
                                Icons.visibility,
                                color: passwordValidation
                                    ? theme.primaryColor
                                    : Colors.red,
                              )
                            : Icon(
                                Icons.visibility_off,
                                color: passwordValidation
                                    ? theme.primaryColor
                                    : Colors.red,
                              ),
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
                        borderSide:
                            const BorderSide(color: Colors.red, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.red, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    lang.forgetPassword,
                    style: theme.textTheme.displaySmall?.copyWith(
                      decorationColor: textColor,
                      decoration: TextDecoration.underline,
                      fontSize: 15,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  FilledButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        EasyLoading.show();
                        FirebaseUtils.singIn(
                                emailController.text, passwordController.text)
                            .then(
                          (value) {
                            if (value) {
                              if(auth.currentUser!.emailVerified) {
                                EasyLoading.dismiss();
                                SnackBarService.showSuccessMessage(
                                    "Login successfully");
                                Navigator.pushReplacementNamed(
                                    context, PageRouteNames.layout);
                              } else {
                                EasyLoading.dismiss();
                                SnackBarService.showErrorMessage(
                                    "Verify your E-mail!");
                                FirebaseUtils.signOut();
                              }
                            }
                          },
                        );
                      }
                      setState(() {});
                    },
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 12),
                      backgroundColor: theme.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          lang.login,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward,
                          size: 30,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, PageRouteNames.registration);
                      },
                      child: Text(
                        lang.createAnAccount,
                        style: theme.textTheme.displaySmall?.copyWith(
                          decorationColor: textColor,
                          decoration: TextDecoration.underline,
                          fontSize: 15,
                          color: textColor,
                        ),
                      ),
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
