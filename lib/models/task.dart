
class Task
{
	Task(dynamic data)
	{
		this.taskId = data["taskId"];
		this.title = data["title"];
	}

	int taskId;
	String title;
}