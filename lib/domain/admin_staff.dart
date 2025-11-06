import 'staff.dart';

class AdminStaff extends Staff {
  final Role role;
  final String officeNumber;

  AdminStaff(
    String? id,
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

  void manageAppointments() {
    if (role == Role.HROfficer) {
      print('HR Office $name managed doctor and staff schedules.');
    } else{
      print('Accountant $name could not manage appointments directly.');
    }
  }

  void generateReports() {
    if (role == Role.HROfficer) {
      print('HR Office $name generated employee performance a reports.');
    } else{
      print('Accountant $name generated financial reports.');
    }
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
