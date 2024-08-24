import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/core/firebase_utils.dart';
import 'package:to_do_app/core/utils.dart';
import 'package:to_do_app/services/snack_bar_service.dart';

import '../../../core/setting_provider.dart';
import '../../../model/task_model.dart';

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
  bool titleValidation = true;

  @override
  void initState() {
    super.initState();
    titleController.text = taskModel.title;
    descriptionController.text = taskModel.description;
    selectedDate = taskModel.selectedDate;
  }

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
      child: SingleChildScrollView(
        child: AlertDialog(
          backgroundColor: secondaryColor,
          insetPadding: EdgeInsets.zero,
          content: SizedBox(
            width: screenWidth * .75,
            child: StatefulBuilder(
              builder: (context, setState) => Form(
                key: formKey,
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      // onChanged: (value) => taskModel.title = value,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          titleValidation = false;
                          return "invalid title";
                        }
                        titleValidation = true;
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: lang.title,
                        labelStyle: theme.textTheme.titleLarge?.copyWith(
                          color:
                              titleValidation ? theme.primaryColor : Colors.red,
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
                      // onChanged: (value) => taskModel.description = value,
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
                      height: screenHeight * .04,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.check_circle_outline_outlined,
                                color: theme.primaryColor,
                              ),
                              const SizedBox(
                                width: 7,
                              ),
                              Text(
                                lang.donee,
                                textAlign: TextAlign.center,
                                style: theme.textTheme.titleLarge?.copyWith(
                                  color: theme.primaryColor,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: screenWidth * .03),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: theme.primaryColor, width: 2),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () => setState(
                                      () => taskModel.isDone = false,
                                    ),
                                    borderRadius: provider.isEn()
                                        ? const BorderRadius.only(
                                        topLeft: Radius.circular(13),
                                        bottomLeft: Radius.circular(13))
                                        : const BorderRadius.only(
                                        topRight: Radius.circular(13),
                                        bottomRight:
                                        Radius.circular(13)),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 3),
                                      decoration: BoxDecoration(
                                        color: taskModel.isDone
                                            ? Colors.transparent
                                            : Colors.red,
                                        borderRadius: provider.isEn()
                                            ? const BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                bottomLeft: Radius.circular(13))
                                            : const BorderRadius.only(
                                                topRight: Radius.circular(13),
                                                bottomRight:
                                                    Radius.circular(13)),
                                      ),
                                      child: Icon(
                                        Icons.close_rounded,
                                        size: 28,
                                        color: taskModel.isDone
                                            ? theme.primaryColor
                                            : secondaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () => setState(
                                      () => taskModel.isDone = true,
                                    ),
                                    borderRadius: provider.isEn()
                                        ? const BorderRadius.only(
                                        topRight: Radius.circular(13),
                                        bottomRight:
                                        Radius.circular(13))
                                        : const BorderRadius.only(
                                        topLeft: Radius.circular(13),
                                        bottomLeft:
                                        Radius.circular(13)),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 3),
                                      decoration: BoxDecoration(
                                        color: taskModel.isDone
                                            ? Colors.green
                                            : Colors.transparent,
                                        borderRadius: provider.isEn()
                                            ? const BorderRadius.only(
                                                topRight: Radius.circular(13),
                                                bottomRight:
                                                    Radius.circular(13))
                                            : const BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                bottomLeft:
                                                    Radius.circular(13)),
                                      ),
                                      child: Icon(
                                        Icons.check_rounded,
                                        size: 28,
                                        color: taskModel.isDone
                                            ? secondaryColor
                                            : theme.primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * .04,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                        ),
                        Expanded(
                          flex: 2,
                          child: InkWell(
                            onTap: () {
                              getSelectedDate();
                            },
                            child: Text(
                              DateFormat("dd / MM / yyyy")
                                  .format(taskModel.selectedDate),
                              textAlign: TextAlign.center,
                              style: theme.textTheme.displayLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: textColor,
                              ),
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
                          taskModel.title = titleController.text.trim();
                          taskModel.description = descriptionController.text.trim();
                          FirebaseUtils.updateTask(taskModel).then(
                            (value) {
                              Navigator.pop(context);
                              EasyLoading.dismiss();
                            },
                          );
                        }
                        setState(() {

                        },);
                      },
                      borderRadius: BorderRadius.circular(15),
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
                              ?.copyWith(color: secondaryColor),
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
                      borderRadius: BorderRadius.circular(15),
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
                              ?.copyWith(color: secondaryColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
      setState(() => taskModel.selectedDate = extractDate(curDate));
    }
  }
}
