class MovieCreditsResponse {
  final int id;
  final List<Cast> cast;
  final List<Crew> crew;

  MovieCreditsResponse({
    required this.id,
    required this.cast,
    required this.crew,
  });

  factory MovieCreditsResponse.fromJson(Map<String, dynamic> json) =>
      MovieCreditsResponse(
        id: json["id"],
        cast: json["cast"] != null
            ? List<Cast>.from(
                json["cast"].map((x) => Cast.fromJson(x)),
              )
            : [],
        crew: json["crew"] != null
            ? List<Crew>.from(
                json["crew"].map((x) => Crew.fromJson(x)),
              )
            : [],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cast": List<dynamic>.from(cast.map((x) => x.toJson())),
    "crew": List<dynamic>.from(crew.map((x) => x.toJson())),
  };
}

class Cast {
  final bool adult;
  final int gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final int order;
  final String? profilePath;
  final String character;
  final String creditId;

  Cast({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.order,
    this.profilePath,
    required this.character,
    required this.creditId,
  });

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
    adult: json["adult"] ?? false,
    gender: json["gender"] ?? 0,
    id: json["id"],
    knownForDepartment: json["known_for_department"] ?? "",
    name: json["name"] ?? "",
    order: json["order"] ?? 0,
    profilePath: json["profile_path"],
    character: json["character"] ?? "",
    creditId: json["credit_id"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "gender": gender,
    "id": id,
    "known_for_department": knownForDepartment,
    "name": name,
    "order": order,
    "profile_path": profilePath,
    "character": character,
    "credit_id": creditId,
  };
}

class Crew {
  final bool adult;
  final int gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String department;
  final String job;
  final String? profilePath;
  final String creditId;

  Crew({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.department,
    required this.job,
    this.profilePath,
    required this.creditId,
  });

  factory Crew.fromJson(Map<String, dynamic> json) => Crew(
    adult: json["adult"] ?? false,
    gender: json["gender"] ?? 0,
    id: json["id"],
    knownForDepartment: json["known_for_department"] ?? "",
    name: json["name"] ?? "",
    department: json["department"] ?? "",
    job: json["job"] ?? "",
    profilePath: json["profile_path"],
    creditId: json["credit_id"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "gender": gender,
    "id": id,
    "known_for_department": knownForDepartment,
    "name": name,
    "department": department,
    "job": job,
    "profile_path": profilePath,
    "credit_id": creditId,
  };
}
