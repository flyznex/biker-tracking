import 'package:flutter/material.dart';
import 'vehicle.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPage createState() => _HistoryPage();
}

class _HistoryPage extends State<HistoryPage> {
  final List<String> histories = <String>[
    'History 1',
    'History 2',
    'History 3',
    'History 4',
    'History 5'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
          itemBuilder: (BuildContext ctx, int index) {
            VehicleModel vh = VehicleModel.of(ctx);
            return Container(
                height: 70,
                color: Colors.amberAccent,
                child: Center(
                    child: Text('${vh.id}-${vh.name}-${histories[index]}')));
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemCount: histories.length),
    );
  }
}
