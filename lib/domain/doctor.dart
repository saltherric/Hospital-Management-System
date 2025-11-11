import 'staff.dart';
import 'patient.dart';
import '../data/patient_repository.dart';
import '../data/staff_repository.dart';

class Doctor extends Staff {
  final String specialization;
  int patientsCount;

  Doctor(
    String? id, 
    String name, 
    Sex sex,
    DateTime dob,
    Position position,
    String department, 
    double salary, 
    this.specialization, 
    this.patientsCount
    )
    :super(id, name, sex, dob, position, department, salary);

  @override
  void displayInfo() {
    print('ID: $id');
    print('Name: $name');
    print('Sex: ${sex.name}');
    print('DOB: ${dob.toLocal()}');
    print('Department: $department');
    print('Position: ${position.name}');
    print('Specialization: $specialization');
    print('Patients Count: $patientsCount');
    print('Salary: \$${salary.toStringAsFixed(2)}');
  }

  @override
  Map<String, dynamic> toJson() => {
    'type': 'doctor',
    'id': id,
    'name': name,
    'sex': sex.name,
    'dob': dob.toIso8601String(),
    'position': position.name,
    'department': department,
    'salary': salary,
    'specialization' : specialization,
    'patientsCount' : patientsCount,
  };

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
    json['id'],
    json['name'],
    Sex.values.firstWhere((e) => e.name == json['sex']),
    DateTime.parse(json['dob']),
    Position.values.firstWhere((e) => e.name == json['position']),
    json['department'],
    (json['salary'] as num).toDouble(),
    json['specialization'],
    json['patientsCount'],
  );

  void performCheckup(Patient patient) {
    final now = DateTime.now();
    
    final dateStr = // format String like 2025-11-11 14:35
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} '
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';

    // Update patient record
    patient.status = 'Checked';
    patient.medicalHistory.add('Checked by Dr. $name on $dateStr');

    // Increase patient's count 
    patientsCount += 1;

    // Save patient record
    final patientRepo = PatientRepository();
    patientRepo.saveOrUpdate(patient);

    // Save updated doctor data
    final staffRepo = StaffRepository();
    staffRepo.loadData(); // load existing doctors
    final index = staffRepo.staffList.indexWhere((s) => s.id == id);

    if (index >= 0) {
      staffRepo.staffList[index] = this; // update this doctor object
      staffRepo.saveAll(); // save to doctor.json
    }

    print('\nDr. $name performed a checkup on patient ${patient.name}.');
    print('Updated patient status: ${patient.status}');
    print('Total patients checked: $patientsCount');
    patient.displayInfo();
  }
}