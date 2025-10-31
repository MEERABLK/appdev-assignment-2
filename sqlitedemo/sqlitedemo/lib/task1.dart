import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      systemNavigationBarColor: Colors.black,
    ),
  );
  runApp( const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyRegisterScreen(),


      debugShowCheckedModeBanner: false,

    );
  }
}
class MyRegisterScreen extends StatefulWidget {
  const MyRegisterScreen({super.key});

  @override
  State<MyRegisterScreen> createState() => _MyRegisterScreenState();
}

class _MyRegisterScreenState extends State<MyRegisterScreen> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmpass = TextEditingController();
  final snackBar = const SnackBar(content:  Text('Passwords dont match!'));

  void _navigateSecondscreen(){
    //line extracts the text typed by user
    final String username = _username.text;
    final String password = _password.text;
    final String confirmpass = _confirmpass.text;
    if(confirmpass==password)
    {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage(registeredUsername:username,registredPassword:password)));
    }
    else
    {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Application',style:  TextStyle(color: Colors.white),),
        backgroundColor:Colors.deepPurpleAccent ,),
      backgroundColor: Colors.lightBlueAccent,
      // systemOverlayStyle: SystemUiOverlayStyle(
      //   systemNavigationBarColor: Colors.grey[850],
      //   statusBarColor: Colors.grey[850],
      // ),


      body:

      Column(children: [

        const Padding(padding: EdgeInsets.all(75 ),
          child:
          Text('Registration',style: TextStyle(fontSize: 30),),
        ),

        Padding(padding: const EdgeInsets.only(top: 0,left: 80,right: 80,bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              TextField(
                controller: _username,
                decoration: const InputDecoration(
                  labelText: 'User ID',
                ),
              ),
              const SizedBox(height: 20
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
                controller: _confirmpass,
                decoration: InputDecoration(
                    labelText: 'Confirm Password'
                ),
                //password different
                obscureText: true,
              ),
              SizedBox(height: 20
                ,
              ),


              Column(
                children: [ElevatedButton (
                  onPressed: (){
                    _navigateSecondscreen();
                  },




                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3)
                    ),

                  ),
                  child: Text('SAVE',style: TextStyle(color: Colors.white),),)],
              )
            ],


          ),
        ),
      ],
      ),





    );

  }
}




class LoginPage extends StatelessWidget {
  final String registeredUsername;
  final    String registredPassword;
  LoginPage({required this.registeredUsername,required this.registredPassword});

  final TextEditingController _loginusername = TextEditingController();
  final TextEditingController _loginpassword = TextEditingController();


