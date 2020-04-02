class Source {
  final String name;
  final dynamic id;
  String description;
  String url;
  String category;
  String language;
  String country;

  Source(
    this.name,
    this.id, {
    this.description,
    this.url,
    this.country,
    this.category,
    this.language,
  });

  factory Source.fromMap(Map source) {
    return Source(
      source['name'],
      source['id'] ?? null,
      description:
          source.containsKey('description') ? source['description'] : null,
      url: source.containsKey('url') ? source['url'] : null,
      category: source.containsKey('category') ? source['category'] : null,
      country: source.containsKey('country') ? source['country'] : null,
      language: source.containsKey('language') ? source['language'] : null,
    );
  }
}
