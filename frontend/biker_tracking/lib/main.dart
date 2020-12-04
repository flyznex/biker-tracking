
import 'package:flutter/material.dart';
import './ui/history_page.dart';
import './ui/vehicles_page.dart';
import './ui/setting_page.dart';
import './ui/vehicle.dart';

void main() {
  runApp(TrackingApp());
}

class TrackingApp extends StatefulWidget {
  @override
  _TrackingApp createState() => _TrackingApp();
}

class _TrackingApp extends State<TrackingApp> {
  var tabIndex = 0;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Vehicles Tracking',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.deepOrange,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: DefaultTabController(
            initialIndex: tabIndex,
            length: 3,
            child: Vehicle(
              initialModel:  const VehicleModel(),
              child: Scaffold(
                appBar: AppBar(
                    title: Text('Vehicles Tracking'),
                    bottom: TabBar(tabs: [
                      Tab(icon: Icon(Icons.motorcycle), text: "Vehicles"),
                      Tab(icon: Icon(Icons.history), text: "History"),
                      Tab(icon: Icon(Icons.settings), text: "Settings"),
                    ])),
                body: TabBarView(
                  children: [VehiclesPage(), HistoryPage(), SettingsPage()],
                ),
              ),
            )));
  }
}
