import 'staff.dart';

class AdminStaff extends Staff {
  final Role role;
  final String officeNumber;

  AdminStaff(
    String id,
    String name,
    Sex sex,
    DateTime dob,
    Position position,
    String department,
    double salary,
    this.role,
    this.officeNumber,
  ) : super(id, name, sex, dob, position, department, salary);

  @override
  void displayInfo() {
    print(' Admin Staff Information');
    print('------------------------------');
    print('ID: $id');
    print('Name: $name');
    print('Sex: ${sex.name}');
    print('DOB: ${dob.toLocal()}');
    print('Department: $department');
    print('Position: ${position.name}');
    print('Role: ${role.name}');
    print('Office Number: $officeNumber');
    print('Salary: \$${salary.toStringAsFixed(2)}');
  }

  @override
  Map<String, dynamic> toJson() => {
        'type': 'admin',
        'id': id,
        'name': name,
        'sex': sex.name,
        'dob': dob.toIso8601String(),
        'position': position.name,
        'department': department,
        'salary': salary,
        'role': role.name,
        'officeNumber': officeNumber,
      };

  factory AdminStaff.fromJson(Map<String, dynamic> json) => AdminStaff(
        json['id'],
        json['name'],
        Sex.values.firstWhere((e) => e.name == json['sex']),
        DateTime.parse(json['dob']),
        Position.values.firstWhere((e) => e.name == json['position']),
        json['department'],
        (json['salary'] as num).toDouble(),
        Role.values.firstWhere((e) => e.name == json['role']),
        json['officeNumber'],
      );
}
