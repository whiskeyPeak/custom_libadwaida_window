import 'package:flutter/material.dart';
import 'package:yaru_widgets/widgets.dart';
import 'package:yaru/yaru.dart';

import 'yaru_window_decoration.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await YaruWindowDecoration.ensureInitialized();
  await YaruWindowTitleBar.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: yaruDark,
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
  Widget build(BuildContext context) {
    return YaruWindowDecoration(
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
