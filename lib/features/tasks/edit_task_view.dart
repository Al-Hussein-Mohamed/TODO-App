import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/core/firebase_utils.dart';
import 'package:to_do_app/services/snack_bar_service.dart';

import '../../core/setting_provider.dart';
import '../../model/task_model.dart';

class EditTaskView extends StatefulWidget {
  TaskModel taskModel;

  EditTaskView(this.taskModel, {super.key});

  @override
  State<EditTaskView> createState() => _EditTaskViewState(taskModel);
}

class _EditTaskViewState extends State<EditTaskView> {
  TaskModel taskModel;

  _EditTaskViewState(this.taskModel);

  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var selectedDate = DateTime.now();

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
    titleController.text = taskModel.title;
    descriptionController.text = taskModel.description;
    selectedDate = taskModel.selectedDate;

    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
      backgroundColor: secondaryColor,
      content: StatefulBuilder(builder: (context, setState) => Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              lang.editTask,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.primaryColor,
                fontSize: 30,
              ),
            ),
            SizedBox(
              height: screenHeight * .06,
            ),
            TextFormField(
              controller: titleController,
              cursorColor: textColor,
              cursorErrorColor: Colors.red,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "invalid title";
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: lang.title,
                labelStyle: theme.textTheme.titleLarge?.copyWith(
                  color: theme.primaryColor,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: theme.primaryColor, width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: theme.primaryColor, width: 2.0),
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
              controller: descriptionController,
              cursorColor: textColor,
              cursorErrorColor: Colors.red,
              maxLines: 4,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                labelText: lang.description,
                labelStyle: theme.textTheme.titleLarge?.copyWith(
                  color: theme.primaryColor,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: theme.primaryColor, width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: theme.primaryColor, width: 2.0),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.date_range_rounded,
                      color: theme.primaryColor,
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Text(
                      lang.date,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: theme.primaryColor,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    getSelectedDate();
                  },
                  child: Text(
                    DateFormat("dd / MM / yyyy").format(taskModel.selectedDate),
                    style: theme.textTheme.displayLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * .06,
            ),
            InkWell(
              onTap: () {
                if (formKey.currentState!.validate()) {
                  EasyLoading.show();
                  taskModel.title = titleController.text;
                  taskModel.description = descriptionController.text;
                  FirebaseUtils.updateTask(taskModel);
                  EasyLoading.dismiss();
                  SnackBarService.showSuccessMessage(
                      "Task has been updated successfully");
                  Navigator.pop(context);
                }
              },
              child: Container(
                width: screenWidth * .7,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  lang.save,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleMedium
                      ?.copyWith(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * .02,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: screenWidth * .7,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  lang.cancel,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleMedium
                      ?.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),),
    );
  }

  getSelectedDate() async {
    var curDate = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    if (curDate != null) {

      setState(() => taskModel.selectedDate = curDate);
    }
  }
}
