import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:renty_app/BottomNavgationBar.dart';
import 'package:renty_app/auth/Role.dart';
import 'package:renty_app/auth/services/signin.dart';
import 'package:renty_app/homePage.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _authService = AuthService();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final containerWidth = screenWidth > 600 ? 400.0 : screenWidth * 0.85;

    return Scaffold(
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(top: 80.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  "assets/login.png",
                  fit: BoxFit.cover,
                  height: 100,
                ),
                Text(
                  "Welcome !",
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 17, 91, 151),
                  ),
                ),
                Text(
                  "Sign in to continue",
                  style: TextStyle(
                    color: Colors.grey.withOpacity(0.8),
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 30.0),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildTextField("EMAIL", _email, Icons.email_outlined,
                          "Enter Your email", containerWidth),
                      SizedBox(height: 15.0),
                      _buildTextField("PASSWORD", _password, Icons.lock,
                          "Enter Your Password", containerWidth,
                          obscureText: true),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 220.0),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 76, 138),
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                SizedBox(
                  width: containerWidth,
                  child: ElevatedButton(
                    onPressed: _isLoading
                        ? null
                        : () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                _isLoading = true;
                              });
                              try {
                                await _authService.signIn(
                                  _email.text,
                                  _password.text,
                                  context,
                                );
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BaseScaffold(),
                                  ),
                                );
                              } on Exception catch (e) {
                                print(e);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('An error occurred')),
                                );
                              } finally {
                                setState(() {
                                  _isLoading = false;
                                });
                              }
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: Color.fromARGB(255, 7, 97, 172),
                    ),
                    child: _isLoading
                        ? CircularProgressIndicator()
                        : Text(
                            "LOGIN",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                  ),
                ),
                SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account?',
                        style: TextStyle(fontSize: 12.0)),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => userRole(),
                          ),
                        );
                      },
                      child: Text(
                        'Create a new account',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 76, 138),
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      IconData icon, String hint, double width,
      {bool obscureText = false}) {
    return Container(
      width: width,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
          ),
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(icon, color: Colors.cyan),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your $label';
          }
          return null;
        },
      ),
    );
  }
}
