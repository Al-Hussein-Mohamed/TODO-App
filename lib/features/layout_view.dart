import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/core/setting_provider.dart';
import 'package:to_do_app/features/settings/settings_view.dart';
import 'package:to_do_app/features/tasks/tasks_view.dart';
import 'package:to_do_app/features/tasks/widgets/add_task_bottom_sheet.dart';

class LayoutView extends StatefulWidget {
  const LayoutView({super.key});

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  var featuresList = [const TasksView(), const SettingsView()];

  int currentFeature = 0;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingProvider>(context);
    var theme = Theme.of(context);
    var lang = AppLocalizations.of(context)!;
    var mediaQuery = MediaQuery.of(context);
    var screenHeight = mediaQuery.size.height;
    var screenWidth = mediaQuery.size.width;

    return Scaffold(
      body: featuresList[currentFeature],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        elevation: 5,
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => const AddTaskBottomSheet(),
          );
        },
        backgroundColor:
            provider.isDark() ? const Color(0xFF141922) : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: CircleAvatar(
          radius: 24,
          backgroundColor: theme.primaryColor,
          child: const Icon(
            Icons.add,
            size: 35,
            color: Colors.white,
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        height: screenHeight * .093,
        padding: EdgeInsets.zero,
        notchMargin: 12,
        color: provider.isDark() ? const Color(0xFF141922) : Colors.white,
        child: BottomNavigationBar(
          currentIndex: currentFeature,
          onTap: (idx) {
            setState(() {
              currentFeature = idx;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/icons/list_icn.png")),
              label: "List",
            ),
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage("assets/icons/settings_icn.png")),
                label: "Settings"),
          ],
        ),
      ),
    );
  }
}
