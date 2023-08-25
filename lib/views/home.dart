import 'dart:convert';

import 'package:acemobile/components/device_card.dart';
import 'package:acemobile/common/types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import "package:http/http.dart" as http;

class Home extends StatefulWidget {
  final String apiUrl = dotenv.get("APIURL");
  final String stompUrl = dotenv.get("STOMPURL");
  final String organizationId = dotenv.get("ORGANIZATIONID");
  final String deviceId = dotenv.get("DEVICEID");

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  StompClient? stompClient;
  Device? device;
  List<Device>? devices;
  String title = "Ace Dashboard";

  @override
  void initState() {
    super.initState();

    getDevices();

    if (stompClient == null) {
      stompClient = StompClient(
        config: StompConfig.SockJS(
          url: widget.apiUrl + widget.stompUrl,
          onConnect: handleSocketConnection,
          onDisconnect: handleSocketDisconnect,
          onWebSocketError: handleSocketError,
        ),
      );

      stompClient?.activate();
    }
  }

  // safe setState
  @override
  void setState(void Function() func) {
    if(!mounted) return;
    setState(func);
  }

  getDevices() {
    Uri url = Uri.parse(
        widget.apiUrl + "/api/organizations/${widget.organizationId}/devices");
    Future<http.Response> response = http.get(url);
    response.then((res) {
      List<dynamic> body = json.decode(res.body);
      List<Device> devicesMap = body
          .map((dev) => Device(
              id: dev["id"],
              name: dev["name"],
              enabled: dev["enabled"],
              type: dev['type'],
              healthStatus: dev['healthStatus']))
          .toList();
      setState(() {
        devices = devicesMap;
      });
    });
  }

  void handleSocketConnection(StompFrame frame) {
    stompClient?.send(destination: "/ace/test", body: "Test Mobile");
  }

  void handleSocketDisconnect(StompFrame frame) {
    print("Socket Connection disconnected");
  }

  void handleSocketError(dynamic error) {
    print(error);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(
            color: Color(0xFF4BCFFA),
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        minimum: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            ...?devices
                ?.map((card) => DeviceCard(
                      device: card,
                      stompClient: stompClient,
                    ))
                .toList()
          ],
        ),
      ),
    );
  }
}
