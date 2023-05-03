class Language {
  String name;
  Language(this.name);

  Map toJson() => {'name': name};
}
