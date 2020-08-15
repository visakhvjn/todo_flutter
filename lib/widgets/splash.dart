import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
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
	void initState()
	{
		super.initState();
		getUserCategories();
	}

	void getUserCategories() async
	{
		final QueryOptions options = QueryOptions
		(
			documentNode: gql(getUserCategoriesQuery),
		);

		final QueryResult result = await graphQLClient.query(options);

		print(result.data);
	}

	Widget build(BuildContext context)
	{
		return Container
		(
			color: Theme.of(context).primaryColor,
			child: Text("Loading")
		);
	}
}