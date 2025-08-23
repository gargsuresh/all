class Market {
  final String id;
  final String name;
  final String opent;
  final String closet;
  final String ank1;
  final String ank2;
  final String total;
  final String total2;

  Market({
    required this.id,
    required this.name,
    required this.opent,
    required this.closet,
    required this.ank1,
    required this.ank2,
    required this.total,
    required this.total2,
  });

  factory Market.fromJson(Map<String, dynamic> json) {
    return Market(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      opent: json['opent'] ?? '',
      closet: json['closet'] ?? '',
      ank1: json['ank1'] ?? '',
      ank2: json['ank2'] ?? '',
      total: json['total'] ?? '',
      total2: json['total2'] ?? '',
    );
  }
}
