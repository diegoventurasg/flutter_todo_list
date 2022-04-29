import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../models/todo.dart';

class TodoListItem extends StatelessWidget {
  const TodoListItem({
    Key? key,
    required this.todo,
    required this.onDelete,
  }) : super(key: key);

  final Todo todo;
  final Function(Todo) onDelete;

  @override
  Widget build(BuildContext context) {
    late final BuildContext _contextItem;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: MouseRegion(
        onEnter: (e) {
          final slidable = Slidable.of(_contextItem);
          slidable?.openEndActionPane();
        },
        onExit: (e) {
          final slidable = Slidable.of(_contextItem);
          slidable?.close();
        },
        child: Slidable(
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            extentRatio: 0.3,
            children: [
              SlidableAction(
                onPressed: (_) {
                  onDelete(todo);
                },
                backgroundColor: Colors.red,
                icon: Icons.delete,
                label: 'Deletar',
              ),
            ],
          ),
          child: Builder(builder: (context) {
            _contextItem = context;
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.grey,
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    DateFormat('dd/MM/yyyy - HH:mm').format(todo.date),
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    todo.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
