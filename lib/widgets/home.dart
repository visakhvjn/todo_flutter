import 'package:flutter/material.dart';
import 'package:todo/helpers/globals.dart';
import 'package:todo/widgets/categories.dart';

class Home extends StatefulWidget
{
	@override
	HomeState createState() => HomeState();
}

class HomeState extends State<Home>
{
	TextEditingController categoryNameController = TextEditingController();
	TextEditingController categoryTypeController = TextEditingController();

	void refresh()
	{
		print("Refreshing");
		print(gUser.categories.length);
		this.setState(()
		{
			print("Refreshing 1");
		});
	}

	@override
	Widget build(BuildContext context)
	{
		return RefreshIndicator
		(
			onRefresh: () async
			{
				refresh();
			},
			child: Scaffold
			(
				body: Container
				(
					width: double.infinity,
					color: Theme.of(context).primaryColor,
					child: Column
					(
						children:
						[
							Container
							(
								height: MediaQuery.of(context).size.height/3.5,
								color: Colors.black,
							),
							Container
							(
								color: Theme.of(context).accentColor,
								width: double.infinity,
								child: Padding
								(
									padding: EdgeInsets.all(10),
									child: Text("Categories", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold))
								)
							),
							Expanded
							(
								child: Container
								(
									color: Theme.of(context).accentColor,
									child: Categories()
								)
							)
						],
					),
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
													controller: categoryNameController,
													decoration: InputDecoration(labelText: "Category Name ..."),
												),
												TextFormField
												(
													controller: categoryTypeController,
													decoration: InputDecoration(labelText: "Type"),
												),
												RaisedButton
												(
													child: Text("Add!"),
													onPressed: () async
													{
														await gUser.addCategory(categoryNameController.text, categoryTypeController.text);
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
				),
			)
		);
	}
}