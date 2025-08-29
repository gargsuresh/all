class StatementModel {
  final String referenceId;
  final String transactionAmount;
  final String description;
  final String status;
  final String date;
  final bool isCredit;

  StatementModel({
    required this.referenceId,
    required this.transactionAmount,
    required this.description,
    required this.status,
    required this.date,
    required this.isCredit,
  });

  factory StatementModel.fromJson(Map<String, dynamic> json) {
    return StatementModel(
      referenceId: json["referenceId"].toString(),
      transactionAmount: json["transactionAmount"].toString(),
      description: json["description"] ?? "",
      status: json["status"] ?? "",
      date: json["date"] ?? "",
      isCredit: json["isCredit"] == true,
    );
  }
}


