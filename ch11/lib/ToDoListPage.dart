import 'dart:html';
import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import 'package:flutter/material.dart';
import 'ToDo.dart';
class ToDoListPage extends StatefulWidget {
  const ToDoListPage({super.key});

  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  final _items = <ToDo>[];
  var _toDocontroller = TextEditingController();

  void dispose(){
    _toDocontroller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            " 남은 할 일  "
        ),
        backgroundColor: Colors.black,
      ),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _toDocontroller,
                  ),
                ),
                ElevatedButton(onPressed: ()=>_addTodo(ToDo(_toDocontroller.text)),
                    child:
                    Text('추가')
                )
              ],
            ),
            StreamBuilder<QureySnapshot>(
                stream: FirebaseFirestore.instanc.collection('todo2').snapshot(),
                builder: (context, snapshot){
                  if(!snapshot.hasData){
                    return CircularProgressIndicator();
                  }
                  final documents = snapshot.data!.docs;


                  return Expanded(
                    child: ListView(
                      children: documents.map((doc)=> _buildItemWidget(doc)).toList(),
                    ),
                  );
                }
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildItemWidget(DacumentSnapshot doc){
    final todo = ToDo(doc['title'],isDone: doc['isDone']);
    return ListTile(
      onTap: ()=>_toggleToDo(doc),
      title: Text(
        todo.title,
        style: todo.isDone
            ? TextStyle(
          decoration: TextDecoration.lineThrough,
          fontStyle: FontStyle.italic,
        )
            : null,
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete_forever),
        onPressed: ()=> _deleteToDo(doc),
      ),
    );
  }

  void _addTodo(ToDo todo){
    FirebaseFirestore.instance.collection('todo')
        .add({'title':todo.title,'isDone': todo.isDone});
    _toDocontroller.text='';
  }
  void _deleteToDo(DocumentSnapshot doc){
    FirebaseFirestore.instance.collection('todo').doc(doc.id).delete();
  }
  void _toggleToDo(DocumentShapshot doc){
    FirebaseFirestore.instance.collection('todo').doc(doc.id).
    update({'isDone': !doc['isDOne']}
    );
  }
}
}