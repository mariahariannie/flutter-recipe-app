import 'package:flutter/material.dart';
import 'package:recipe/models/Item.dart';

class Checklist extends StatefulWidget {
  static const String routeName = "checklist";

  @override
  _ChecklistState createState() => _ChecklistState();
}

class _ChecklistState extends State<Checklist> {
  final List<Item> _items = <Item>[];
  final TextEditingController _textFieldController = TextEditingController();

  void _addItem(String name) {
    setState(() {
      _items.add(Item(name: name, completed: false));
    });
    _textFieldController.clear();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Grocery List"),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: _items.map((Item item) {
          return ListItem(
            item: item,
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _displayDialog(),
        tooltip: 'Add an Item',
        child: const Icon(Icons.add),
      ), 
    );
  }

  Future<void> _displayDialog() async {
    return showDialog<void>(
      context: context,
      //T: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add an Item'),
          content: TextField(
            controller: _textFieldController,
            decoration: const InputDecoration(hintText: 'Type your item'),
            autofocus: true,
          ),
          actions: <Widget>[
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _addItem(_textFieldController.text);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}

class ListItem extends StatelessWidget {
  ListItem({required this.item}) : super(key: ObjectKey(item));

  final Item item;

  TextStyle? _getTextStyle(bool checked) {
    if (!checked) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: Checkbox(
        checkColor: Colors.greenAccent,
        activeColor: Colors.red,
        value: item.completed,
        onChanged: (value) {},
      ),
      title: Row(children: <Widget>[
        Expanded(
          child: Text(item.name, style: _getTextStyle(item.completed)),
        ),
        IconButton(
          iconSize: 30,
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
          alignment: Alignment.centerRight,
          onPressed: () {},
        ),
      ]),
    );
  }
}

// import 'package:flutter/material.dart';

// class Checklist extends StatefulWidget {
//   static const String routeName = "checklist";

//   @override
//   _ChecklistState createState() => _ChecklistState();
// }

// class _ChecklistState extends State<Checklist> {
//   List<String> items = [];
//   final TextEditingController listController = TextEditingController();
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Grocery List")
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: <Widget>[
//             CreateListTextField(),
//             //SizedBox(height: 10.0),
//             ElevatedButton(
//               onPressed: AddItem,
//               child: Text("Add to list"),
//             ),
//             SizedBox(height: 16.0),
//             CreateList(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget CreateListTextField() {
//     return Container(
//       margin: EdgeInsets.only(bottom: 16.0),
//       decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(8.0),
//     ),
//       child: TextField(
//         controller: listController,
//         decoration: InputDecoration(
//           hintText: 'Add an item',
//           contentPadding: EdgeInsets.all(16.0),
//         ),
//       ),
//     );
//   }
  
//   Widget CreateList() {
//     return Expanded(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: EdgeInsets.only(top: 16.0),
//               child: Text(
//                 "Items",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//             ),
//             Divider(thickness: 2),
//             Expanded(
//             child: ListView.builder(
//               physics: AlwaysScrollableScrollPhysics(),
//               itemCount: items.length,
//               itemBuilder: (context, index) {
//                 return Card(
//                   margin: EdgeInsets.only(top: 10.0),
//                   elevation: 3,
//                   child: ListTile(
//                     title: Text(items[index]),
//                     trailing: Icon(Icons.delete),
//                   ),
//                 );
//               },
//             ),
//            ),
//           ], 
//         ),
//     );
//   }

//   void AddItem() {
//     String newItem = listController.text;
//     if (newItem.isNotEmpty) {
//       setState(() {
//         items.add(newItem);
//         listController.clear();
//       });
//     }
//   }

// }
