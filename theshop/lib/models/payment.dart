class PaymentOption {
  final String id;
  final String title;
  final String type;
  final String description;
  final String icon;
  final String? link;

  PaymentOption({
    required this.id,
    required this.title,
    required this.type,
    required this.description,
    required this.icon,
    this.link,
  });

  factory PaymentOption.fromJson(Map<String, dynamic> json) {
    return PaymentOption(
      id: json['id'],
      title: json['title'],
      type: json['type'],
      description: json['description'],
      icon: json['icon'],
      link: json['link'],
    );
  }
}
