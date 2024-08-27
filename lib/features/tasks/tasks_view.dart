import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/core/firebase_utils.dart';
import 'package:to_do_app/core/setting_provider.dart';
import 'package:to_do_app/features/tasks/widgets/task_item_widget.dart';

import '../../core/utils.dart';
import '../../model/task_model.dart';

class TasksView extends StatefulWidget {
  const TasksView({super.key});

  @override
  State<TasksView> createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {
  var firstDate = DateTime(2024);

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

    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: screenWidth,
              height: screenHeight * 0.22,
              color: theme.primaryColor,
              padding: EdgeInsets.only(
                  top: screenHeight * .08,
                  left: screenWidth * .1,
                  right: screenWidth * .1),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: screenHeight * .065,
                  left: screenWidth * .1,
                  right: screenWidth * .1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    lang.todoList,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontSize: 35,
                      color: provider.isDark()
                          ? const Color(0xFF060E1E)
                          : Colors.white,
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () async {
                        DateTime? date =
                            await getSelectedDate(provider.focusDate);
                        if (date != null) {
                          provider.changeDate(date);
                        }
                      },
                      onLongPress: () => setState(
                        () {
                          provider.changeDate(DateTime.now());
                        },
                      ),
                      customBorder: const CircleBorder(),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.calendar_month,
                          size: 40,
                          color: secondaryColor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: screenHeight * 0.16,
                ),
                EasyInfiniteDateTimeLine(
                  selectionMode: const SelectionMode.alwaysFirst(),
                  controller: provider.controller,
                  firstDate: firstDate,
                  focusDate: provider.focusDate,
                  lastDate: DateTime.now().add(
                    const Duration(days: 365),
                  ),
                  locale: provider.curLanguage,
                  onDateChange: (selectedDate) {
                    provider.changeDate(selectedDate);
                  },
                  showTimelineHeader: false,
                  dayProps: EasyDayProps(
                    activeDayStyle: DayStyle(
                      dayNumStyle:
                          theme.textTheme.bodyLarge?.copyWith(fontSize: 25),
                      monthStrStyle: theme.textTheme.bodyMedium
                          ?.copyWith(fontSize: 19, fontWeight: FontWeight.w400),
                      dayStrStyle: theme.textTheme.bodyMedium
                          ?.copyWith(fontSize: 19, fontWeight: FontWeight.w400),
                      decoration: BoxDecoration(
                        color: secondaryColor.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(12),
                        border: sameDay(provider.focusDate)
                            ? Border.all(
                                color: provider.isDark()
                                    ? const Color(0xFF1F5AA4)
                                    : const Color(0xFF3C80C5),
                                width: 3,
                              )
                            : Border.all(
                                color: secondaryColor,
                                width: 0,
                              ),
                      ),
                    ),
                    inactiveDayStyle: DayStyle(
                      dayNumStyle: theme.textTheme.bodyLarge?.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: textColor),
                      monthStrStyle: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: textColor),
                      dayStrStyle: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: textColor),
                      decoration: BoxDecoration(
                        color: secondaryColor.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    todayStyle: DayStyle(
                      dayNumStyle: theme.textTheme.bodyLarge?.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: textColor),
                      monthStrStyle: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: textColor),
                      dayStrStyle: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: textColor),
                      decoration: BoxDecoration(
                        color: secondaryColor.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: provider.isDark()
                              ? const Color(0xFF1F5AA4)
                              : const Color(0xFF3C80C5),
                          width: 3,
                        ),
                      ),
                      borderRadius: 50,
                    ),
                  ),
                  timeLineProps: const EasyTimeLineProps(
                    backgroundColor: Colors.transparent,
                    separatorPadding: 15,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: screenHeight * .02,
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot<TaskModel>>(
            stream: FirebaseUtils.getRealTimeData(provider.focusDate),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Expanded(
                  child: Center(
                    child: Text(
                      lang.somethingWentWrong,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: theme.primaryColor,
                      ),
                    ),
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Expanded(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: theme.primaryColor,
                      backgroundColor: secondaryColor,
                    ),
                  ),
                );
              }

              var tasksList = snapshot.data?.docs
                  .map(
                    (e) => e.data(),
                  )
                  .toList();
              tasksList?.sort(
                (a, b) => convertBoolToInt(a.isDone)
                    .compareTo(convertBoolToInt(b.isDone)),
              );

              return tasksList == null || tasksList.isEmpty
                  ? Expanded(
                      child: Center(
                        child: Text(
                          lang.noTasksForThisDay,
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: theme.primaryColor,
                          ),
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) => TaskItemWidget(
                          taskModel: tasksList[index],
                        ),
                        itemCount: tasksList.length,
                      ),
                    );
            },
          ),
        ),
      ],
    );
  }

  int convertBoolToInt(bool b) {
    return b ? 1 : 0;
  }

  Future<DateTime?> getSelectedDate(DateTime focusDate) async {
    return await showDatePicker(
      context: context,
      initialDate: focusDate,
      firstDate: firstDate,
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
  }

  bool sameDay(DateTime focusDate) {
    if (focusDate.year != DateTime.now().year) return false;
    if (focusDate.month != DateTime.now().month) return false;
    if (focusDate.day != DateTime.now().day) return false;
    return true;
  }
}
