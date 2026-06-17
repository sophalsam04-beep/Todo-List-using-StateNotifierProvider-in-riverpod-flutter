import 'package:self_learning7/model/todo_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:self_learning7/state/todo_notifier.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todo = ref.watch(todoProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Todo List", style: TextStyle(fontSize: 30))),

      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(25),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      labelText: "Enter todo",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20, width: 20),

                ElevatedButton(
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      ref.read(todoProvider.notifier).addTodo(controller.text);

                      controller.clear();
                    }
                  },
                  child: Text("Add"),
                ),
              ],
            ),
          ),

          // showing the result
          Expanded(
            child: ListView.builder(
              itemCount: todo.length,
              itemBuilder: (context, index) {
                final tod = todo[index];

                return ListTile(
                  leading: Checkbox(
                    value: tod.isCompleted,
                    onChanged: (value) {
                      ref.read(todoProvider.notifier).toggleCompleted(tod.id);
                    },
                  ),

                  title: Text(
                    tod.name,
                    style: TextStyle(
                      decoration: tod.isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),

                  trailing: IconButton(
                    onPressed: () {
                      ref.read(todoProvider.notifier).deleteTodo(tod.id);
                    },
                    icon: Icon(Icons.delete),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
