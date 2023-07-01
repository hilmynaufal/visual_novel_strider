class Media {
  Media({
    required this.medium,
    required this.qty,
  });

  String medium;
  int qty;

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        medium: json["medium"],
        qty: json["qty"],
      );

  Map<String, dynamic> toJson() => {
        "medium": medium,
        "qty": qty,
      };
}
