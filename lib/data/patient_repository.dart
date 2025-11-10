import 'dart:io';
import 'dart:convert';
import '../domain/patient.dart';

class PatientRepository {
  final String filePath = 'data/patients.json';
  List<Patient> patients = [];

  PatientRepository() {
    loadData();
  }

  void loadData() {
    final file = File(filePath);

    if (!file.existsSync()) {
      file.createSync(recursive: true);
      file.writeAsStringSync('[]');
    }

    final content = file.readAsStringSync();
    if (content.trim().isEmpty) {
      patients = [];
      return;
    }

    final List data = jsonDecode(content);
    patients = data.map((e) => Patient.fromJson(e)).toList();
  }

  void saveOrUpdate(Patient patient) {
    final index = patients.indexWhere((p) => p.id == patient.id);
    if (index >= 0) {
      patients[index] = patient;
    } else {
      patients.add(patient);
    }
    _saveAll();
  }

  Patient? findById(String id) {
    try {
      return patients.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  void _saveAll() {
    final file = File(filePath);
    final data = patients.map((p) => p.toJson()).toList();
    file.writeAsStringSync(JsonEncoder.withIndent('  ').convert(data));
  }
}
