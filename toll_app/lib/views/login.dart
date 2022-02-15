import 'package:flutter/material.dart';
import 'package:toll_app/services/authentication.dart';
import 'package:toll_app/views/home.dart';

import 'signup.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _formKey = GlobalKey<FormState>();
  late String name, email, password; //Variables to hold captured values
  AuthService authService = AuthService();
  bool _isLoading = false; //used to initiate the circular loading indicator when data is being fetched from databse


  logIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      //Method for signing in user using values in google firebase
      authService.signInEmailAndPass(email, password).then((value) {
        if (value != null) {
          setState(() {
            _isLoading = false;
          });

          //Takes user  to the home screen of the application
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const Home()));
        }
      });
    }
  }

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
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Column(
                children: [
                  // TextBox()
                  Image.asset( //Logo of the application
                    'assets/images/logo1.png',
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.3,
                  ),
                  Form(//Form for capturing user input
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 5),
                          width: 330,
                          height: 90,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TextFormField(//Captures user email
                            validator: (val) {
                              return val!.isEmpty
                                  ? "Enter correct email"
                                  : null;
                            },
                            // controller: emailCtrl,
                            decoration: const InputDecoration(
                              labelText: "Email",
                              icon: Icon(Icons.email, color: Colors.green),
                              border: InputBorder.none,
                            ),
                            onChanged: (val) {
                              email = val;
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 5),
                          width: 330,
                          height: 90,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TextFormField(//captures the user's password
                            obscureText: true,
                            validator: (val) {
                              return val!.isEmpty ? "Enter password" : null;
                            },
                            // controller: passwordCtrl,
                            decoration: const InputDecoration(
                              labelText: "Password",
                              icon: Icon(Icons.password_outlined,
                                  color: Colors.green),
                              border: InputBorder.none,
                            ),
                            onChanged: (val) {
                              password = val;
                            },
                          ),
                        ),
                        GestureDetector(//submit the form and move to the next screen
                          onTap: () {
                            logIn();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            height: 50,
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width - 100,
                            child: const Text(
                              'Log In',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green[700],
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account?",
                              style: TextStyle(fontSize: 15.5),
                            ),
                            GestureDetector(
                              onTap: () {
                                //Takes new user to the sign up screen
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const SignUp()));
                              },
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(
                                    decoration: TextDecoration.underline),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
