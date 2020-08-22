import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:todo/helpers/globals.dart';
import 'package:todo/models/user.dart';
import 'package:todo/widgets/home.dart';
import 'package:todo/widgets/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async
{
	runApp(Todo());
}

class Todo extends StatelessWidget
{
	initialData() async
	{
		sharedPreferences = await SharedPreferences.getInstance();

		var initialData = jsonDecode(sharedPreferences.getString("userData"));

		if (initialData != null)
		{
			initialDataPresent = true;
			gUser.init(initialData);
		}
	}

	@override
	Widget build(BuildContext context)
	{
		// Load the shared preferences.
		initialData();
		gUser = User();
		final HttpLink link = HttpLink(uri: "https://vjnvisakh-todo.herokuapp.com/graphql");

		// If initial data is present, load from the shared preference and go to home screen.
		if (initialDataPresent)
		{
			gUser.init(jsonDecode(sharedPreferences.getString("userData")));
		}

		print("initial data is = " + initialDataPresent.toString());

		graphQLClient = ValueNotifier<GraphQLClient>
		(
			GraphQLClient
			(
				cache: InMemoryCache(),
				link: link,
			),
		);

		return GraphQLProvider
		(
			client: graphQLClient,
			child: MaterialApp
			(
				debugShowCheckedModeBanner: false,
				title: "Todo App",
				theme: ThemeData
				(
					primarySwatch: Colors.blue,
					accentColor: Colors.white,
					visualDensity: VisualDensity.adaptivePlatformDensity,
				),
				home: initialDataPresent ? Home() : Splash(),
				routes:
				{
					"home": (context) => Home(),
				},
			)
		);
	}
}