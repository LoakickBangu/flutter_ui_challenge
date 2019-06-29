import 'package:flutter/material.dart';
import 'models.dart';

class TaskRow extends StatelessWidget {
  final Task task;
  final Animation<double> animation;
  final double dotSize = 12.0;

  TaskRow({Key key, this.task, this.animation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: SizeTransition(
        sizeFactor: animation,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: _buildContent(),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32 - dotSize / 2),
          child: Container(
            width: dotSize,
            height: dotSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: task.color,
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(task.name, style: TextStyle(fontSize: 18)),
              Text(task.category,
                  style: TextStyle(fontSize: 12, color: Colors.grey))
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 16),
          child: Text(task.time,
              style: TextStyle(fontSize: 12, color: Colors.grey)),
        )
      ],
    );
  }
}
