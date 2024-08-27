import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../core/firebase_utils.dart';
import '../core/setting_provider.dart';

class CustomButton extends StatelessWidget {
  final Widget widget;
  final void Function()? onTap;
  final Color backgroundColor;
  final double padding;

  const CustomButton({
    super.key,
    required this.onTap,
    required this.backgroundColor,
    required this.widget,
    this.padding = 10.0,
  });

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context)!;
    var provider = Provider.of<SettingProvider>(context);
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context);
    var screenHeight = mediaQuery.size.height;
    var screenWidth = mediaQuery.size.width;
    var secondaryColor =
        provider.isDark() ? const Color(0xFF141922) : Colors.white;
    var textColor = provider.isDark() ? Colors.white : Colors.black;
    return Container(
      width: screenWidth * .7,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(15),
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: widget,
          ),
        ),
      ),
    );
  }
}
