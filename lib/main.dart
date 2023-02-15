import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:yaru_widgets/widgets.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  await YaruWindowTitleBar.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
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

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> bodyNames = [
    "Tile 1",
    "Tile 2",
    "Tile 3",
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: YaruMasterDetailPage(
        appBar: const YaruWindowTitleBar(),
        layoutDelegate: const YaruMasterResizablePaneDelegate(
          initialPaneWidth: 300,
          minPageWidth: 200,
          minPaneWidth: 200,
        ),
        tileBuilder: (context, index, selected) => YaruMasterTile(
          title: Text(bodyNames[index]),
        ),
        pageBuilder: (context, index) => YaruDetailPage(
          appBar: const YaruWindowTitleBar(
            title: Text("title"),
          ),
          body: Center(
            child: Text(bodyNames[index]),
          ),
        ),
        length: 3,
      ),
    );
  }
}
