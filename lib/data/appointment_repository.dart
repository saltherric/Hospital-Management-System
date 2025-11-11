import 'dart:io';
import 'dart:convert';
import '../domain/appointment.dart';

class AppointmentRepository {
  final String filePath = 'data/appointments.json';
  List<Appointment> appointments = [];

  AppointmentRepository() {
    loadAll();
  }

  // Reads appointments from file and converts them into objects
  void loadAll() {
    final file = File(filePath);
    if (!file.existsSync()) {
      file.createSync(recursive: true);
      file.writeAsStringSync('[]');
    }

    final content = file.readAsStringSync();
    if (content.trim().isEmpty) {
      appointments = [];
      return;
    }

    final List data = jsonDecode(content);
    appointments = data.map((e) => Appointment.fromJson(e)).toList(); 
  } 


  void addAppointment(Appointment a) {
    appointments.add(a);
    _saveAll();
  }

  // Writes current appointments list to JSON file
  void _saveAll() {
    final file = File(filePath);
    final data = appointments.map((a) => a.toJson()).toList();
    file.writeAsStringSync(JsonEncoder.withIndent(' ').convert(data));
  }

  // Checks if doctor-patient appointment already exists
  bool hasAppointment(String doctorId, String patientId) {
    return appointments.any((a) =>
      a.doctorId == doctorId && 
      a.patientId.toLowerCase() == patientId.toLowerCase());
  }

  // Returns all appointments for a specific doctor
  List<Appointment> getAppointmentsForDoctor(String doctorId) {
    return appointments.where((a) => a.doctorId == doctorId).toList();
  }
}