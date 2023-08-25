enum ControlMessage { StateChange }

class Device {
  String id;
  String name;
  bool enabled;
  bool? healthStatus;
  String? type;
  Device({
    required this.id,
    required this.name,
    required this.enabled,
    this.healthStatus,
    this.type,
  });
  
  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "enabled": enabled,
        "healthStatus": healthStatus,
        "type": type,
      };

  @override
  String toString() =>
      "{ id: $id, name: $name, enabled: $enabled, " +
      "healthStatus: $healthStatus, type: $type }";
}

class DeviceData {
  String paramValue;
  String paramName;
  DateTime? createdAt;

  DeviceData({
    required this.paramName,
    required this.paramValue,
    this.createdAt,
  });

  Map<String, dynamic> toMap() => {
        "paramValue": paramValue,
        "paramName": paramName,
        "createdAt": createdAt.toString(),
      };

  @override
  String toString() =>
      "{ paramValue: $paramValue, paramName: $paramName, " +
      "createdAt: ${createdAt.toString()} }";
}

class SocketDataMessage {
  DeviceData data;
  String message;

  SocketDataMessage({
    required this.data,
    required this.message,
  });

  Map<String, dynamic> toMap() => {
        "message": message,
        "data": data.toMap(),
      };

  @override
  String toString() => "{ message: $message, data: ${data.toString()} }";
}

class SocketControlMessage {
  Device control;
  ControlMessage message;

  SocketControlMessage({
    required this.control,
    required this.message,
  });

  Map<String, dynamic> toMap() => {
        "control": control.toMap(),
        "message": message.toString().split(".").last
      };

  @override
  String toString() =>
      "{ message: ${message.toString().split(".").last}, control: ${control.toString()} }";
}
