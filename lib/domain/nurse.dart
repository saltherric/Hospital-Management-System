import 'staff.dart';

class Nurse extends Staff {
  final String shift; 
  final String assignedWard;

  Nurse(
    String id,
    String name,
    String sex,
    DateTime dob,
    Position position,
    String department,
    double salary,
    this.shift,
    this.assignedWard,
  ) : super(id, name, sex, dob, position, department, salary);

  @override
  void displayInfo() {
    print('ID: $id');
    print('Name: $name');
    print('Sex: $sex');
    print('DOB: ${dob.toLocal()}');
    print('Department: $department');
    print('Position: ${position.name}');
    print('Shift: $shift');
    print('Assigned Ward: $assignedWard');
    print('Salary: \$${salary.toStringAsFixed(2)}');
  }

  @override
  Map<String, dynamic> toJson() => {
    'type': 'nurse',
    'id': id,
    'name': name,
    'sex': sex,
    'dob': dob.toIso8601String(),
    'position': position.name,
    'department': department,
    'salary': salary,
    'shift': shift,
    'assignedWard': assignedWard,
  };

  @override
  factory Nurse.fromJson(Map<String, dynamic> json) => Nurse(
    json['id'],
    json['name'],
    json['sex'],
    DateTime.parse(json['dob']),
    Position.values.firstWhere((e) => e.name == json['position']),
    json['department'],
    (json['salary'] as num).toDouble(),
    json['shift'],
    json['assignedWard'],
  );
}
