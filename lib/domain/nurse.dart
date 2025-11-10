import 'package:hospital_management_system/data/patient_repository.dart';
import 'staff.dart';
import 'patient.dart';

class Nurse extends Staff {
  final String shift; 
  final String assignedWard;

  Nurse(
    String? id,
    String name,
    Sex sex,
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
    print('Sex: ${sex.name}');
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
    'sex': sex.name,
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
    Sex.values.firstWhere((e) => e.name == json['sex']),
    DateTime.parse(json['dob']),
    Position.values.firstWhere((e) => e.name == json['position']),
    json['department'],
    (json['salary'] as num).toDouble(),
    json['shift'],
    json['assignedWard'],
  );

  void updatePatientStatus(Patient patient, String newStatus) {
    final now = DateTime.now();
    final dateStr = 
      '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} '
      '${now.hour}-${now.month.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')} ';

    // Update patient info
    patient.status = newStatus;
    patient.medicalHistory.add(
      'Status updated to "$newStatus" by Nurse $name on $dateStr.'
    );

    // Save back to Json
    final PatientRepo = PatientRepository();
    PatientRepo.saveOrUpdate(patient);

    print('\n Nurse $name updated patient ${patient.name} status to "$newStatus".');
    print('----------------------------------');
    patient.displayInfo();
  }
}
