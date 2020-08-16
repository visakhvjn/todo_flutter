

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/helpers/globals.dart';

class Categories extends StatefulWidget
{
	CategoriesState createState() => CategoriesState();
}

class CategoriesState extends State<Categories>
{
	Widget build(BuildContext context)
	{
		print("Categories refresh");

		return ListView.separated
		(
			itemBuilder: (context, index)
			{
				var date = DateTime.fromMillisecondsSinceEpoch(int.parse(gUser.categories[index].created));

				return ListTile
				(
					dense: true,
					leading: gUser.categories[index].type == "private" ? Icon(Icons.person, color: Theme.of(context).primaryColor) : Icon(Icons.public, color: Theme.of(context).primaryColor),
					title: Text(gUser.categories[index].name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
					subtitle: Text(DateFormat("y-MMM-d").format(date)),
					trailing: Text(gUser.categories[index].count.toString()),
					onTap: ()
					{
						Navigator.pushNamed(context, "category", arguments: {"categoryId": gUser.categories[index].categoryId});
					},
				);
			},
			separatorBuilder: (context, index) => Divider(color: Theme.of(context).primaryColor),
			itemCount: gUser.categories.length
		);
	}
}