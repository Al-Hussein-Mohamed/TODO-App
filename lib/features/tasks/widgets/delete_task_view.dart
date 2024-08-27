import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/core/firebase_utils.dart';
import 'package:to_do_app/custom_widgets/custom_button.dart';
import '../../../core/setting_provider.dart';
import '../../../model/task_model.dart';

class DeleteTaskView extends StatelessWidget {
  TaskModel taskModel;

  DeleteTaskView({required this.taskModel, super.key});

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
    return Center(
      child: AlertDialog(
        backgroundColor: secondaryColor,
        insetPadding: EdgeInsets.zero,
        content: Container(
          width: screenWidth * .75,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                lang.deleteThisTaskPermanently,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.primaryColor,
                  fontSize: 30,
                ),
              ),
              SizedBox(
                height: screenHeight * .04,
              ),
              CustomButton(
                onTap: () {
                  EasyLoading.show();
                  FirebaseUtils.deleteTask(taskModel).then(
                    (value) {
                      Navigator.pop(context);
                      EasyLoading.dismiss();
                    },
                  );
                },
                backgroundColor: Colors.red,
                widget: Text(
                  lang.delete,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleMedium
                      ?.copyWith(color: secondaryColor),
                ),
              ),
              SizedBox(
                height: screenHeight * .02,
              ),
              CustomButton(
                onTap: () {
                  Navigator.pop(context);
                },
                backgroundColor: theme.primaryColor,
                widget: Text(
                  lang.cancel,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleMedium
                      ?.copyWith(color: secondaryColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