  void _navigateHomescreen(BuildContext context){
    //line extracts the text typed by user
    final  typedusername = _loginusername.text;
    final typedpass = _loginpassword.text;
    final snackBar1 = SnackBar(content: Text('Incorrect UserID'));
    final snackBar2 = SnackBar(content: Text('Incorrect Password'));

    if(typedusername!=registeredUsername)
    {

      ScaffoldMessenger.of(context).showSnackBar(snackBar1);
      return;
    }
    else if(typedpass!=registredPassword)
    {
      ScaffoldMessenger.of(context).showSnackBar(snackBar2);
      return;
    }
    else
    {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(loggedUsername: typedusername,)));
    }
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
          Image.asset('asset/img1.png',width: 100,height: 100,),
        ),

        Padding(padding: EdgeInsets.only(top: 0,left: 80,right: 80,bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              TextField(
                controller: _loginusername,
                decoration: InputDecoration(
                  labelText: 'User ID',
                ),
              ),
              SizedBox(height: 20
                ,
              ),

              TextField(
                controller: _loginpassword,
                decoration: InputDecoration(
                    labelText: 'Password'
                ),
                //password different
                obscureText: true,
              ),
              SizedBox(height: 20
                ,
              ),


              Column(
                children: [

                  Padding(
                    padding: EdgeInsets.only(top: 100,left: 50),
                    child:

                    ElevatedButton (

                      onPressed: (){
                        _navigateHomescreen(context);
                      },




                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,


                        minimumSize: Size(300, 60),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)

                        ),

                      ),
                      child: Text('REGISTER',style: TextStyle(color: Colors.white,fontSize: 20),
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


    );

  }
}
class HomeScreen extends StatefulWidget {
  final String loggedUsername;
  HomeScreen({super.key,required this.loggedUsername});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final List<String>pizzas = [
    'Veg Pizza',
    'Cheese Pizza',
    'Chicken Pizza',
    'Spinach Pizza'
  ];
  final List<String>pizzasDescription = [
    'Vegetable Pizza \n most popular \n freshly baked \n with tomato sauce',
    'Cheese Pizza \n mozzarella cheese \n freshly baked \n with tomato sauce',
    'Chicken Pizza \n chicken pieces \n freshly baked \n with tomato sauce',
    'Spinach Pizza \n basil spinach and herbs \n freshly baked \n with tomato sauce',

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Application', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepPurpleAccent,),
      backgroundColor: Colors.lightBlueAccent,
      // systemOverlayStyle: SystemUiOverlayStyle(
      //   systemNavigationBarColor: Colors.grey[850],
      //   statusBarColor: Colors.grey[850],
      // ),
      body:

      Column(children: [

        Padding(padding: EdgeInsets.only(right: 100,top: 50),
          child:
          Text('Pizzas', style: TextStyle(fontSize: 30),),

        ),
        Padding(padding: EdgeInsets.only(top: 0,left: 250)
          ,
          child:
          Text(
            'User: ${widget.loggedUsername}', style: TextStyle(fontSize: 20),
          ),
        ),

        Expanded(
          child: GridView.count(
            crossAxisCount: 2
            ,
            padding: const EdgeInsets.all(50),

            mainAxisSpacing: 50,
            crossAxisSpacing: 50,
            children:
            _buildGridTileList(pizzas.length),


          ),
        ),
      ],
      ),
    );




  }

  List<Widget> _buildGridTileList(int count) {
    return List.generate(
      count,
      // to make image clickable use inkwell ontap
          (i) => InkWell(onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsPage(
              name: pizzas[i],
              imagePath: 'asset/img$i.png',
              loggedUsername: widget.loggedUsername,
              description: pizzasDescription[i],
            ),
          ),
        );
      },
        child: Ink(
          decoration: BoxDecoration(
          ),
          child: Column(
            children: [
              Expanded(
                child: Image.asset(
                  'asset/img$i.png',

                ),
              ),



            ],
          ),
        ),
      ),
    );
  }
}
class DetailsPage extends StatefulWidget {
  final String name;
  final String imagePath;
  final String loggedUsername;
  final String description;

  const DetailsPage({
    super.key,
    required this.imagePath,
    required this.name,
    required this.loggedUsername,
    required this.description
  });

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int smallQty = 0;
  int mediumQty = 0;
  int bigQty = 0;
  int toppingSmallQty = 0;
  int toppingMediumQty = 0;
  int toppingBigQty = 0;

  final int smallPrice = 10;
  final int mediumPrice = 20;
  final int bigPrice = 30;
  final int toppingSmall = 2;
  final int toppingMedium = 3;
  final int toppingBig = 5;

