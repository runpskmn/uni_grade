class SubjectItem{
  final String subjectID;
  final String name;
  final int credit;
  final int day;
  final String time;

  SubjectItem({required this.subjectID, required this.name, required this.credit, required this.day, required this.time});

  factory SubjectItem.fromMap(Map<String, dynamic> data) {
    return SubjectItem(subjectID: data['subID'], name: data['name'], credit: int.parse(data['credit']), day: int.parse(data['day']), time: data['time']);
  }
}