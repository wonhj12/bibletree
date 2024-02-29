class RecordItem {
  int? id;
  int verseId;
  bool like;
  String thought;
  final DateTime createdAt;

  RecordItem(
    this.id,
    this.verseId,
    this.like,
    this.thought,
    this.createdAt,
  );

  /// Get data from database and convert to RecordItem data
  factory RecordItem.fromDatabaseJson(Map<String, dynamic> data) => RecordItem(
      data['id'],
      data['verseId'],
      data['like'] == 1,
      data['thought'],
      DateTime.fromMillisecondsSinceEpoch(data['createdAt'] as int));

  /// Convert RecordItem data into json to save to database
  Map<String, dynamic> toDatabaseJson() => {
        'verseId': verseId,
        'like': like ? 1 : 0,
        'thought': thought,
        'createdAt': createdAt.millisecondsSinceEpoch,
      };
}
