class TaskModel {
  static const String collectionName = "TasksCollection";
  String? id;
  String? uid;
  String title;
  String description;
  DateTime selectedDate;
  bool isDone;

  TaskModel(
      {required this.title,
      this.id,
      this.uid,
      required this.description,
      required this.selectedDate,
      this.isDone = false});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "uid": uid,
      "title": title,
      "description": description,
      "selectedDate": selectedDate.millisecondsSinceEpoch,
      "isDone": isDone,
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json["id"],
      uid: json["uid"],
      title: json["title"],
      description: json["description"],
      selectedDate: DateTime.fromMillisecondsSinceEpoch(json["selectedDate"]),
      isDone: json["isDone"],
    );
  }
}
