import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterwave/core/flutterwave.dart';
import 'package:flutterwave/models/responses/charge_response.dart';
import 'package:toll_app/views/generate_qr.dart';
import '../my_globals.dart' as globals;
//Screen to process the payment  process
class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final TextEditingController _amount = TextEditingController();
  final TextEditingController _digits = TextEditingController();

  // AuthService authService1 = AuthService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
        child: Form(
          child: Column(
            children: [
              const SizedBox(
                height: 100.0,
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                width: 330,
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  controller: _amount,
                  decoration: const InputDecoration(
                    labelText: "Amount",
                    icon: Icon(Icons.money_outlined, color: Colors.green),
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                width: 330,
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  controller: _digits,
                  decoration: const InputDecoration(
                    labelText: "Phone Number",
                    icon: Icon(Icons.phone, color: Colors.green),
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ),
              GestureDetector(
                onTap: () {
                  final email = _auth.currentUser?.email;
                  final amount = _amount.text;
                  final digits = _digits.text;

                  if (amount.isEmpty || digits.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content:
                            Text("Fields are empty. Please fill all fields")));
                  } else {
                    ///Flutterwave Payment
                    _makePayment(context, email!, amount.trim(), digits.trim());
                  }
                },
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  width: 200,
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
                          "Make Payment",
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
      ),
    );
  }

  void _makePayment(
      BuildContext context, String email, String amount, String digits) async {
    try {
      Flutterwave flutterwave = Flutterwave.forUIPayment(
          context: this.context,
          encryptionKey: "FLWSECK_TEST4a574ff67463",
          publicKey: "FLWPUBK_TEST-0bc3bbdb66fdcd354f1e0a03cb6a01a5-X",
          currency: "UGX",
          amount: amount,
          email: email,
          fullName: "Test Name",
          isDebugMode: true,
          txRef: globals.txRef,
          phoneNumber: digits,
          acceptCardPayment: false,
          acceptUSSDPayment: false,
          acceptAccountPayment: false,
          acceptFrancophoneMobileMoney: false,
          acceptGhanaPayment: false,
          acceptMpesaPayment: false,
          acceptRwandaMoneyPayment: false,
          acceptUgandaPayment: true,
          acceptZambiaPayment: false);

      final ChargeResponse response =
          await flutterwave.initializeForUiPayments();

      if (response.status == "success") {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Generate()));
        // print(response.message);
      } else {
        // Navigator.push(context,
        // MaterialPageRoute(builder: (context) => const Generate()));
        print(response.message);
        // const Generate();
      }
    } catch (error) {
      print(error.toString());
    }
  }
}
