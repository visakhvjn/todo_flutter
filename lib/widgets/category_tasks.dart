import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/helpers/globals.dart';
import 'package:todo/widgets/tasks.dart';

class CategoryTasks extends StatefulWidget
{
	CategoryTasksState createState() => CategoryTasksState();
}

class CategoryTasksState extends State<CategoryTasks>
{
	void refresh()
	{
		print("Refreshing");
		this.setState(()
		{
			print("Refreshing 1");
		});
	}

	Widget build(BuildContext context)
	{
		final Map arguments = ModalRoute.of(context).settings.arguments as Map;
		final categoryId = arguments["categoryId"];
		final categoryDetails = gUser.getCategoryDetails(categoryId);
		final categoryCreatedDate = DateTime.fromMillisecondsSinceEpoch(int.parse(categoryDetails.created));

		TextEditingController taskTitleController = TextEditingController();
		TextEditingController taskDescriptionController = TextEditingController();

		return Scaffold
		(
			body: SafeArea
			(
				child: Container
				(
					width: double.infinity,
					color: Colors.pink,
					child: Column
					(
						mainAxisAlignment: MainAxisAlignment.start,
						children:
						[
							Container
							(
								width: double.infinity,
								height: MediaQuery.of(context).size.height/4,
								color: Colors.white,
								child: Container
								(
									color: Theme.of(context).primaryColor,
									padding: EdgeInsets.all(20),
									child: Column
									(
										crossAxisAlignment: CrossAxisAlignment.start,
										children:
										[
											Text(" " + categoryDetails.type + " ", style: TextStyle(fontSize: 18, color: Colors.black, backgroundColor: Colors.yellow)),
											Text(categoryDetails.name, style: TextStyle(fontSize: 50)),
											Text(DateFormat("y-MMM-d").format(categoryCreatedDate), style: TextStyle(fontSize: 15, color: Colors.white))
										]
									)
								),
							),
							Container
							(
								color: Theme.of(context).accentColor,
								width: double.infinity,
								child: Padding
								(
									padding: EdgeInsets.all(10),
									child: Text("Tasks", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold))
								)
							),
							Expanded
							(
								child: Container
								(
									padding: EdgeInsets.all(10),
									color: Theme.of(context).accentColor,
									child: Tasks(categoryDetails.tasks),
								)
							)
						],
					),
				)
			),
			floatingActionButton: FloatingActionButton
			(
				child: Icon(Icons.add),
				backgroundColor: Theme.of(context).accentColor,
				onPressed: ()
				{
					return showDialog
					(
						useSafeArea: true,
						context: context,
						builder: (BuildContext context)
						{
							return Container
							(
								height: 200,
								child: AlertDialog
								(
									title: Text("New Category"),
									content: Column
									(
										children:
										[
											TextFormField
											(
												controller: taskTitleController,
												decoration: InputDecoration(labelText: "Task Title ..."),
											),
											TextFormField
											(
												controller: taskDescriptionController,
												decoration: InputDecoration(labelText: "Task Description"),
											),
											RaisedButton
											(
												child: Text("Add!"),
												onPressed: ()
												{
													gUser.addTask(taskTitleController.text, taskDescriptionController.text, categoryId, 0);

													refresh();

													Navigator.pop(context);
												}
											)
										],
									),
								)
							);
						}
					);
				}
			)
		);
	}
}