import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPage createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {
  final List<String> settings = <String>[
    'Setting 1',
    'Setting 2',
    'Setting 3',
    'Setting 4',
    'Setting 6'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
          // itemBuilder: (BuildContext ctx, int index) {
          //   return Container(
          //     height: 100,
          //     color: Colors.amberAccent,
          //     child: Center(child: Text('${settings[index]}')),

          //   );
          // },
          itemBuilder: (BuildContext ctx, int index) => GestureDetector(
              onTap: () {
                DefaultTabController.of(ctx).animateTo(0);
              },
              onPanUpdate: (detail) {
                if (detail.delta.dx > 0) {
                  DefaultTabController.of(ctx).animateTo(1);
                }
              },
              child: Container(
                  height: 50,
                  color: Colors.amberAccent,
                  child: Center(child: Text('${settings[index]}')))),
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemCount: settings.length),
    );
  }
}
