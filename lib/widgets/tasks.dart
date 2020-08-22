
import 'package:flutter/material.dart';
import 'package:todo/helpers/globals.dart';
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

	List<Card> generateTasksWidgets()
	{
		List<Card> cards = [];

		for (int i = 0; i < this.tasks.length; i++)
		{
			var date = DateTime.fromMillisecondsSinceEpoch(int.parse(this.tasks[i].created));

			cards.add
			(
				Card
				(
					margin: EdgeInsets.all(1),
					elevation: 1,
					shadowColor: Colors.grey,
					child: ListTile
					(
						contentPadding: EdgeInsets.only(top: 10, bottom: 10),
						leading: ClipOval
						(
							child: Material
							(
								color: Colors.white,
								child: InkWell
								(
									child: SizedBox(width: 56, height: 56, child: Icon(Icons.check_box_outline_blank, size: 28)),
									onTap: () {},
								),
							),
						),
						subtitle: Column
						(
							crossAxisAlignment: CrossAxisAlignment.start,
							children:
							[
								Text(this.tasks[i].title, style: TextStyle(fontSize: 18, color: Colors.black)),
								Padding(padding: EdgeInsets.only(top:10)),
								Row
								(
									children:
									[
										Icon(Icons.calendar_today, size: 14),
										Text("  " + DateFormat("y-MMM-d").format(date))
									],
								)
							],
						),
						onTap: ()
						{

						},
					)
				)
			);
		}

		return(cards);
	}

	Widget build(BuildContext context)
	{
		return ListView
		(
			controller: taskScrollController,
			physics: BouncingScrollPhysics(),
			addAutomaticKeepAlives: false,
			children: generateTasksWidgets(),
		);
	}
}