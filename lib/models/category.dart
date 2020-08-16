import 'package:todo/models/task.dart';

class Category
{
	Category(dynamic data)
	{
		this.categoryId = data["categoryId"];
		this.name = data["name"];
		this.count = data["count"];
		this.type = data["type"];
		this.created = data["created"];

		for (var i = 0; i < data["tasks"].length; i++)
		{
			this.tasks.add(Task(data["tasks"][i]));
		}
	}

	int categoryId;
	String name;
	int count;
	List<Task> tasks = [];
	String type;
	String created;
}