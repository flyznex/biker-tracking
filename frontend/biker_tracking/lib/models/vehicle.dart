class VehicleModel {
  String id;
  String name;
  double currentODO;
  DateTime createdAt;
  DateTime updatedAt;
  bool favorite;

  VehicleModel(id, name, currentODO, favorite)
      : id = id,
        name = name,
        currentODO = currentODO,
        favorite = favorite;

  factory VehicleModel.fromMap(Map<String, dynamic> json) {
    var vhm = new VehicleModel(
        json["id"], json["name"], json["current_odo"], json["favorite"]);
    vhm.createdAt = json["created_at"];
    vhm.updatedAt = json["updated_at"];
    return vhm;
  }
  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "current_odo": currentODO,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "favorite": favorite
      };
}
