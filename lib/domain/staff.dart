enum Sex { Male, Female }
enum Position { Doctor, Nurse, AdminStaff }
enum Role { HROfficer, Accountant, ITManager }

abstract class Staff {
  final String _id;
  final String _name;
  final Sex _sex;
  final DateTime _dob;
  final Position _position;
  final String _department;
  double _salary;

  Staff(
    this._id,
    this._name,
    this._sex,
    this._dob,
    this._position,
    this._department,
    this._salary
  );

  String get id => _id;
  String get name => _name;
  Sex get sex => _sex;
  DateTime get dob => _dob;
  Position get position => _position;
  String get department => _department;
  double get salary => _salary;

  void displayInfo();

  Map<String, dynamic> toJson();

  // Optional salary methods with encapsulation logic.
  // double getSalary() => _salary;
  // void setSalary(double value) {
  //   if (value > 0) _salary = value;
  // }
}
