import 'package:mysql_client/mysql_client.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {

      MySQLConnection? conn;
  List<String> _dropdownValues = []; // List to store values from MySQL
  String? _selectedValue; // Currently selected value

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

    await conn!.connect();

    _fetchDropdownValues();
  }

  Future<void> _fetchDropdownValues() async {
    if (conn == null) {
      print("Database connection not established.");
      return;
    }

    var result = await conn!.execute("SELECT * FROM Services"); // Example query

    setState(() {
      _dropdownValues = result.rows.map((row) => row.colAt(0) as String).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Aly'),
        ),
        body: Center(
          child: _dropdownValues.isEmpty
              ? const CircularProgressIndicator()
              : Column(children: [
                DropdownButton<String>(
                    value: _selectedValue,
                    hint: const Text('Select a value'),
                    items: _dropdownValues.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedValue = newValue;
                      });
                    },
                  ),
              ],)
                
        ),
      ),
    );
  }
  
  

  @override
  void dispose() {
    conn?.close();
    super.dispose();
  }
}
