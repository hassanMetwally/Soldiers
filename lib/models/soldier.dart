class Soldier {
  int? id;
  String name;
  int sectionId;
  String returnDate;
  int attendance;

  Soldier({
    this.id,
    required this.name,
    required this.sectionId,
    required this.returnDate,
    required this.attendance,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'sectionId': sectionId,
      'returnDate': returnDate,
      'attendance': attendance,
    };
  }

  factory Soldier.fromMap(Map<String, dynamic> map) {
    return Soldier(
      id: map['id'],
      name: map['name'],
      sectionId: map['sectionId'],
      returnDate: map['returnDate'],
      attendance: map['attendance'],
    );
  }
}
