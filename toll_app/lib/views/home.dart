import 'package:flutter/material.dart';
import 'package:toll_app/services/authentication.dart';
import 'package:toll_app/services/payment.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthService authService1 = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.lime[50],
      appBar: AppBar(
        leading: const Icon(Icons.account_circle_outlined),
        backgroundColor: Colors.green[600],
        title: const Text('E-Tolls Mobile Payments'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 90.0),
            Image.asset(
              'assets/images/logo1.png',
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.3,
            ),
            const SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(//Takes user to the application's payment screen
                        builder: (context) => const Payment()));
              },
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                width: 350,
                // color: Colors.green,
                padding: const EdgeInsets.all(10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      ///Icon
                      Icon(
                        Icons.payment,
                        color: Colors.white,
                      ),

                      Text(
                        "Generate QR Code",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ]),
              ),
            ),

          ],
        ),
      ),
    );
  }

}
