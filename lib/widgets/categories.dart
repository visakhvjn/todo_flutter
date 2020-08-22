

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/helpers/globals.dart';
import 'package:todo/helpers/slide_left.dart';
import 'package:todo/widgets/category_tasks.dart';

class Categories extends StatefulWidget
{
	CategoriesState createState() => CategoriesState();
}

class CategoriesState extends State<Categories>
{
	List<Card> generateCategoryWidgets()
	{
		List<Card> categoryWidgets = [];

		for (int i = 0; i < gUser.categories.length; i++)
		{
			if (gUser.categories[i].status == "deleted")
			{
				continue;
			}

			var date = DateTime.fromMillisecondsSinceEpoch(int.parse(gUser.categories[i].created));
			String description = "Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old";
			String type = gUser.categories[i].type;

			categoryWidgets.add
			(
				Card
				(
					margin: EdgeInsets.all(1),
					shadowColor: Colors.grey,
					elevation: 2,
					child: ListTile
					(
						subtitle: Column
						(
							crossAxisAlignment: CrossAxisAlignment.start,
							children:
							[
								Padding(padding: EdgeInsets.only(top: 10)),
								Row
								(
									children:
									[
										type == "private" ? Icon(Icons.account_circle) : Icon(Icons.public),
										Text(" " + gUser.categories[i].name, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
									],
								),
								Padding(padding: EdgeInsets.only(top: 5)),
								description != "" ? Text(description, style: TextStyle(fontSize: 13)) : SizedBox.shrink(),
								Padding(padding: EdgeInsets.only(top: 10)),
								Text(DateFormat("y-MMM-d").format(date), style: TextStyle(fontWeight: FontWeight.bold)),
								Padding(padding: EdgeInsets.only(bottom: 10))
							]
						),
						trailing: Text(gUser.categories[i].count.toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
						onTap: ()
						{
							Navigator.push(context, SlideLeftRoute(widget: CategoryTasks(gUser.categories[i].categoryId)));
						}
					)
				)
			);
		}

		return(categoryWidgets);
	}

	Widget build(BuildContext context)
	{
		print("Categories refresh 00");

		return ListView
		(
			physics: BouncingScrollPhysics(),
			addAutomaticKeepAlives: false,
			children: generateCategoryWidgets()
		);
	}
}