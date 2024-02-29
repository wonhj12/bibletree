class Verse {
  int id;
  String verse;
  String book;
  String chapter;

  Verse({
    required this.id,
    required this.verse,
    required this.book,
    required this.chapter,
  });

  factory Verse.fromJson(Map<String, dynamic> json) => Verse(
        id: json['id'] as int,
        verse: json['verse'],
        book: json['book'],
        chapter: json['chapter'],
      );
}
