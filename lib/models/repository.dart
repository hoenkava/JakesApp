
class Repository {
  final String name;
  final String description;
  final String? language;
  final int issues;
  final int people;

  Repository({
    required this.name,
    required this.description,
    this.language,
    this.issues = 0,
    this.people = 0,
  });
}
