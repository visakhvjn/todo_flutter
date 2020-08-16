
import 'package:flutter/material.dart';
import 'package:todo/models/task.dart';
import 'package:intl/intl.dart';

class Tasks extends StatefulWidget
{
	final List<Task> tasks;

	Tasks(this.tasks);

	TasksState createState() => TasksState(this.tasks);
}

class TasksState extends State<Tasks>
{
	List<Card> taskWidgets = [];
	List<Task> tasks = [];

	TasksState(this.tasks);

	Widget build(BuildContext context)
	{

		return ListView.separated
		(
			itemBuilder: (context, index)
			{
				var date = DateTime.fromMillisecondsSinceEpoch(int.parse(this.tasks[index].created));

				return ListTile
				(
					dense: true,
					leading: Icon(Icons.check_circle_outline),
					title: Text(this.tasks[index].title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
					subtitle: Text(this.tasks[index].description, style: TextStyle(fontSize: 15)),
					trailing: Text(DateFormat("y-MMM-d").format(date)),
					onTap: ()
					{

					},
				);
			},
			separatorBuilder: (context, index) => Divider(color: Theme.of(context).primaryColor,),
			itemCount: this.tasks.length
		);
	}
}