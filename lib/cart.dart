import 'package:flutter/material.dart';
import 'package:demo_project/dish.dart';
class Cart extends StatefulWidget {
  final List<Dish> _cart;
  Cart(this._cart);

  @override
  _CartState createState() => _CartState(this._cart);
}

class _CartState extends State<Cart> {
  List<Dish> _cart;
  _CartState(List<Dish> cart);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: ListView.builder(
          itemCount: _cart.length,
          itemBuilder: (context, index){
            var item = _cart[index];
            return Padding(padding:
            const EdgeInsets.symmetric(horizontal: 8.0,
            vertical: 2.0),
            child: Card(
              elevation: 4.0,
              child: ListTile(
                leading: Icon(
                  item.iconData,
                  color: item.color,
                ),
                title: Text(item.name),
                trailing: GestureDetector(
                  child: Icon(
                    Icons.remove_circle,
                    color: Colors.red,
                  ),
                  onTap: (){
                    setState(() {
                      _cart.remove(item);
                    });
                  },
                ),
              ),
            ),);
          }),
    );
  }
}
