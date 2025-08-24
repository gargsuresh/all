class Market {
  final String id;
  final String name;
  final String opent;
  final String closet;
  final String ank1;
  final String ank2;
  final String total;
  final String total2;
  final String mid;
  final String cmid;
  final String date;
  final String openm;


  Market({
    required this.id,
    required this.name,
    required this.opent,
    required this.closet,
    required this.ank1,
    required this.ank2,
    required this.total,
    required this.total2,
    required this.mid,
    required this.cmid,
    required this.date,
    required this.openm,
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
      mid: json['mid'] ?? '',
      cmid: json['cmid'] ?? '',
      date: json['date'] ?? '',
      openm: json['openm'] ?? '',
    );
  }
}
