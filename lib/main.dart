import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Must add this line.
  await windowManager.ensureInitialized();

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
                IconButton(onPressed: () {}, icon: Icon(Icons.home), tooltip: "Home",),
                IconButton(onPressed: () {}, icon: Icon(Icons.settings), tooltip: "Settings",),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {},
            icon: Icon(Icons.add_photo_alternate),
            label: Text("Add references"),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  windowManager.close();
                },
                icon: Icon(Icons.close),
              ),
            ],
          ),
          body: Center(
            child: Column(
              children: [
             
              ],
            ),
          ),
        ),
      ),
    );
  }
}
