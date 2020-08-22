import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/helpers/globals.dart';
import 'package:todo/widgets/tasks.dart';

class CategoryTasks extends StatefulWidget
{
	CategoryTasks(this.categoryId);

	final int categoryId;

	CategoryTasksState createState() => CategoryTasksState(this.categoryId);
}

class CategoryTasksState extends State<CategoryTasks>
{
	CategoryTasksState(this.categoryId);

	final int categoryId;
	bool showNewTaskField = false;
	bool showSortOptions = false;

	void initState()
	{
		super.initState();
		print("initing");
	}

	void didUpdateWidget(CategoryTasks oldWidget)
	{
		super.didUpdateWidget(oldWidget);
		print("am i called?");
	}

	void refresh()
	{
		print("Refreshing");
		this.setState(()
		{
			print("Refreshing 1");
		});
	}

	addTask(String title, String description, int categoryId, int parentId)
	{
		// final MutationOptions options = MutationOptions
		// (
		// 	documentNode: gql(createTaskQuery),
		// 	variables:
		// 	{
		// 		"title": title,
		// 		"description": description,
		// 		"categoryId": categoryId,
		// 		"parentId": parentId,
		// 		"userId": gUser.userId
		// 	},
		// 	fetchPolicy: FetchPolicy.noCache
		// );

		// graphQLClient.mutate(options).then((result)
		// {
		// 	print("task added");
		// 	print(result.data);
		// 	var newTask = result.data["createTask"];

		// 	gUser.categories[selectedCategoryIndex].tasks.add(Task(newTask));

		// 	taskScrollController.animateTo(taskScrollController.position.maxScrollExtent, duration: Duration(milliseconds: 300), curve: Curves.easeIn);

		// 	this.setState(() {});
		// });
	}

	deleteCategory()
	{
		// gUser.removeCategory(this.categoryId);

		// print("User Id" + gUser.userId.toString());
		// print("CateogryId" + categoryId.toString());

		// final MutationOptions options = MutationOptions
		// (
		// 	documentNode: gql(removeCategory),
		// 	variables:
		// 	{
		// 		"userId": gUser.userId,
		// 		"categoryId": categoryId
		// 	},
		// 	fetchPolicy: FetchPolicy.noCache
		// );

		// graphQLClient.mutate(options);
	}

