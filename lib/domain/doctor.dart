import 'staff.dart';

class Doctor extends Staff {
  final specialization;
  int patientsCount;

  Doctor(
    String id, 
    String name, 
    String sex,
    DateTime dob,
    Position position,
    String department, 
    double salary, 
    this.specialization, 
    this.patientsCount
    )
    :super(id, name, sex, dob, position, department, salary);
  
  void performCheckup() {
    print("$name is checking a patient.");
    patientsCount++;
  } 
  void prescribeMedication(String patientName, String medicine) {
    print("$name prescribed $medicine to $patientName.");
  } 

  @override
  void displayInfo() {
    print('ID: $id');
    print('Name: $name');
    print('Sex: ${sex}');
    print('DOB: ${dob.toLocal()}');
    print('Department: $department');
    print('Position: ${position.name}');
    print('Specialization: $specialization');
    print('Patients Count: $patientsCount');
    print('Salary: \$${salary.toStringAsFixed(2)}');
  }

  @override
  Map<String, dynamic> toJson() => {
    'specialization' : specialization,
    'patientsCount' : patientsCount,
  };

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
    json['id'],
    json['name'],
    json['sex'],
    DateTime.parse(json['dob']),
    Position.values.firstWhere((p) => p.name == json['position']),
    json['department'],
    (json['salary'] as num).toDouble(),
    json['specialization'],
    json['patientsCount'],
  );
}