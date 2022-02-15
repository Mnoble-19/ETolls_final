import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:toll_app/my_globals.dart' as globals;

class Generate extends StatefulWidget {
  const Generate({Key? key}) : super(key: key);

  @override
  _GenerateState createState() => _GenerateState();
}

class _GenerateState extends State<Generate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lime[50],
      appBar: AppBar(
        leading: const Icon(Icons.account_circle_outlined),
        backgroundColor: Colors.green[600],
        title: const Text('E-Tolls Mobile Payments'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            QrImage(
              data: globals.txRef,
              size: 300,
              backgroundColor: Colors.white,
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              padding: const EdgeInsets.all(15.0),
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: const Text(
                'Note: Please ensure to capture a screenshot of your QR Code that you will present at the Toll Gate!',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            )
            // const SizedBox(
            //   height: 30,
            // ),
          ],
        ),
      ),
    );
  }
}
