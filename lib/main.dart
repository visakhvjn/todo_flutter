import 'package:flutter/material.dart';
import 'package:todo/widgets/home.dart';
import 'package:todo/widgets/splash.dart';

void main()
{
	runApp(Todo());
}

class Todo extends StatelessWidget
{
	@override
	Widget build(BuildContext context)
	{
		return MaterialApp
		(
			title: "Todo App",
			theme: ThemeData
			(
				primarySwatch: Colors.blue,
				visualDensity: VisualDensity.adaptivePlatformDensity,
			),
			home: Splash(),
			routes:
			{
				"home": (context) => Home()
			},
		);
	}
}