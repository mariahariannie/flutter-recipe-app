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
  
  void _updateCheckboxStatus(Item item) {
    setState(() {
      item.completed = !item.completed;
    });
  }

  void _deleteItem(Item item) {
    setState(() {
      _items.removeWhere((element) => element.name == item.name);
    });
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
            checkboxStatusUpdate: _updateCheckboxStatus,
            removeItem: _deleteItem
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
  final Item item;
  final void Function(Item item) checkboxStatusUpdate;
  final void Function(Item item) removeItem;

  ListItem({
    required this.item,
    required this.checkboxStatusUpdate,
    required this.removeItem
  }) : super(key: ObjectKey(item));

  

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
      onTap: () {
        checkboxStatusUpdate(item);
      },
      leading: Checkbox(
        checkColor: Colors.greenAccent,
        activeColor: Colors.red,
        value: item.completed,
        onChanged: (value) {
          checkboxStatusUpdate(item);
        },
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
          onPressed: () {
            removeItem(item);
          },
        ),
      ]),
    );
  }
}
