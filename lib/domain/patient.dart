import 'package:uuid/uuid.dart';

final _uuid = Uuid();

class Patient {
  final String id;
  String name;
  String status;
  List<String> medicalHistory;

  Patient({
    String? id,
    required this.name,
    this.status = 'Waiting',
    List<String>? medicalHistory,
  })  : id = id ?? 'P-${_uuid.v4().substring(0, 5).toUpperCase()}',
        medicalHistory = medicalHistory ?? [];

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'status': status,
    'medicalHistory': medicalHistory,
  };

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'],
      name: json['name'],
      status: json['status'] ?? 'Waiting',
      medicalHistory: List<String>.from(json['medicalHistory'] ?? []),
    );
  }

  void displayInfo() {
    print('----------------------------------');
    print('Patient ID: $id');
    print('Name: $name');
    print('Status: $status');
    print('Medical History:');
    for (var note in medicalHistory) {
      print(' - $note');
    }
    print('----------------------------------');
  }
}