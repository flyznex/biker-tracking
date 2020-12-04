import 'vehicle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class VehiclesPage extends StatefulWidget {
  @override
  _VehiclesPage createState() => _VehiclesPage();
}

class _VehiclesPage extends State<VehiclesPage> {
  final List<VehicleViewModel> vehicles = <VehicleViewModel>[
    VehicleViewModel(
        id: "1",
        name: "Kawasaki Z1000",
        currentODO: 123456,
        updatedAt: new DateTime.now()),
    VehicleViewModel(
        id: "2",
        name: "Honda CB150R",
        currentODO: 150000,
        updatedAt: new DateTime.now()),
    VehicleViewModel(
        id: "3",
        name: "Exciter 135",
        currentODO: 40000,
        updatedAt: new DateTime.now()),
    VehicleViewModel(
        id: "4",
        name: "Wave alpha",
        currentODO: 4999,
        updatedAt: new DateTime.now()),
    VehicleViewModel(
        id: "5",
        name: "Lead ninja",
        currentODO: 1999,
        updatedAt: new DateTime.now()),
  ];
  @override
  Widget build(BuildContext context) {
    VehicleModel currentVehicle = VehicleModel.of(context);
    return Scaffold(
      body: ListView.separated(
          itemBuilder: (BuildContext ctx, int index) => Slidable(
                child: InkWell(
                  onTap: () {
                    VehicleModel.update(
                        ctx,
                        VehicleModel(
                            id: vehicles[index].id,
                            name: vehicles[index].name));
                    DefaultTabController.of(ctx).animateTo(1);
                  },
                  child: Container(
                    child: ListTile(
                      title: Text('${vehicles[index].name}'),
                      subtitle: Text('ODO: ${vehicles[index].currentODO} km'),
                      isThreeLine: true,
                      selected: currentVehicle.id == vehicles[index].id,
                    ),
                    height: 70,
                    color: Colors.amberAccent,
                  ),
                ),
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.25,
                secondaryActions: <Widget>[
                  IconSlideAction(
                      caption: 'Edit',
                      color: Colors.blueAccent,
                      icon: Icons.edit,
                      onTap: () {}),
                  IconSlideAction(
                      caption: 'Remove',
                      color: Colors.redAccent,
                      icon: Icons.remove,
                      onTap: () {})
                ],
              ),
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemCount: vehicles.length),
    );
  }
}

class VehicleViewModel {
  VehicleViewModel({this.id, this.name, this.currentODO, this.updatedAt});
  final String id;
  final String name;
  final double currentODO;
  final DateTime updatedAt;
}
