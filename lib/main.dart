import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_mobile_vision/qr_camera.dart';

void main() {
  debugPaintSizeEnabled = false;
  runApp(HomePage());
}

class HomePage extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyApp());
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String qr = '';
  bool camState = false;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR App'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: camState
                    ? Center(
                        child: SizedBox(
                          width: 300.0,
                          height: 500.0,
                          child: QrCamera(
                            onError: (context, error) => Text(
                              error.toString(),
                              style: const TextStyle(color: Colors.red),
                            ),
                            qrCodeCallback: (code) {
                              setState(() {
                                qr = code!;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(
                                    color: Colors.orange,
                                    width: 10.0,
                                    style: BorderStyle.solid),
                              ),
                            ),
                          ),
                        ),
                      )
                    : const Center(child: Text("Camera inactive"))),
            Center(
                child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Text("QRCode: $qr")))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Text(
            (camState == false ? "Open Cam" : "Close Cam"),
            textAlign: TextAlign.center,
          ),
          onPressed: () {
            setState(() {
              camState = !camState;
            });
          }),
    );
  }
}
