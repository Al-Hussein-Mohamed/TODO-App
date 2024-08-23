import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/core/firebase_utils.dart';
import 'package:to_do_app/model/task_model.dart';
import 'package:to_do_app/services/snack_bar_service.dart';

import '../../../core/setting_provider.dart';
import '../../../core/utils.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();

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
    return SingleChildScrollView(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: screenHeight * 0.54,
        width: screenWidth,
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 25),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                lang.addNewTask,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.primaryColor,
                ),
              ),
              SizedBox(
                height: screenHeight * .05,
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
                height: screenHeight * .03,
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
                height: screenHeight * .05,
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
                        lang.selectDate,
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
                      DateFormat("dd / MM / yyyy").format(selectedDate),
                      style: theme.textTheme.displayLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    EasyLoading.show();
                    FirebaseUtils.addTaskToFirestore(
                      TaskModel(
                          title: titleController.text,
                          description: descriptionController.text,
                          selectedDate: extractDate(selectedDate)),
                    ).then(
                      (value) {
                        Navigator.pop(context);
                        EasyLoading.dismiss();
                      },
                    );
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
                    lang.addTask,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleMedium
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getSelectedDate() async {
    var curDate = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    if (curDate != null) {
      setState(() {
        selectedDate = curDate;
      });
    }
  }
}
