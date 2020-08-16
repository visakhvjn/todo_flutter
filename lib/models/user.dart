import 'package:todo/models/category.dart';

class User
{
	User(dynamic data)
	{
		this.userId = data["userId"];
		this.name = data["name"];

		for (var i = 0; i < data["categories"].length; i++)
		{
			this.categories.add(Category(data["categories"][i]));
		}
	}

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
}