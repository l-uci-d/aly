import 'package:mysql_client/mysql_client.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  MySQLConnection? conn; 
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  bool _registering = false;
  String _loginMessage = "";
  bool _isLoading = true; 
  String _registerMessage = "";
  String _buttonText = "Log in";

  @override
  void initState() {
    super.initState();
    _connectToDatabase();
  }

  Future<void> _connectToDatabase() async {
    conn = await MySQLConnection.createConnection(
      host: "alydb.c3oiie4ou6u3.ap-southeast-2.rds.amazonaws.com",   
      port: 3306,          
      userName: "admin",    
      password: "12qwaszx",
      databaseName: "aly", 
    );

    await conn?.connect();

    setState(() {
      _isLoading = false; 
    });
  }

  Future<void> _login() async {
    print('attempting to log in');
    if (conn == null) {
      setState(() {
        _loginMessage = "Database connection not established.";
      });
      return;
    }

    final username = _usernameController.text;
    final password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      setState(() {
        _loginMessage = "Please enter both username and password.";
      });
      return;
    }
    var result = await conn!.execute(
      "SELECT * FROM Customer WHERE username = :username OR email = :username AND password = :password",
      {"username": username, "password": password},
    );


    if (result.rows.isNotEmpty) {
      setState(() {
        _loginMessage = "Login successful!";
        Navigator.pushNamed(context, '/dashboard');
      });
    } else {
      setState(() {
        _loginMessage = "Invalid username or password.";
      });
    }
  }

  Future<void> _register() async {
    print('attempting to register...');
    if (conn == null) {
      setState(() {
        _registerMessage = "Database connection not established.";
      });
      return;
    }

    final username =    _usernameController.text.trim();
    final password =    _passwordController.text.trim();
    final firstName =   _firstNameController.text.trim();
    final lastName =    _lastNameController.text.trim();
    final email =       _emailController.text.trim();
    final phoneNumber = _phoneNumberController.text.trim();
    final address =     _addressController.text.trim();
    final password1 =   _rePasswordController.text.trim();
  

    if (username.isEmpty || password.isEmpty) {
      setState(() {
        _registerMessage = "Please enter both username and password.";
      });
      return;
    }
    if (password != password1){
      setState(() {
        _registerMessage = "Passwords do not match.";
      });
      return;
    }
    

    var checkResult = await conn!.execute(
      "SELECT * FROM Customer WHERE username = :username OR email = :username",
      {"username": username},
    );

    if (checkResult.rows.isNotEmpty) {
      setState(() {
        _registerMessage = "Username already exists. Please choose another.";
      });
      return;
    }

    var result = await conn!.execute(
      """INSERT INTO Customer (username, firstName, lastName, email, password, phoneNumber, address, paymentDetails) 
      VALUES 
      (:username, :firstName, :lastName, :email, :password, :phoneNumber, :address, :phoneNumber )""",
      {"username": username, "firstName": firstName, "lastName": lastName, "email": email, "password": password, "phoneNumber": phoneNumber, "address": address},
    );
    await conn!.execute("COMMIT");

    if (result.affectedRows.toString() == '1') {
      setState(() {
        _registerMessage = "Registration successful for $username!";

          
      });
    } else {
      setState(() {
        _registerMessage = "Registration failed. Please try again.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator()) 
            : Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _usernameController,
                          decoration: const InputDecoration(
                            labelText: 'Enter Username or Email',
                          ),
                        ),
                        TextFormField(
                          controller: _passwordController,
                          decoration: const InputDecoration(
                            labelText: 'Enter Password',
                          ),
                          obscureText: true,
                        ),


                        if (_registering) ...[
                          TextFormField(
                            controller: _rePasswordController,
                            decoration: const InputDecoration(
                              labelText: 'Confirm Password',
                            ),
                            obscureText: true,
                          ),
                          TextFormField(
                            controller: _firstNameController,
                            decoration: const InputDecoration(
                              labelText: 'First Name',
                            ),
                          ),
                          TextFormField(
                            controller: _lastNameController,
                            decoration: const InputDecoration(
                              labelText: 'Last Name',
                            ),
                          ),
                          TextFormField(
                            controller: _phoneNumberController,
                            decoration: const InputDecoration(
                              labelText: 'Phone Number',
                            ),
                          ),
                          TextFormField(
                            controller: _addressController,
                            decoration: const InputDecoration(
                              labelText: 'Address',
                            ),
                          ),
                          TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                            ),
                            keyboardType: TextInputType.datetime,
                          ),
                        ],


                        ElevatedButton(
                          onPressed: _registering ? _register : _login,
                          child: Text(_buttonText),
                        ),
                        
                        Text(
                          _registering ? _registerMessage : _loginMessage,
                          style: const TextStyle(color: Colors.red),
                        ),

                          TextButton(
                            style: TextButton.styleFrom(
                              overlayColor: Colors.yellow,
                            ),
                            onPressed: () {
                              setState(() {
                                _registering = !_registering;
                                _registering ? _buttonText = "Sign up" : _buttonText = "Log in";
                              });
                            },

                            child: _registering ? const Text('Log in') : const Text('Register'),
                          ),
                      ],

                    ),
                  ),
                ],
              ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    conn?.close();
    super.dispose();
  }
}
