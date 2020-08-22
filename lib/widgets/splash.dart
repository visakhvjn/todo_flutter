import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:todo/helpers/globals.dart';
import 'package:todo/helpers/graphql.dart';
import 'package:todo/models/category.dart';
import 'package:todo/widgets/home.dart';

class Splash extends StatefulWidget
{
	SplashState createState()
	{
		return(SplashState());
	}
}

class SplashState extends State<Splash>
{
	var loaderVisible = true;
	bool showSplash = true;

	loadInitialData() async
	{
		return Query
		(
			options: QueryOptions
			(
				documentNode: gql(getUserData),
				fetchPolicy: FetchPolicy.noCache
			),
			builder: (QueryResult result, { VoidCallback refetch, FetchMore fetchMore })
			{
				if (result.loading)
				{
					return splash();
				}
				else
				{
					var data = result.data["user"];

					gUser.userId = data["userId"];
					gUser.name = data["name"];
					gUser.categories = [];
					gUser.data = data;

					for (var i = 0; i < data["categories"].length; i++)
					{
						gUser.categories.add(Category(data["categories"][i]));
					}

					return Home();
				}
			},
		);
	}

	Widget splash()
	{
		return Scaffold
		(
			body: Center
			(
				child: Container
				(
					width: double.infinity,
					color: Theme.of(context).primaryColor,
					child: Column
					(
						mainAxisAlignment: MainAxisAlignment.center,
						children:
						[
							Icon(Icons.track_changes, size: 150),
							Text("Task Manager", style: TextStyle(fontSize: 30)),
							Text("Loading User Data", style: TextStyle(color: Theme.of(context).accentColor)),
							Padding(padding: EdgeInsets.all(10)),
							CircularProgressIndicator(),
						]
					)
				)
			)
		);
	}

	Widget build(BuildContext context)
	{
		// return splash();
		return loadInitialData();
	}
}