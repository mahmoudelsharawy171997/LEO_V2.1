class Events {
  final String id;
  final String titre;
  final String description;
  final String date;
  final String temps;
  final String lieu;
  final String image;

  Events({
    this.id,
    this.titre,
    this.description,
    this.date,
    this.temps,
    this.lieu,
    this.image,
  });

  factory Events.fromJson(Map<String, dynamic> json) {
    return Events(
        id: json['id'],
        titre: json['titre'],
        lieu: json['lieu'],
        date: json['date'],
        temps: json['temps'],
        image: "",
        description: json['description']);
  }
}