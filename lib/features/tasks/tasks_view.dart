import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/core/firebase_utils.dart';
import 'package:to_do_app/core/setting_provider.dart';
import 'package:to_do_app/features/tasks/widgets/task_item_widget.dart';

import '../../model/task_model.dart';

class TasksView extends StatefulWidget {
  const TasksView({super.key});

  @override
  State<TasksView> createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {
  final EasyInfiniteDateTimelineController _controller =
      EasyInfiniteDateTimelineController();
  var _focusDate = DateTime.now();

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
              child: Text(
                lang.todoList,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontSize: 32,
                  color: provider.isDark()
                      ? const Color(0xFF060E1E)
                      : Colors.white,
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: screenHeight * 0.16,
                ),
                EasyInfiniteDateTimeLine(
                  selectionMode: const SelectionMode.alwaysFirst(),
                  controller: _controller,
                  firstDate: DateTime(2024),
                  focusDate: _focusDate,
                  lastDate: DateTime.now().add(
                    const Duration(days: 365),
                  ),
                  onDateChange: (selectedDate) {
                    setState(() {
                      _focusDate = selectedDate;
                    });
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
                      ),
                    ),
                    inactiveDayStyle: DayStyle(
                      dayNumStyle: theme.textTheme.bodyLarge?.copyWith(
                          fontSize: 17,
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
                          fontSize: 17,
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
            stream: FirebaseUtils.getRealTimeData(_focusDate),
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
              tasksList?.sort((a, b) => convertBoolToInt(a.isDone).compareTo(convertBoolToInt(b.isDone)),);

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

  int convertBoolToInt(bool b){
    return b ? 1 : 0;
  }
}
