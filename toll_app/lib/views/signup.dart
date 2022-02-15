import 'package:flutter/material.dart';
import 'package:toll_app/services/authentication.dart';

import 'home.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  late String name, email, password;
  AuthService authService = AuthService();
  bool _isLoading = false;

  signUp() {
    //Signs up user to application
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      authService.signUpWithEmailAndPassword(email, password).then((value) {
        //passes values captured in form to google firebase
        if (value != null) {
          setState(() {
            _isLoading = false;
          });
          Navigator.pushReplacement(//Takes user to the home screen of the appication
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
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Column(
                children: [
                  // TextBox()
                  Image.asset(
                    'assets/images/logo1.png',
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.3,
                  ),
                  Form(
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
                          child: TextFormField(
                            validator: (val) {
                              return val!.isEmpty ? "Enter correct name" : null;
                            },
                            // controller: usernameCtrl,
                            decoration: const InputDecoration(
                              labelText: "Full name",
                              icon: Icon(Icons.person, color: Colors.green),
                              border: InputBorder.none,
                            ),
                            onChanged: (val) {
                              name = val;
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
                          child: TextFormField(
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
                          child: TextFormField(
                            obscureText: true,
                            validator: (val) {
                              return val!.isEmpty
                                  ? "Enter valid password"
                                  : null;
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
                        // const SizedBox(
                        //   height: 24,
                        // ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Home()));
                            signUp();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            height: 50,
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width - 100,
                            child: const Text(
                              'Sign Up',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green[700],
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
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
