import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/core/firebase_utils.dart';
import 'package:to_do_app/core/setting_provider.dart';
import 'package:to_do_app/features/tasks/widgets/edit_task_view.dart';
import 'package:to_do_app/features/tasks/widgets/delete_task_view.dart';
import '../../../model/task_model.dart';
import '../../settings/settings_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskItemWidget extends StatelessWidget {
  TaskModel taskModel;

  TaskItemWidget({required this.taskModel, super.key});

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
    var progressColor =
        taskModel.isDone ? const Color(0xFF61E757) : theme.primaryColor;

    List<Widget> titleOnlyTask = [
      Text(
        taskModel.title,
        style: theme.textTheme.titleLarge?.copyWith(
          color: progressColor,
          fontSize: 23,
        ),
      ),
    ];
    List<Widget> fullTaskList = [
      Text(
        taskModel.title,
        style: theme.textTheme.titleLarge?.copyWith(
          color: progressColor,
          fontSize: 22,
        ),
      ),
      const SizedBox(
        height: 7,
      ),
      Text(
        taskModel.description,
        style: theme.textTheme.displaySmall?.copyWith(
          color: textColor,
          fontSize: 16,
          fontWeight: FontWeight.w300,
        ),
      ),
    ];
    return Container(
      margin: EdgeInsets.only(
        bottom: screenHeight * 0.024,
        left: screenWidth * .04,
        right: screenWidth * .04,
      ),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: .38,
          motion: const BehindMotion(),
          dragDismissible: false,
          children: [
            SlidableAction(
              onPressed: (context) {
                showDialog(
                  context: context,
                  builder: (context) => DeleteTaskView(taskModel: taskModel),
                );
              },
              padding: EdgeInsets.zero,
              borderRadius: provider.isEn()
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    )
                  : const BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: lang.delete,
            ),
            SlidableAction(
              onPressed: (context) {
                showDialog(
                  context: context,
                  builder: (context) => EditTaskView(TaskModel.set(taskModel)),
                );
              },
              padding: EdgeInsets.zero,
              backgroundColor: const Color(0xFF3D4A5F),
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: lang.edit,
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * .07, vertical: screenHeight * 0.025),
          width: screenWidth,
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            horizontalTitleGap: 2,
            leading: Container(
              width: 4,
              decoration: BoxDecoration(
                color: progressColor,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  taskModel.description.isEmpty ? titleOnlyTask : fullTaskList,
            ),
            trailing: taskModel.isDone
                ? Text(
                    lang.done,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: progressColor,
                    ),
                  )
                : InkWell(
                    onTap: () {
                      taskModel.isDone = true;
                      EasyLoading.show();
                      FirebaseUtils.updateTask(taskModel).then(
                        (value) => EasyLoading.dismiss(),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 18),
                      decoration: BoxDecoration(
                        color: theme.primaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.check_rounded,
                        size: 40,
                        color: secondaryColor,
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
