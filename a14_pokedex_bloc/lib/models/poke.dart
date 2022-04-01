class PokeResponse {
  List<Poke> data;

  PokeResponse({required this.data});

  factory PokeResponse.fromJson(Map<String, dynamic> json) {
    List<Poke> data = [];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(Poke.fromJson(v));
      });
    }
    return PokeResponse(data: data);
  }
}

class Poke {
  Poke({
    required this.name,
    required this.type,
    required this.img,
  });

  String name;
  String type;
  String img;

  factory Poke.fromJson(Map<String, dynamic> json) {
    return Poke(
      name: json["name"],
      type: json["type"],
      img: json["img"],
    );
  }
}
