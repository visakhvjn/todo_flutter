import 'dart:convert';
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
	var loaderVisible = true;

	void initState()
	{
		super.initState();
		getUserCategories();
	}

	void getUserCategories() async
	{
		final QueryOptions options = QueryOptions
		(
			documentNode: gql(getUserData),
		);

		final QueryResult result = await graphQLClient.query(options);
		final response = jsonDecode(result.data);

		print(response);

		print(result.data);
		print(result.loading);

		// gUser = responseJSON.user;

		if (!result.loading)
		{
			setState(()
			{
				loaderVisible = false;
			});

			Navigator.pushReplacementNamed(context, "home");
		}
	}

	Widget build(BuildContext context)
	{
		return CircularProgressIndicator();
	}
}