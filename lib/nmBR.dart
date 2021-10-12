import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:io';
import 'pages/alertConfirm.dart';
import 'widgets/formAlert.dart';
import 'dart:convert';

List getNetworks() {
  ProcessResult result =
      Process.runSync('nmcli', ['--terse', '-e', 'no', 'dev', 'wifi']);
  var networks = result.stdout;
  List availableNetworks;

  availableNetworks = networks.split("\n");

  //.forEach((network) {network = network.split(':');});

  return (availableNetworks);
}

IconData wifiBars(String nmcliIn, String security) {
  if (nmcliIn == "▂▄▆█" || nmcliIn == "▂▄▆_" || nmcliIn == "▂▄__") {
    if (security == "WPA2") {
      return Icons.signal_wifi_4_bar_lock;
    } else {
      return Icons.signal_wifi_4_bar;
    }
  } else {
    return Icons.signal_wifi_0_bar;
  }
}

Widget networkTile(
    String title, bool connected, String strength, String security, context) {
  return ListTile(
    //the icons suck but thats going to be all that is here until https://github.com/google/material-design-icons/issues/181 is resolved.
    leading: Icon(wifiBars(strength, security)),
    title: Text(title),
    subtitle: connected
        ? Text("Connected", style: TextStyle(color: Colors.green))
        : Text("Not connected"),
    onTap: () {
      final passwordController = TextEditingController();
      if (security == "WPA2" || security == "WPA1 WPA2" || security == "") {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text("Join Wi-Fi network"),
            content: SizedBox(
              height: 125,
              child: Column(
                children: [
                  TextFormField(
                    enabled: false,
                    initialValue: title,
                    decoration: InputDecoration(

                        //prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                        labelText: 'SSID'),
                  ),
                  Container(
                    height: 15,
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    enabled: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Password'),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Process.runSync("nmcli", [
                    "dev",
                    "wifi",
                    "connect",
                    title,
                    "password",
                    passwordController.text
                  ]);
                  print("Connecting to: " + title);
                  Navigator.of(ctx).pop();
                  var networkConnection = Process.runSync('curl', [
                    'https://packages.dahliaos.io/validation.get'
                  ]).stdout.toString().replaceAll('\n', '');
                  if (networkConnection == "true") {
                    final snackBar = SnackBar(
                        content: Text("Successfully connected to " + title));

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    final snackBar = SnackBar(
                        content:
                            Text(title + " does not have internet access."));

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  //TODO: Set state here to indicate connection/fail
                },
                child: Text("Connect"),
              ),
            ],
          ),
        );
      } else {
        final snackBar = SnackBar(
            content: Text(title +
                " does not use a supported security protocol (" +
                security +
                ")"));

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    },
  );
}

List parseNetworks(context) {
  List input = getNetworks();
  List<Widget> tiles = [
    Text(
        'For the best experience, connect to a network before installing dahliaOS.'),
    Container(
      height: 10,
    ),
  ];
  input.forEach((network) {
    //TODO: Remove channel and frequency duplicate networks
    if (network.toString().split(":").length > 1) {
      print(network);
      if (network.toString().split(":")[0] == "*") {
        tiles.add(networkTile(
            network.toString().split(":")[7],
            true,
            network.toString().split(":")[12],
            network.toString().split(":")[13],
            context));
      } else {
        tiles.add(networkTile(
            network.toString().split(":")[7],
            false,
            network.toString().split(":")[12],
            network.toString().split(":")[13],
            context));
      }
    }
  });

  return tiles;
}
