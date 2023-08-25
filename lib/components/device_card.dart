import 'dart:convert';

import 'package:acemobile/common/types.dart';
import 'package:flutter/material.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

class DeviceCard extends StatefulWidget {
  final StompClient? stompClient;
  final Device device;
  final String organizationId = "5";

  DeviceCard({Key? key, required this.device, this.stompClient})
      : super(key: key);

  @override
  _DeviceCardState createState() => _DeviceCardState();
}

class _DeviceCardState extends State<DeviceCard> {
  String paramValue = "12";

  @override
  void initState() {
    super.initState();
    if (widget.stompClient?.connected == true) {
      widget.stompClient?.subscribe(
        destination:
            "/deviceData/organizations/${widget.organizationId}/devices/${widget.device.id}",
        callback: handleDataSubscription,
      );
      widget.stompClient?.subscribe(
        destination:
            "/controlData/organizations/${widget.organizationId}/devices/${widget.device.id}",
        callback: handleControlSubscription,
      );
    }
  }

  void handleDataSubscription(StompFrame frame) {
    if (frame.body != null) {
      Map<String, dynamic> messageBody = json.decode(frame.body!);
      setState(() {
        paramValue = messageBody["data"]["paramValue"];
      });
    }
  }

  void handleControlSubscription(StompFrame frame) {
    if (frame.body != null) {
      Map<String, dynamic> messageBody = json.decode(frame.body!);
      dynamic control = messageBody["control"];
      setState(() {
        widget.device.enabled = control['enabled'];
      });
    }
  }

  void handleStateChange() {
    widget.device.enabled = !widget.device.enabled;

    if (widget.stompClient?.connected == true) {
      SocketControlMessage body = SocketControlMessage(
          control: widget.device, message: ControlMessage.StateChange);
      widget.stompClient?.send(
        destination:
            "/ace/control/organizations/${widget.organizationId}/devices/${widget.device.id}",
        body: json.encode(body.toMap()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Container(
        padding: const EdgeInsets.only(left: 8.0, bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(widget.device.name),
                    SizedBox(width: 10),
                    Icon(Icons.sensors),
                  ],
                ),
                Row(
                  children: [
                    Text("Offline"),
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      iconSize: 16,
                      splashRadius: 16,
                      icon: Icon(widget.device.enabled
                          ? Icons.wifi_tethering
                          : Icons.portable_wifi_off_sharp),
                      onPressed: handleStateChange,
                    )
                  ],
                )
              ],
            ),
            SizedBox(height: 10),
            Text("Latest Value"),
            SizedBox(height: 10),
            Text("Temperature: $paramValue"),
          ],
        ),
      ),
    );
  }
}
