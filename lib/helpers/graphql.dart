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
			status,
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
		categoryId, name, type, created, count, tasks
		{
			taskId, title, created, description, isCompleted
		}
	}
}
""";

final String createTaskQuery = """
mutation(\$title: String!, \$description: String!, \$categoryId: Int!, \$parentId: Int!, \$userId: Int!)
{
	createTask(title: \$title, description: \$description, parentId: \$parentId, categoryId: \$categoryId, userId: \$userId)
	{
		taskId, title, created, description, isCompleted
	}
}
""";

final String removeCategory = """
mutation(\$userId: Int!, \$categoryId: Int!)
{
	removeCategory(userId: \$userId, categoryId: \$categoryId)
	{
		categoryId
	}
}
""";