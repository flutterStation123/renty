import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:renty_app/auth/loginPage.dart';
import 'package:renty_app/auth/services/signup.dart';

class clientSignupPage extends StatefulWidget {
  @override
  State<clientSignupPage> createState() => _clientSignupPageState();
}

class _clientSignupPageState extends State<clientSignupPage> {
  final UserService _authService = UserService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Future<void> _createAccount() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        await _authService.signup(
            _emailController.text, _passwordController.text, context);
        await _authService.addClient(
            _nameController.text,
            _emailController.text,
            _passwordController.text,
            _phoneController.text,
            context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Account created successfully!")),
        );
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to create account: $error")),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.only(top: screenHeight * 0.05),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Welcome!",
                  style: TextStyle(
                    fontSize: screenWidth * 0.08,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 17, 91, 151),
                  ),
                ),
                Text(
                  "Create a new account",
                  style: TextStyle(
                    color: Colors.grey.withOpacity(0.8),
                    fontSize: screenWidth * 0.045,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02), 
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildTextField("Name", _nameController, Icons.person,
                          "Enter Your Name", screenWidth),
                      _buildTextField("Email", _emailController, Icons.email,
                          "Enter Your Email", screenWidth),
                      _buildTextField("Phone", _phoneController,
                          Icons.phone_android, "Enter Your Phone", screenWidth),
                      _buildPasswordField("Password", _passwordController,
                          "Enter Your Password", screenWidth),
                      _buildPasswordField(
                          "Confirm Password",
                          _confirmPasswordController,
                          "Confirm Your Password",
                          screenWidth,
                          true),
                      SizedBox(height: screenHeight * 0.02), 
                      _isLoading
                          ? CircularProgressIndicator()
                          : SizedBox(
                              width: screenWidth * 0.75,
                              child: ElevatedButton(
                                onPressed: _createAccount,
                                style: ElevatedButton.styleFrom(
                                  shape: BeveledRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12),
                                  backgroundColor:
                                      Color.fromARGB(255, 7, 97, 172),
                                ),
                                child: const Text(
                                  "CREATE ACCOUNT",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white), 
                                ),
                              ),
                            ),
                      SizedBox(height: screenHeight * 0.02), 
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Already have an account?'),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                              );
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 0, 76, 138),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      IconData icon, String hint, double screenWidth) {
    return Container(
      width: screenWidth * 0.80, 
      margin: EdgeInsets.symmetric(vertical: 8.0), 
      child: TextFormField(
        controller: controller,
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

  Widget _buildPasswordField(String label, TextEditingController controller,
      String hint, double screenWidth,
      [bool isConfirm = false]) {
    return Container(
      width: screenWidth * 0.80, 
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        obscureText: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
          ),
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(Icons.lock, color: Colors.cyan),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your $label';
          }
          if (isConfirm && value != _passwordController.text) {
            return 'Passwords do not match';
          }
          return null;
        },
      ),
    );
  }
}
