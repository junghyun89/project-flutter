import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker_app/models/task_model.dart';
import 'package:habit_tracker_app/screens/task_editor.dart';
import 'package:habit_tracker_app/widgets/my_list_tile.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "My Habit App",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: ValueListenableBuilder<Box<Task>>(
        valueListenable: Hive.box<Task>("tasks").listenable(),
        builder: (context, box, _) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Today's Task",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  formatDate(
                    DateTime.now(),
                    [M, " ", d, ", ", yyyy],
                  ),
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 18,
                  ),
                ),
                const Divider(
                  height: 40,
                  thickness: 1,
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      Task currentTask = box.getAt(index)!;
                      return MyListTile(
                        task: currentTask,
                        index: index,
                      );
                    },
                    itemCount: box.values.length,
                  ),
                )
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskEditor(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
