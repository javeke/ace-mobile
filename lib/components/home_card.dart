import 'package:flutter/material.dart';

class HomeCard extends StatefulWidget {
  @override
  _HomeCardState createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  bool isOn = false;
  int sensorValue = 12;

  void handleStateChange() {
    setState(() {
      isOn = !isOn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text("Device Name"),
                    SizedBox(width: 10),
                    Icon(Icons.sensors),
                  ],
                ),
                Row(
                  children: [
                    Text("Offline"),
                    IconButton(
                      iconSize: 16,
                      splashRadius: 16,
                      icon: Icon(isOn
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
            Text("Temperature: $sensorValue"),
          ],
        ),
      ),
    );
  }
}
