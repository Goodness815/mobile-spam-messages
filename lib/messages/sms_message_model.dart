class SmsMessageModel {
  final String? address;
  final String? body;
  final int? date;

  SmsMessageModel({
    required this.address,
    required this.body,
    required this.date,
    // You can add other properties like isSpam here if needed.
  });
}
