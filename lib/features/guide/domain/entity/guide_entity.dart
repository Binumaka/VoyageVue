class GuideEntity {
  final String id;
  final String name;
  final String email;
  final int experience;
  final List<String> languages;
  final int contact;
  final bool availability;

  GuideEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.experience,
    required this.languages,
    required this.contact,
    required this.availability,
  });

  List<Object?> get props =>
      [id, name, email, experience, languages, contact, availability];
}