import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/core/application_theme_manager.dart';
import 'package:to_do_app/core/firebase_utils.dart';
import 'package:to_do_app/core/setting_provider.dart';

import '../../core/page_route_names.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

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

    List<String> languagesList = ["English", "عربي"];
    List<String> themeList = [lang.lightTheme, lang.darkTheme];
    return Column(
      children: [
        Container(
          width: screenWidth,
          height: screenHeight * 0.22,
          color: theme.primaryColor,
          padding: EdgeInsets.only(
              top: screenHeight * .08,
              left: screenWidth * .1,
              right: screenWidth * .1),
          child: Text(
            lang.settings,
            style: theme.textTheme.titleLarge?.copyWith(
              fontSize: 32,
              color: provider.isDark() ? const Color(0xFF060E1E) : Colors.white,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.1, vertical: screenHeight * 0.08),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                lang.language,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.primaryColor,
                ),
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              CustomDropdown<String>(
                items: languagesList,
                initialItem:
                    languagesList[provider.curLanguage == "en" ? 0 : 1],
                onChanged: (value) {
                  if (value != null) {
                    provider.changeLanguage(value == "English" ? "en" : "ar");
                  }
                },
                decoration: CustomDropdownDecoration(
                  closedFillColor: secondaryColor,
                  expandedFillColor: secondaryColor,
                  listItemStyle: theme.textTheme.bodyLarge?.copyWith(
                      color: textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                  headerStyle: theme.textTheme.bodyLarge?.copyWith(
                      color: textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: screenHeight * .075,
              ),
              Text(
                lang.themeMode,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.primaryColor,
                ),
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              CustomDropdown<String>(
                items: themeList,
                initialItem:
                    themeList[provider.curTheme == ThemeMode.light ? 0 : 1],
                onChanged: (value) {
                  if (value != null) {
                    provider.changeTheme(value == lang.lightTheme
                        ? ThemeMode.light
                        : ThemeMode.dark);
                  }
                },
                decoration: CustomDropdownDecoration(
                  closedFillColor: secondaryColor,
                  expandedFillColor: secondaryColor,
                  listItemStyle: theme.textTheme.bodyLarge?.copyWith(
                      color: textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                  headerStyle: theme.textTheme.bodyLarge?.copyWith(
                      color: textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.07,
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 17),
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: InkWell(
                  onTap: () {
                    FirebaseUtils.uid = "";
                    Navigator.pushReplacementNamed(
                        context, PageRouteNames.login);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        lang.logout,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: textColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Icon(
                        Icons.logout_rounded,
                        color: textColor,
                        size: 25,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
