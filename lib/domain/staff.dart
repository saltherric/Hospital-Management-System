import 'package:uuid/uuid.dart';

final _uuid = Uuid();

enum Sex { Male, Female }
enum Position { Doctor, Nurse, AdminStaff }
enum Role { HROfficer, Accountant }

abstract class Staff {
  final String _id;
  String _name;
  final Sex _sex;
  final DateTime _dob;
  final Position _position;
  String _department;
  double _salary;

  Staff(
    String? id,  
    this._name,
    this._sex,
    this._dob,
    this._position,
    this._department,
    this._salary,
  ) : _id = id ?? _generateShortId(_position);

  // Generate uniqe short ID 
  static String _generateShortId(Position pos) {
    final prefix = switch (pos) {
      Position.Doctor => 'D',
      Position.Nurse => 'N',
      Position.AdminStaff => 'A',
    };
    final shortId = _uuid.v4().substring(0, 5).toUpperCase();

    return '$prefix-$shortId';
  }

  String get id => _id;
  String get name => _name;
  Sex get sex => _sex;
  DateTime get dob => _dob;
  Position get position => _position;
  String get department => _department;
  double get salary => _salary;

  void updateName(String value) {
    _name = value;
  }

  void updateDepartment(String value) {
    _department = value;
  }

  void updateSalary(double value) {
    _salary = value;
  }

  void displayInfo();

  Map<String, dynamic> toJson();

}
