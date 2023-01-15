import 'package:flutter/material.dart';
import 'package:habit_tracker_app/models/task_model.dart';
import 'package:habit_tracker_app/screens/task_editor.dart';

class MyListTile extends StatefulWidget {
  Task task;
  int index;
  MyListTile({super.key, required this.task, required this.index});

  @override
  State<MyListTile> createState() => _MyListTileState();
}

class _MyListTileState extends State<MyListTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 12,
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            Expanded(
              child: Text(
                widget.task.title!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                updateTask();
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.green,
              ),
            ),
            IconButton(
              onPressed: () {
                deleteTask();
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            )
          ],
        ),
        const Divider(
          color: Colors.black87,
          height: 20,
          thickness: 1,
        ),
        Text(
          widget.task.note!,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ]),
    );
  }

  void updateTask() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskEditor(
          task: widget.task,
        ),
      ),
    );
  }

  void deleteTask() {
    widget.task.delete();
  }
}
