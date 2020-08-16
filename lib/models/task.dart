
class Task
{
	Task(dynamic data)
	{
		this.taskId = data["taskId"];
		this.title = data["title"];
		this.description = data["description"];
		this.created = data["created"];
		this.isCompleted = data["isCompleted"];
	}

	int taskId;
	String title;
	String description;
	String created;
	bool isCompleted;
}