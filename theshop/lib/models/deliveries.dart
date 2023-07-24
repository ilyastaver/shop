class DeliveryOption {
  final String id;
  final String title;
  final String description;
  final String type;
  final String icon;
  final String farmAddress;

  DeliveryOption({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.icon,
    required this.farmAddress,
  });

  factory DeliveryOption.fromJson(Map<String, dynamic> json) {
    return DeliveryOption(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      type: json['type'],
      icon: json['icon'],
      farmAddress: json['farm_address'],
    );
  }
}
