import 'package:flutter/material.dart';
import 'package:todo/helpers/globals.dart';
import 'package:todo/models/user.dart';
import 'package:todo/widgets/category_tasks.dart';
import 'package:todo/widgets/home.dart';
import 'package:todo/widgets/splash.dart';

void main()
{
	gUser = User();
	runApp(Todo());
}

class Todo extends StatelessWidget
{
	@override
	Widget build(BuildContext context)
	{
		return MaterialApp
		(
			debugShowCheckedModeBanner: false,
			title: "Todo App",
			theme: ThemeData
			(
				primarySwatch: Colors.blue,
				accentColor: Colors.white,
				visualDensity: VisualDensity.adaptivePlatformDensity,
			),
			home: Splash(),
			routes:
			{
				"home": (context) => Home(),
				"category": (context) => CategoryTasks()
			},
		);
	}
}