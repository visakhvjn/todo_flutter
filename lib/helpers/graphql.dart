import 'package:graphql/client.dart';

final GraphQLClient graphQLClient = GraphQLClient
(
	cache: InMemoryCache(),
	link: HttpLink(uri: "https://vjnvisakh-todo.herokuapp.com/graphql")
);

final String getUserCategoriesQuery = """
query
{
	categories
	{
		categoryId, created, type, userId
	}
}
""";