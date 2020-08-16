import 'package:graphql/client.dart';

final GraphQLClient graphQLClient = GraphQLClient
(
	cache: InMemoryCache(),
	link: HttpLink(uri: "https://vjnvisakh-todo.herokuapp.com/graphql")
);

final String getUserData = """
query
{
	user(userId: 1)
	{
		userId,
		name,
		email,
		picture,
		googleId,
		categories
		{
			categoryId,
			name,
			type,
			created,
			count,
			tasks
			{
				taskId,
				title,
				created,
				description,
				isCompleted
			}
		}
	}
}
""";

final String createCategoryQuery = """
mutation(\$name: String!, \$type: String!, \$userId: Int!)
{
	createCategory(name: \$name , type: \$type, userId: \$userId)
	{
		categoryId, name
	}
}
""";

final String createTaskQuery = """
mutation(\$title: String!, \$description: String!, \$categoryId: Int!, \$parentId: Int!, \$userId: Int!)
{
	createTask(title: \$title, description: \$description, parentId: \$parentId, categoryId: \$categoryId, userId: \$userId)
	{
		taskId
	}
}
""";