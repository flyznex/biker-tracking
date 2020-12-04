import 'package:flutter/material.dart';

class Vehicle extends StatefulWidget {
  Vehicle({
    Key key,
    this.initialModel = const VehicleModel(),
    this.child,
  })  : assert(initialModel != null),
        super(key: key);
  final VehicleModel initialModel;
  final Widget child;
  @override
  _VehicleBindingState createState() => _VehicleBindingState();
}

class _VehicleBindingState extends State<Vehicle> {
  VehicleModel currentModel;
  @override
  void initState() {
    super.initState();
    currentModel = widget.initialModel;
  }

  @override
  Widget build(BuildContext context) {
    return VehicleScope(
      model: this,
      child: widget.child,
    );
  }

  void update(VehicleModel newModel) {
    if (newModel != currentModel) {
      setState(() {
        currentModel = newModel;
      });
    }
  }
}

class VehicleScope extends InheritedWidget {
  const VehicleScope({Key key, @required this.model, Widget child})
      : assert(model != null),
        super(key: key, child: child);
  final _VehicleBindingState model;
  @override
  bool updateShouldNotify(VehicleScope oldWidget) => model != oldWidget.model;
}

class VehicleModel {
  const VehicleModel({
    this.id = "",
    this.name = "",
  });
  final String id;
  final String name;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != this.runtimeType) return false;
    final VehicleModel otherModel = other;
    return this.id == otherModel.id;
  }

  @override
  int get hashCode => id.hashCode;

  static VehicleModel of(BuildContext context) {
    final VehicleScope vh = context.dependOnInheritedWidgetOfExactType();
    return vh.model.currentModel;
  }

  static void update(BuildContext context, VehicleModel vhm) {
    final VehicleScope vh = context.dependOnInheritedWidgetOfExactType();
    vh.model.update(vhm);
  }
}
