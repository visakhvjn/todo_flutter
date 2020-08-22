import 'package:todo/helpers/globals.dart';
import 'package:todo/models/category.dart';

class User
{
	int userId;
	String name;
	List<Category> categories = [];
	var data;

	Category getCategoryDetails(int categoryId)
	{
		Category category;

		for(int i = 0; i < this.categories.length; i++)
		{
			if (this.categories[i].categoryId == categoryId)
			{
				category = this.categories[i];
				selectedCategoryIndex = i;
				break;
			}
		}

		return(category);
	}

	removeCategory(int categoryId)
	{
		if (gUser.categories[selectedCategoryIndex].categoryId == categoryId)
		{
			gUser.categories[selectedCategoryIndex].status = "deleted";
		}
	}

	// initializeUser()
	// {
	// 	final QueryOptions options = QueryOptions
	// 	(
	// 		documentNode: gql(getUserData),
	// 		fetchPolicy: FetchPolicy.noCache
	// 	);

	// 	print("Fetching user data");

	// 	graphQLClient.query(options).then((result)
	// 	{
	// 		print("Fetched user data");
	// 		gUser.init(result.data["user"]);
	// 	});
	// }

	init(dynamic data)
	{
		this.data = data;
		this.userId = data["userId"];
		this.name = data["name"];
		this.categories = [];

		for (var i = 0; i < data["categories"].length; i++)
		{
			this.categories.add(Category(data["categories"][i]));
		}
	}

	// addCategory(String name, String type) async
	// {
	// 	final MutationOptions options = MutationOptions
	// 	(
	// 		documentNode: gql(createCategoryQuery),
	// 		variables:
	// 		{
	// 			"name": name,
	// 			"type": type,
	// 			"userId": gUser.userId
	// 		},
	// 		fetchPolicy: FetchPolicy.noCache
	// 	);

	// 	await graphQLClient.mutate(options);
	// }

	// addTask(String title, String description, int categoryId, int parentId) async
	// {
	// 	final MutationOptions options = MutationOptions
	// 	(
	// 		documentNode: gql(createTaskQuery),
	// 		variables:
	// 		{
	// 			"title": title,
	// 			"description": description,
	// 			"categoryId": categoryId,
	// 			"parentId": parentId,
	// 			"userId": gUser.userId
	// 		},
	// 		fetchPolicy: FetchPolicy.noCache
	// 	);

	// 	await graphQLClient.mutate(options);
	// }

	// load() async
	// {
	// 	final QueryOptions options = QueryOptions
	// 	(
	// 		documentNode: gql(getUserData),
	// 		fetchPolicy: FetchPolicy.noCache
	// 	);

	// 	await graphQLClient.query(options).then((result)
	// 	{
	// 		print("Called Load");
	// 		var data = result.data["user"];

	// 		print(data["categories"].length.toString());

	// 		this.userId = data["userId"];
	// 		this.name = data["name"];
	// 		this.categories = [];

	// 		for (var i = 0; i < data["categories"].length; i++)
	// 		{
	// 			print(data["categories"][i]["name"]);
	// 			this.categories.add(Category(data["categories"][i]));
	// 		}

	// 		print("New Length " + this.categories.length.toString());
	// 	});
	// }

	refresh() async
	{
		print("Getting user profile again!");
		// await load();
	}
}