	Widget build(BuildContext context)
	{
		final categoryDetails = gUser.getCategoryDetails(categoryId);
		final categoryCreatedDate = DateTime.fromMillisecondsSinceEpoch(int.parse(categoryDetails.created));

		TextEditingController taskTitleController = TextEditingController();
		taskScrollController = ScrollController();

		return WillPopScope
		(
			child: Scaffold
			(
				body: SafeArea
				(
					child: Container
					(
						color: Colors.white,
						width: double.infinity,
						child: Column
						(
							mainAxisAlignment: MainAxisAlignment.start,
							children:
							[
								Container
								(
									width: double.infinity,
									height: 220,
									child: Container
									(
										padding: EdgeInsets.all(20),
										child: Column
										(
											crossAxisAlignment: CrossAxisAlignment.start,
											children:
											[
												Padding(padding: EdgeInsets.only(top:10)),
												Text(" " + categoryDetails.type + " ", style: TextStyle(fontSize: 18, color: Colors.black, backgroundColor: Colors.yellow)),
												Padding(padding: EdgeInsets.only(top:5)),
												Text(categoryDetails.name, style: TextStyle(fontSize: 50)),
												Row
												(
													mainAxisAlignment: MainAxisAlignment.start,
													children:
													[
														Padding(padding: EdgeInsets.only(left: 10)),
														Text(DateFormat("y-MMM-d").format(categoryCreatedDate), style: TextStyle(fontSize: 15)),
														Padding(padding: EdgeInsets.only(left: 10)),
														Text("Tasks " + categoryDetails.tasks.length.toString()),
													],
												),
												Row
												(
													mainAxisAlignment: MainAxisAlignment.start,
													children:
													[
														IconButton(icon: Icon(Icons.print), onPressed: () {}),
														IconButton
														(
															icon: Icon(Icons.delete),
															onPressed: ()
															{
																return showDialog
																(
																	context: context,
																	builder: (BuildContext context)
																	{
																		return Center(child:Container
																		(
																			height: 280,
																			child: AlertDialog
																			(
																				title: Text("Delete Category", style: TextStyle(fontWeight: FontWeight.bold)),
																				content: Column
																				(
																					crossAxisAlignment: CrossAxisAlignment.start,
																					children:
																					[
																						Text("The category has " + categoryDetails.tasks.length.toString() + " tasks in it. Removing the category will remove the tasks as well.", style: TextStyle(fontSize: 15)),
																						Padding(padding: EdgeInsets.only(top: 20)),
																						Row
																						(
																							mainAxisAlignment: MainAxisAlignment.end,
																							children:
																							[
																								FlatButton
																								(
																									color: Theme.of(context).primaryColor,
																									textColor: Colors.white,
																									child: Text("Confirm"),
																									onPressed: ()
																									{
																										deleteCategory();
																										Navigator.pushReplacementNamed(context, "home");
																									},
																								),
																								Padding(padding: EdgeInsets.only(left: 10)),
																								FlatButton
																								(
																									color: Colors.grey,
																									textColor: Colors.white,
																									child: Text("Cancel"),
																									onPressed: () 
																									{
																										Navigator.pop(context);
																									},
																								)
																							]
																						)
																					],
																				),
																			)
																		));
																	}
																);
															}
														),
														IconButton
														(
															icon: Icon(Icons.sort), 
															onPressed: ()
															{
																setState(()
																{
																	showSortOptions = !showSortOptions;
																});
															}
														)
													],
												),
											]
										)
									),
								),
								Expanded
								(
									child: Container
									(
										padding: EdgeInsets.only(left: 5, right: 5),
										color: Theme.of(context).accentColor,
										child: Tasks(categoryDetails.tasks),
									)
								),
								showNewTaskField == true ? Container
								(
									decoration: BoxDecoration
									(
										color: Colors.white,
										boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2.0)]
									),
									padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 20),
									width: double.infinity,
									child: Row
									(
										mainAxisAlignment: MainAxisAlignment.start,
										children:
										[
											Expanded(child: TextField
											(
												controller: taskTitleController,
												autofocus: true,
												decoration: InputDecoration
												(
													hintText: "Add Task"
												),
											)),
											IconButton
											(
												icon: Icon(Icons.add_box, size: 40),
												onPressed: ()
												{
													print("asd");
													this.addTask(taskTitleController.text, "", categoryId, 0);
													setState(()
													{
														showNewTaskField = false;
													});
												}
											)
										],
									)
									// child: Column
									// (
									// 	crossAxisAlignment: CrossAxisAlignment.start,
									// 	children:
									// 	[
									// 		TextField
									// 		(
									// 			autofocus: true,
									// 			decoration: InputDecoration
									// 			(
									// 				hintText: "Add Task"
									// 			),
									// 		)
									// 	],
									// ),
								) : SizedBox.shrink(),
								showSortOptions == true && showNewTaskField == false ? Container
								(
									height: 200,
									decoration: BoxDecoration
									(
										borderRadius: BorderRadius.only
										(
											topRight: Radius.circular(12.0),
											topLeft: Radius.circular(12.0),
										),
										color: Colors.white,
										boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2.0)]
									),
									padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 20),
									width: double.infinity,
									child: ListView
									(
										children:
										[
											ListTile(leading: Icon(Icons.sort_by_alpha), title: Text("Alphabetically")),
											ListTile(leading: Icon(Icons.calendar_today), title: Text("Creation Date")),
											ListTile(leading: Icon(Icons.star_border), title: Text("Importance")),
										],
									),
								): SizedBox.shrink()
							],
						),
					)
				),
				floatingActionButton: (showNewTaskField == false && showSortOptions == false) ? FloatingActionButton
				(
					child: Icon(Icons.add),
					backgroundColor: Theme.of(context).primaryColor,
					foregroundColor: Theme.of(context).accentColor,
					onPressed: ()
					{
						print("Clicking this!");
						setState(()
						{
							showNewTaskField = true;
						});
						// return showDialog
						// (
						// 	useSafeArea: true,
						// 	context: context,
						// 	builder: (BuildContext context)
						// 	{
						// 		return Container
						// 		(
						// 			height: 200,
						// 			child: AlertDialog
						// 			(
						// 				title: Text("New Category"),
						// 				content: Column
						// 				(
						// 					children:
						// 					[
						// 						TextFormField
						// 						(
						// 							controller: taskTitleController,
						// 							decoration: InputDecoration(labelText: "Task Title ..."),
						// 						),
						// 						TextFormField
						// 						(
						// 							controller: taskDescriptionController,
						// 							decoration: InputDecoration(labelText: "Task Description"),
						// 						),
						// 						RaisedButton
						// 						(
						// 							child: Text("Add!"),
						// 							onPressed: () async
						// 							{
						// 								await gUser.addTask(taskTitleController.text, taskDescriptionController.text, categoryId, 0);

						// 								// refresh();

						// 								Navigator.pop(context);
						// 							}
						// 						)
						// 					],
						// 				),
						// 			)
						// 		);
						// 	}
						// );
					}
				): SizedBox.shrink()
			),
			onWillPop: () async
			{
				if (showNewTaskField == true || showSortOptions == true)
				{
					setState(()
					{
						showNewTaskField = false;
						showSortOptions = false;
					});

					return(false);
				}
				else
				{
					return(true);
				}
			}
		);
	}
}