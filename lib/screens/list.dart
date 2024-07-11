import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoList extends StatelessWidget {
  const TodoList({
    super.key,
    required this.taskName,
    required this.description,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
  });

  final String taskName;
  final String description;
  final bool taskCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
        bottom: 0,
      ),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(15),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 233, 233, 233),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Checkbox(
                value: taskCompleted,
                onChanged: onChanged,
                checkColor: Colors.deepPurple,
                activeColor: Colors.white,
                side: const BorderSide(
                  color: Colors.deepPurple,
                ),
              ),
              Column(
                children: [
                  Text(
                taskName,
                style: TextStyle(
                  color: Color.fromARGB(255, 20, 19, 19),
                  fontSize: 18,
                  decoration: taskCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  decorationColor: Color.fromARGB(255, 20, 19, 19),
                  decorationThickness: 2,
                ),
              ),
              Text(
                description,
                 style: TextStyle(
                  color: Color.fromARGB(255, 51, 50, 50),
                  fontSize: 12,
                ),
              ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}