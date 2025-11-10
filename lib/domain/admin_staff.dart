import 'appointment.dart';
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

  Appointment scheduleAppointment(String doctorId, String patientId, String startTime) {
    DateTime dateTime;
    try {
      final parts = startTime.split(' ');
      final dateParts = parts[0].split('-').map((s) => int.parse(s)).toList();
      final timeParts = parts[1].split(':').map((s) => int.parse(s)).toList();
      dateTime = DateTime(dateParts[0], dateParts[1], dateParts[2], timeParts[0], timeParts[1]);
    } catch (e) {
      throw FormatException('startTime must be "YYYY-MM-DD HH:MM');
    }

    final endDt = dateTime.add(Duration(minutes: 30));

    String fmt(DateTime d) {
      final yyyy = d.year.toString().padLeft(4, '0');
      final mm = d.month.toString().padLeft(2, '0');
      final dd = d.day.toString().padLeft(2, '0');
      final HH = d.hour.toString().padLeft(2, '0');
      final MM = d.minute.toString().padLeft(2, '0');

      return '$yyyy-$mm-$dd $HH:$MM';
    }

    final computedEnd = fmt(endDt);

    final appointment = Appointment(
      doctorId: doctorId,
      patientId: patientId,
      startTime: startTime,
      endTime: computedEnd,
    );
    return appointment;
  }
  
}