import 'package:uuid/uuid.dart';

final _uuid = Uuid();

class Appointment {
  final String id;
  final String doctorId;
  final String patientId;
  final String startTime;
  final String endTime;

  Appointment({
    String? id,
    required this.doctorId,
    required this.patientId,
    required this.startTime,
    required this.endTime,
  }) : id = id ?? '${_uuid.v4().substring(0,5).toUpperCase()}';

  Map<String, dynamic> toJson() => {
    'id': id,
    'doctorId': doctorId,
    'patientId': patientId,
    'startTime': startTime,
    'endTime': endTime,
  };

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'] as String?,
      doctorId: json['doctorId'] as String? ?? '',
      patientId: json['patientId'] as String? ?? '',
      startTime: json['startTime'] as String? ?? '',
      endTime: json['endTime'] as String? ?? '',
    );
  }

  void displayAppointment() {
    print('----------------------------------');
    print('Appointment ID: $id');
    print('Doctor ID: $doctorId');
    print('Patient ID: $patientId');
    print('Start Time: $startTime');
    print('End Time: $endTime');
    print('----------------------------------');
  }

}