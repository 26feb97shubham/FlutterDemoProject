import 'dart:ui';
import 'package:demo_project/dish.dart';
import 'package:flutter/material.dart';
import 'cart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cart Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey
      ),
      home: MyHomePage(title: 'Place Order'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Dish> _dishes = List<Dish>();
  List<Dish> _cartList = List<Dish>();

  @override
  void initState() {
    super.initState();
    _populateDishes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          Padding(padding: const EdgeInsets.only(right: 16.0,top: 8.0),
          child: GestureDetector(
            child: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Icon(Icons.shopping_cart, size: 36.0),
                if(_cartList.length>0)
                  Padding(padding: const EdgeInsets.only(left: 2.0), child: CircleAvatar
                    (
                      radius: 8.0,
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    child: Text(
                      _cartList.length.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0
                      ),
                    ),
                  ),
                  )
              ],
            ),
            onTap: (){
              if(_cartList.isNotEmpty)
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Cart(_cartList)));
            },
          ),
          )
        ],
      ),
      body: _buildGridView(),
    );
  }
  GridView _buildGridView() {
    return GridView.builder(
        padding: const EdgeInsets.all(4.0),
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: _dishes.length,
        itemBuilder: (context, index) {
          var item = _dishes[index];
          return Card(
              elevation: 4.0,
              child: Stack(
                fit: StackFit.loose,
                alignment: Alignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        item.iconData,
                        color: (_cartList.contains(item))
                            ? Colors.grey
                            : item.color,
                        size: 100.0,
                      ),
                      Text(
                        item.name,
                        textAlign: TextAlign.center,
                        style: Theme
                            .of(context)
                            .textTheme
                            .subhead,
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 8.0,
                      bottom: 8.0,
                    ),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        child: (!_cartList.contains(item))
                            ? Icon(
                          Icons.add_circle,
                          color: Colors.green,
                        )
                            : Icon(
                          Icons.remove_circle,
                          color: Colors.red,
                        ),
                        onTap: () {
                          setState(() {
                            if (!_cartList.contains(item))
                              _cartList.add(item);
                            else
                              _cartList.remove(item);
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ));
        });
  }
  void _populateDishes(){
    var list = <Dish>[
      Dish('Chicken Zinger',
          Icons.fastfood,
          Colors.deepOrange),
      Dish(
        'Rice',
        Icons.child_care,
        Colors.brown,
      ),
      Dish(
        'Beef burger without beef',
        Icons.whatshot,
        Colors.green,
      ),
      Dish(
        'Laptop without OS',
        Icons.laptop,
        Colors.purple,
      ),
      Dish(
        'Mac wihout macOS',
        Icons.laptop_mac,
        Colors.blueGrey,
      )
    ];

    setState(() {
      _dishes = list;
    });
  }
}
