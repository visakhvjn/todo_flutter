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
			created,
			count,
			tasks
			{
				taskId,
				title,
				created,
				description
			}
		}
	}
}
""";