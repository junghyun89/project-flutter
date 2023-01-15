import 'package:flutter/material.dart';
import 'package:habit_tracker_app/models/task_model.dart';
import 'package:habit_tracker_app/screens/home.dart';
import 'package:hive/hive.dart';

class TaskEditor extends StatefulWidget {
  Task? task;
  TaskEditor({super.key, this.task});

  @override
  State<TaskEditor> createState() => _TaskEditorState();
}

class _TaskEditorState extends State<TaskEditor> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController taskTitle = TextEditingController(
      text: widget.task == null ? null : widget.task!.title!,
    );
    final TextEditingController taskNote = TextEditingController(
      text: widget.task == null ? null : widget.task!.note!,
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          widget.task == null ? 'Add a new Task' : 'Update your Task',
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Your Task's Title",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            TextField(
              controller: taskTitle,
              decoration: InputDecoration(
                fillColor: Colors.grey.shade300.withAlpha(75),
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8),
                ),
                hintText: 'Your Task',
                hintStyle: TextStyle(
                  color: Colors.grey.shade500,
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              "Your Task's Note",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            TextField(
              keyboardType: TextInputType.multiline,
              minLines: 5,
              maxLines: 25,
              controller: taskNote,
              decoration: InputDecoration(
                fillColor: Colors.grey.shade300.withAlpha(75),
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8),
                ),
                hintText: 'Write some Notes',
                hintStyle: TextStyle(
                  color: Colors.grey.shade500,
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: RawMaterialButton(
                    onPressed: () {
                      submitTask(taskTitle, taskNote);
                    },
                    fillColor: Colors.blueAccent.shade400,
                    child: Text(
                      widget.task == null ? "Add new Task" : "Update Task",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void submitTask(
    TextEditingController taskTitle,
    TextEditingController taskNote,
  ) async {
    var newTask = Task(
      title: taskTitle.text,
      note: taskNote.text,
      creating_date: DateTime.now(),
      done: false,
    );
    Box<Task> taskbox = Hive.box<Task>("tasks");
    if (widget.task != null) {
      widget.task!.title = newTask.title;
      widget.task!.note = newTask.note;
      widget.task!.save();
    } else {
      await taskbox.add(newTask);
    }
    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  }
}
