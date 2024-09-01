class DIP_Svc {
  final String id;
  final String status;
  final String? addr;
  final String imgId;
  final String imgName;
  final String imgWriter;

  DIP_Svc({
    required this.id,
    required this.status,
    this.addr,
    required this.imgId,
    required this.imgName,
    required this.imgWriter,
  });

  factory DIP_Svc.fromJson(Object json) {
    if (json
        case {
          "id": String id,
          "status": String status,
          "addr": String? addr,
          "imgId": String imgId,
          "imgName": String imgName,
          "imgWriter": String imgWriter,
        }) {
      return DIP_Svc(
        id: id,
        status: status,
        addr: addr,
        imgId: imgId,
        imgName: imgName,
        imgWriter: imgWriter,
      );
    } else {
      throw Exception("Invalid JSON");
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "status": status,
      "addr": addr,
      "imgId": imgId,
      "imgName": imgName,
      "imgWriter": imgWriter,
    };
  }
}
