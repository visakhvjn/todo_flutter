import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:todo/helpers/globals.dart';
import 'package:todo/helpers/graphql.dart';

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

	void initState()
	{
		super.initState();
		loadIntialUserData();
	}

	void loadIntialUserData() async
	{
		final QueryOptions options = QueryOptions
		(
			documentNode: gql(getUserData)
		);

		await graphQLClient.query(options).then((result)
		{
			gUser.init(result.data["user"]);
			Navigator.pushReplacementNamed(context, "home");
		});
	}

	Widget build(BuildContext context)
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
							Divider(),
							Text("Loading User Data", style: TextStyle(color: Theme.of(context).accentColor)),
							Padding(padding: EdgeInsets.all(10)),
							CircularProgressIndicator(),
						]
					)
				)
			)
		);
	}
}