import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:window_manager/window_manager.dart';
import 'package:hive_ce/hive_ce.dart';
import 'package:reffy/hive/hive_registrar.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Must add this line.
  await windowManager.ensureInitialized();

  await Hive.initFlutter();


  WindowOptions windowOptions = WindowOptions(
    size: Size(800, 600),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<StatefulWidget> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromRGBO(231, 25, 74, 1),
        ),
      ),
      darkTheme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromRGBO(231, 25, 74, 1),
          brightness: Brightness.dark,
        ),
      ),
      home: DragToMoveArea(
        child: Scaffold(
          bottomNavigationBar: BottomAppBar(
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.home),
                  tooltip: "Home",
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.settings),
                  tooltip: "Settings",
                ),
                VerticalDivider(),
                DropdownMenu(
                  dropdownMenuEntries: [
                    DropdownMenuEntry(value: "all", label: "All", leadingIcon: Icon(Icons.auto_awesome_mosaic_outlined)),
                    DropdownMenuEntry(value: "album1", label: "Tadeas Refs",),
                    DropdownMenuEntry(value: "album2", label: "Butch Lesbians"),
                    DropdownMenuEntry(value: "album3", label: "Horses"),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.perm_media_outlined),
                  tooltip: "Add Album",
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {},
            icon: Icon(Icons.add_photo_alternate_outlined),
            label: Text("Add references"),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.endContained,
          appBar: Platform.isWindows
              ? PreferredSize(
                  preferredSize: const Size.fromHeight(kWindowCaptionHeight),
                  child: WindowCaption(
                    title: Text("Reffy"),
                    brightness: Brightness.dark,
                    backgroundColor: Colors.transparent,
                  ),
                )
              : null,
          body: Center(child: Column(children: [
             
              ],
            )),
        ),
      ),
    );
  }
}
