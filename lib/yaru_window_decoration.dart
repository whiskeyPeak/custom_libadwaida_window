import 'package:flutter/material.dart';
import 'package:yaru_window/yaru_window.dart';

import 'constants.dart';

class YaruWindowDecoration extends StatelessWidget {
  const YaruWindowDecoration({
    super.key,
    required this.child,
  });

  final Widget child;

  static final _windowStates = <YaruWindowInstance, YaruWindowState>{};

  static Future<void> ensureInitialized() {
    return YaruWindow.ensureInitialized().then((window) => window.show());
  }

  @override
  Widget build(BuildContext context) {
    final window = YaruWindow.of(context);

    return StreamBuilder<YaruWindowState>(
      stream: window.states(),
      initialData: _windowStates[window],
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _windowStates[window] = snapshot.data!;
        }
        final state = snapshot.data;

        return Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: state?.isMaximized == true
                  ? BorderRadius.zero
                  : kYaruWindowDecorationBorderRadius,
              child: child,
            ),
            IgnorePointer(
              ignoring: true,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white
                        .withOpacity(state?.isMaximized == true ? 0 : 0.07),
                  ),
                  borderRadius: kYaruWindowDecorationBorderRadius,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
