class DIP_NVR {
  final String id;
  final String name;
  final bool status;
  final String addr;
  final String thumbnails;

  DIP_NVR({
    required this.id,
    required this.name,
    required this.status,
    required this.addr,
    required this.thumbnails,
  });

  factory DIP_NVR.fromJson(Object json) {
    if (json
        case {
          'id': String id,
          'name': String name,
          'status': bool status,
          'addr': String addr,
          'thumbnails': String thumbnails,
        }) {
      return DIP_NVR(
          id: id,
          name: name,
          status: status,
          addr: addr,
          thumbnails: thumbnails);
    } else {
      throw Exception("Invalid JSON");
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'addr': addr,
      'thumbnails': thumbnails
    };
  }
}