  int get totalCost {
    return (smallQty * smallPrice) +
        (mediumQty * mediumPrice) +
        (bigQty * bigPrice) +
        (toppingSmallQty * toppingSmall) +
        (toppingMediumQty * toppingMedium) +
        (toppingBigQty * toppingBig);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('My Application', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepPurpleAccent,),
      backgroundColor: Colors.lightBlueAccent,

      body:
      Column(
        children: [
          Row(
              children: [
                Padding(padding: EdgeInsets.only(
                    right: 80, top: 80, left: 50
                ),
                  child:
                  Text(
                    widget.name,
                    style: const TextStyle(
                        fontSize: 26, fontWeight: FontWeight.bold),
                  ),


                ),
                Padding(padding: EdgeInsets.only(top: 80, left: 50),
                  child:
                  Text(
                    'User: ${widget.loggedUsername}',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ]
          ),

          Padding(padding: EdgeInsets.only(left: 10, top: 10),
            child:

            Image.asset(
              widget.imagePath,
              width: 180,
              height: 180,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            widget.description,
            style: const TextStyle(fontSize: 18),
          ),


          // Size + Price
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10),
                child:
                Text('Size',
                  style:
                  TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 60),
                child:

                Text('Small', style: TextStyle(fontSize: 18)),
              ),
              Padding(
                padding: EdgeInsets.only(left: 60),
                child:

                Text('Medium', style: TextStyle(fontSize: 18)),
              ),
              Padding(
                padding: EdgeInsets.only(left: 60),
                child:

                Text('Big', style: TextStyle(fontSize: 18)),

              ),
            ],
          ),

          Row(
            children:  [
              Padding(
                padding: EdgeInsets.only(left: 10),
                child:

                Text('Price',
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: EdgeInsets.only(left: 50),
                child:

                Text('10CAD'),
              ),
              Padding(
                padding: EdgeInsets.only(left: 80),
                child:

                Text('20CAD'),
              ),
              Padding(
                padding: EdgeInsets.only(left: 60),
                child:

                Text('30CAD'),
              ),
            ],
          ),



          // Pizza Quantity Row
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 60),
                child:
                buildQtyBox(smallQty, (val) => setState(() => smallQty = val)),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child:
                buildQtyBox(mediumQty, (val) => setState(() => mediumQty = val)),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child:
                buildQtyBox(bigQty, (val) => setState(() => bigQty = val)),
              ),
            ],
          ),

          const SizedBox(height: 25),

          // Toppings Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Toppings',
                  style:
                  TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text('Small 2CAD'),
              Text('Medium 3CAD'),
              Text('Big 5CAD'),
            ],
          ),

          const SizedBox(height: 10),

          Row(

            children: [
              Padding(
                padding: EdgeInsets.only(left: 60),
                child:
                buildQtyBox(toppingSmallQty,
                        (val) => setState(() => toppingSmallQty = val)),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child:
                buildQtyBox(toppingMediumQty,
                        (val) => setState(() => toppingMediumQty = val)),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child:
                buildQtyBox(
                    toppingBigQty, (val) => setState(() => toppingBigQty = val)),
              ),
            ],
          ),

          const SizedBox(height: 30),
          Text('Total cost: ${totalCost.toStringAsFixed(2)} CAD',
              style:
              const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),


          SizedBox(
            width: 300, // desired width
            child: Divider(
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurpleAccent,
              padding:
              const EdgeInsets.only(left: 35,right: 35,top: 10,bottom: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
            ),
            onPressed: () {


              if(totalCost>0)
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CheckoutPage(loggedUsername: widget.loggedUsername, totalCost: totalCost)
                  ),

                );


                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        'Order placed! Total: ${totalCost.toString(
                        )} CAD')));
              }
              else
              {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        'Enter a Quantity')));
              }

            },

            child: const Text('ORDER',
                style: TextStyle(fontSize: 20, color: Colors.white)),
          ),

        ],
      ),


    );
  }

  Widget buildQtyBox(int qty, void Function(int) onQtyChanged) {
    return Container(

      child: Row(
        children: [
          ElevatedButton(
            onPressed: () {
              onQtyChanged(qty + 1);
            },
            style: ElevatedButton.styleFrom(


                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                backgroundColor: Colors.deepPurpleAccent,
                maximumSize: Size(50, 30),
                minimumSize: const Size(0, 0)),

            child: const Text('+',
                style: TextStyle(fontSize: 18, color: Colors.white)),
          ),

          ElevatedButton(
            onPressed: () {
              if (qty > 0) onQtyChanged(qty - 1);
            },
            style: ElevatedButton.styleFrom(


                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),

                backgroundColor: Colors.deepPurpleAccent,
                maximumSize: Size(50, 30),

                minimumSize: const Size(0, 0)),
            child: const Text('-',
                style: TextStyle(fontSize: 18, color: Colors.white)),
          ),
        ],
      ),
    );
  }
}


class CheckoutPage extends StatefulWidget {
  final String loggedUsername;
  final int totalCost;
  CheckoutPage({super.key,required this.loggedUsername,required this.totalCost
  });

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Application', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepPurpleAccent,),
      backgroundColor: Colors.lightBlueAccent,

      body:
      Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 10,left: 300),
            child:
            Text(
              'User ID: ${widget.loggedUsername}', style: TextStyle(fontSize: 20),
            ),
          ),


          Padding(padding: EdgeInsets.only(top: 100),
            child:
            const Text('Your order has been processed',
                style:
                 TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

          ),
          const SizedBox(
            width: 300, // desired width
            child:  Divider(
              color: Colors.black,
thickness: 1.5,
            ),
          ),

          Padding(padding: const EdgeInsets.only(top: 100),
            child:

            Text('Please Pay: ${widget.totalCost.toString()} CAD for confirmation',
                style:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),

          const SizedBox(
            width:330, // desired width
            child:  Divider(
              color: Colors.black,
              thickness: 1.5,
            ),
          ),

          const SizedBox(height: 100),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurpleAccent,
              padding:
              const EdgeInsets.only(left: 35,right: 35,top: 10,bottom: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content:  Text(
                      'RETURNING TO HOME PAGE')));
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(
                    loggedUsername: widget.loggedUsername,
                  ),
                ),
              );
            },

            child: const Text('HOME',
                style: TextStyle(fontSize: 20, color: Colors.white)),
          ),


        ],
      ),
    );
  }
}
