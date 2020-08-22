import 'dart:convert';

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
	String categoryTypeValue = "private";

	bool showAddCategoryContainer = false;

	void refresh()
	{
		print("Refreshing");
		print(gUser.categories.length);
		this.setState(()
		{
			print("Refreshing 1");
		});

		// gUser.initializeUser();
	}

	void saveToSharedPreference() async
	{
		await sharedPreferences.setString("userData", jsonEncode(gUser.data));
	}

	addCategory(String name, String type) async
	{
		// final MutationOptions options = MutationOptions
		// (
		// 	documentNode: gql(createCategoryQuery),
		// 	variables:
		// 	{
		// 		"name": name,
		// 		"type": type,
		// 		"userId": gUser.userId
		// 	},
		// 	fetchPolicy: FetchPolicy.noCache
		// );

		// await graphQLClient.mutate(options).then((result)
		// {
		// 	var newCategory = result.data["createCategory"];

		// 	gUser.categories.add(Category(newCategory));

		// 	this.setState(() {});
		// });
	}

	@override
	Widget build(BuildContext context)
	{
		saveToSharedPreference();

		return RefreshIndicator
		(
			onRefresh: () async
			{
				refresh();
			},
			child: SafeArea(child: Scaffold
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
								padding: EdgeInsets.all(5),
								height: MediaQuery.of(context).size.height/3.5,
								width: double.infinity,
								color: Colors.white,
								child: Card
								(

								),
							),
							Expanded
							(
								child: Container
								(
									padding: EdgeInsets.only(left:7, right: 7, top: 5),
									color: Colors.white,
									child: Categories()
								)
							)
						],
					),
				),
				floatingActionButton: FloatingActionButton
				(
					child: Icon(Icons.add),
					backgroundColor: Theme.of(context).primaryColor,
					foregroundColor: Theme.of(context).accentColor,
					onPressed: ()
					{
						categoryNameController.text = "";
						categoryTypeValue = "private";

						return showDialog
						(
							context: context,
							builder: (BuildContext context)
							{
								return Center(child:Container
								(
									child: AlertDialog
									(
										title: Text("New Category", style: TextStyle(fontWeight: FontWeight.bold)),
										content: Column
										(
											crossAxisAlignment: CrossAxisAlignment.start,
											children:
											[
												Text("A Category allows you to group your tasks together."),
												Padding(padding: EdgeInsets.all(10)),
												Text("Name", style: TextStyle(fontWeight: FontWeight.bold)),
												TextFormField
												(
													controller: categoryNameController,
													autofocus: true,
												),
												Padding(padding: EdgeInsets.all(10)),
												Text("Type", style: TextStyle(fontWeight: FontWeight.bold)),
												Container
												(
													width: double.infinity,
													child: DropdownButton
													(
														hint: Text("Type"),
														value: categoryTypeValue,
														items:
														[
															DropdownMenuItem(child: Text("Private"), value: "private"),
															DropdownMenuItem(child: Text("Public"), value: "public"),
														],
														onChanged: (value)
														{
															setState(()
															{
																categoryTypeValue = value;
															});
														}
													)
												),
												Padding(padding: EdgeInsets.all(10)),
												Container
												(
													width: double.infinity,
													child: RaisedButton
													(
														color: Theme.of(context).primaryColor,
														textColor: Theme.of(context).accentColor,
														padding: EdgeInsets.all(15),
														child: Text("Add Category"),
														onPressed: () async
														{
															this.addCategory(categoryNameController.text, categoryTypeController.text);
															Navigator.pop(context);
														}
													)
												),
												Padding(padding: EdgeInsets.all(10)),
												Text("Public groups are visible to anyone who is following you.", style: TextStyle(fontSize: 15)),
											],
										),
									)
								));
							}
						);
					}
				),
			)
		));
	}
}