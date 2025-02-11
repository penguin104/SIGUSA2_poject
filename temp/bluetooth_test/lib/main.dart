import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FlutterBluePlus flutterBlue = FlutterBluePlus();
  BluetoothDevice? connectedDevice;
  BluetoothCharacteristic? targetCharacteristic;

  @override
  void initState() {
    super.initState();
    scanForDevices();
  }

  // Bluetoothデバイスをスキャン
  void scanForDevices() async {
    FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));

    FlutterBluePlus.scanResults.listen((results) {
      print("results $results");
      for (ScanResult r in results) {
        if (r.device.platformName == "SIGUSA" || r.device.advName == "SIGUSA") {
          setState(() {
            print("connected");
            connectedDevice = r.device;
          });
          FlutterBluePlus.stopScan();
          connectToDevice();
          break;
        } else {
          print("cant conection");
        }
      }
    });
  }

  // M5Stackに接続
  void connectToDevice() async {
    if (connectedDevice == null) return;

    await connectedDevice!.connect();
    List<BluetoothService> services = await connectedDevice!.discoverServices();

    for (BluetoothService service in services) {
      for (BluetoothCharacteristic characteristic in service.characteristics) {
        if (characteristic.properties.write &&
            characteristic.properties.notify) {
          setState(() {
            targetCharacteristic = characteristic;
          });

          characteristic.setNotifyValue(true);
          characteristic.value.listen((value) {
            String receivedData = String.fromCharCodes(value);
            print("Received from M5Stack: $receivedData");
          });

          break;
        }
      }
    }
  }

  // データ送信
  void sendData(String message) async {
    if (targetCharacteristic != null) {
      await targetCharacteristic!.write(message.codeUnits);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("M5Stack Bluetooth Control")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(connectedDevice != null
                  ? "Connected to ${connectedDevice!.name}"
                  : "Scanning..."),
              ElevatedButton(
                onPressed: () => sendData("ON"),
                child: const Text("Turn ON"),
              ),
              ElevatedButton(
                onPressed: () => sendData("OFF"),
                child: const Text("Turn OFF"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
