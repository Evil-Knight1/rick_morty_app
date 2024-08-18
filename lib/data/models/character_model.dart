class CharacterModel {
  final int id;
  final String name, status, species, type, gender, image, url;
  final Origin origin;
  final List<dynamic> episode;
  final Location location;

  CharacterModel(
      {required this.episode,
      required this.location,
      required this.id,
      required this.name,
      required this.status,
      required this.species,
      required this.type,
      required this.gender,
      required this.image,
      required this.url,
      required this.origin});

  factory CharacterModel.fromJson(jsonData) {
    return CharacterModel(
      id: jsonData['id'],
      name: jsonData['name'],
      status: jsonData['status'],
      species: jsonData['species'],
      type: jsonData['type'],
      gender: jsonData['gender'],
      image: jsonData['image'],
      url: jsonData['url'],
      origin: Origin.fromJson(jsonData['origin']),
      location: Location.fromJson(jsonData['location']),
      episode: jsonData['episode'],
    );
  }
}

class Location {
  final String name, url;

  Location({required this.name, required this.url});
  factory Location.fromJson(jsonData) => Location(
        name: jsonData['name'],
        url: jsonData['url'],
      );
}

class Origin {
  final String name, url;

  Origin({required this.name, required this.url});

  factory Origin.fromJson(jsonData) => Origin(
        name: jsonData['name'],
        url: jsonData['url'],
      );
}
