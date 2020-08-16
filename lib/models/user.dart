import 'package:graphql/client.dart';
import 'package:todo/helpers/globals.dart';
import 'package:todo/helpers/graphql.dart';
import 'package:todo/models/category.dart';

class User
{
	int userId;
	String name;
	List<Category> categories = [];

	Category getCategoryDetails(int categoryId)
	{
		Category category;

		for(int i = 0; i < this.categories.length; i++)
		{
			if (this.categories[i].categoryId == categoryId)
			{
				category = this.categories[i];
				break;
			}
		}

		return(category);
	}

	init(dynamic data)
	{
		this.userId = data["userId"];
		this.name = data["name"];
		this.categories = [];

		for (var i = 0; i < data["categories"].length; i++)
		{
			this.categories.add(Category(data["categories"][i]));
		}
	}

	addCategory(String name, String type) async
	{
		final MutationOptions options = MutationOptions
		(
			documentNode: gql(createCategoryQuery),
			variables:
			{
				"name": name,
				"type": type,
				"userId": gUser.userId
			}
		);

		await graphQLClient.mutate(options).then((result) async => await load());
	}

	addTask(String title, String description, int categoryId, int parentId) async
	{
		final MutationOptions options = MutationOptions
		(
			documentNode: gql(createTaskQuery),
			variables:
			{
				"title": title,
				"description": description,
				"categoryId": categoryId,
				"parentId": parentId,
				"userId": gUser.userId
			}
		);

		await graphQLClient.mutate(options).then((result) => load());
	}

	load() async
	{
		graphQLClient.cache.reset();

		final QueryOptions options = QueryOptions
		(
			documentNode: gql(getUserData)
		);

		await graphQLClient.query(options).then((result)
		{
			print("Called Load");
			var data = result.data["user"];

			print(data["categories"].length.toString());

			this.userId = data["userId"];
			this.name = data["name"];
			this.categories = [];

			for (var i = 0; i < data["categories"].length; i++)
			{
				print(data["categories"][i]["name"]);
				this.categories.add(Category(data["categories"][i]));
			}

			print("New Length " + this.categories.length.toString());
		});
	}

	refresh() async
	{
		print("Getting user profile again!");
		await load();
	}
}