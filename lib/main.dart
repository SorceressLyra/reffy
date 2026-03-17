import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:reffy/models/reference_image.dart';
import 'package:window_manager/window_manager.dart';
import 'package:reffy/hive/hive_registrar.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Must add this line.
  await windowManager.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapters();

  await Hive.openBox('Images');
  await Hive.openBox('Settings');

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
  late final Box imageBox;
  late final Box settingsBox;
  final List<ReferenceImage> images = [];

  @override
  void initState() {
    imageBox = Hive.box("Images");
    settingsBox = Hive.box("Settings");

    super.initState();
  }

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
                  initialSelection: "all",
                  dropdownMenuEntries: [
                    DropdownMenuEntry(
                      value: "all",
                      label: "All",
                      leadingIcon: Icon(Icons.auto_awesome_mosaic_outlined),
                    ),
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
          body: StreamBuilder(
            stream: imageBox.watch(),
            builder: (context, asyncSnapshot) {
              return Center(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 150,
                  ),
                  itemCount: imageBox.length,
                  itemBuilder: (context, index) {
                    ReferenceImage image = imageBox.getAt(index);
                    return Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: GestureDetector(
                        onTap: () {
                          debugPrint("${image.imagePath.path} clicked");
                        },
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.file(
                              File(image.imagePath.path),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
