import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      systemNavigationBarColor: Colors.black,
    ),
  );
  runApp( MyApp());

}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyLoginScreen(),


      debugShowCheckedModeBanner: false,

    );
  }
}
class MyLoginScreen extends StatefulWidget {
  const MyLoginScreen({super.key});

  @override
  State<MyLoginScreen> createState() => _MyLoginScreenState();
}

class _MyLoginScreenState extends State<MyLoginScreen> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  void _navigateSecondscreen(){
    //line extracts the text typed by user
    final String username = _username.text;
    final String password = _password.text;
    Navigator.push(context, MaterialPageRoute(builder: (context)=>DashBoardPage(username:username,password:password)));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Application',style: TextStyle(color: Colors.white),),
      backgroundColor:Colors.deepPurpleAccent ,),
backgroundColor: Colors.lightBlueAccent,
      // systemOverlayStyle: SystemUiOverlayStyle(
      //   systemNavigationBarColor: Colors.grey[850],
      //   statusBarColor: Colors.grey[850],
      // ),


      body:

Column(children: [

  Padding(padding: EdgeInsets.all(75 ),
  child:
  Text('Registration',style: TextStyle(fontSize: 30),),
    ),

      Padding(padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            TextField(
              controller: _username,
              decoration: InputDecoration(
                  labelText: 'User ID',
              ),
            ),
            SizedBox(height: 20
              ,
            ),

            TextField(
              controller: _password,
              decoration: InputDecoration(
                  labelText: 'Password'
              ),
              //password different
              obscureText: true,
            ),
            SizedBox(height: 20
              ,
            ),
            TextField(
              controller: _password,
              decoration: InputDecoration(
                  labelText: 'Confirm Password'
              ),
              //password different
              obscureText: true,
            ),
            SizedBox(height: 20
              ,
            ),


            ElevatedButton(onPressed: _navigateSecondscreen,
                child: Text('Save'),),


          ],
        ),

      ),

      ],
    ),
    );

  }
}
class DashBoardPage extends StatelessWidget {
  final String username;
  final String password;

  DashBoardPage({required this.username,required this.password});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Application',style: TextStyle(color: Colors.grey),
        ),
      ),
      body: Center(
          child:Column(
            children: [
              Text('Welcome $username'),
              SizedBox(height: 20,),
              Text('Welcome $password'),

            ],
          )

      ),
    );
  }
}
