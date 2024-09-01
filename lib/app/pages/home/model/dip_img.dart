class DIP_Img {
  final String id;
  final String name;
  final String logo;
  final String description;
  final String exec;
  final String writer;
  String? imgUrl;

  DIP_Img({
    required this.id,
    required this.name,
    required this.logo,
    required this.description,
    required this.exec,
    required this.writer,
    this.imgUrl,
  });

  factory DIP_Img.fromJson(Object json) {
    if (json
        case {
          "id": String id,
          "name": String name,
          "logo": String logo,
          "description": String description,
          "exec": String exec,
          "writer": String writer,
          "imgUrl": String imgUrl,
        }) {
      return DIP_Img(
        id: id,
        name: name,
        logo: logo,
        description: description,
        exec: exec,
        writer: writer,
        imgUrl: imgUrl,
      );
    } else {
      throw Exception("Invalid JSON");
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "logo": logo,
      "description": description,
      "exec": exec,
      "writer": writer,
      "imgUrl": imgUrl,
    };
  }
}
