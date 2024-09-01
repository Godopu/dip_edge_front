class DIP_CCTV {
  final String id;
  final String name;
  final bool status;
  final String addr;

  DIP_CCTV({
    required this.id,
    required this.name,
    required this.status,
    required this.addr,
  });

  factory DIP_CCTV.fromJson(Object json) {
    if (json
        case {
          'id': String id,
          'name': String name,
          'status': bool status,
          'addr': String addr
        }) {
      return DIP_CCTV(
        id: id,
        name: name,
        status: status,
        addr: addr,
      );
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
    };
  }
}
