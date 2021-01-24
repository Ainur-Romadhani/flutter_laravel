class Todo {
  int id_todos;
  String name;
  String start_date;
  String end_date;
  String progress;
  String create_by;
  int user_id;

  Todo({
    this.id_todos,
    this.name,
    this.start_date,
    this.end_date,
    this.progress,
    this.create_by,
    this.user_id,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        id_todos: json['id'],
        name: json['name'],
        start_date: json['start_date'],
        end_date: json['end_date'],
        progress: json['progress'],
        create_by: json['create_by'],
        user_id: json['user_id'],
      );
}
