import 'package:test/test.dart';
import 'package:hospital_management_system/domain/admin_staff.dart';
import 'package:hospital_management_system/domain/doctor.dart';
import 'package:hospital_management_system/domain/nurse.dart';
import 'package:hospital_management_system/domain/patient.dart';
import 'package:hospital_management_system/domain/staff.dart';
import 'package:hospital_management_system/domain/appointment.dart';

void main() {
  //  Admin Staff Tests
  group('AdminStaff.scheduleAppointment()', () {
    test('Admin automatically computes +30min end time when scheduling', () {
        // Arrange
        final admin = AdminStaff(
            'A-100',
            'Sopheak',
            Sex.Female,
            DateTime(1997, 9, 10),
            Position.AdminStaff,
            'Admin',
            2000,
            Role.HROfficer,
            'A203',
        );

        final start = '2025-11-10 09:00';

        // Act 
        final appointment = admin.scheduleAppointment('D-100', 'P-252D1', start);

        // Assert 
        expect(appointment.doctorId, equals('D-100'));
        expect(appointment.patientId, equals('P-252D1'));
        expect(appointment.startTime, equals(start));
        expect(appointment.endTime, equals('2025-11-10 09:30')); // computed automatically
        expect(appointment.id.isNotEmpty, isTrue);
    });

    test('Admin assigns appointment with valid doctor and patient IDs', () {
        final doctorId = 'D-300';
        final patientId = 'P-252D1';

        final appointment = Appointment(
            doctorId: doctorId,
            patientId: patientId,
            startTime: '2025-11-10 13:00',
            endTime: '2025-11-10 13:30',
        );

        expect(appointment.doctorId.startsWith('D-'), isTrue);
        expect(appointment.patientId.isNotEmpty, isTrue);
    });

  });

  // Doctor Tests
  group('Doctor.performCheckup()', () {
    test('increments patient count and updates patient info', () {
      // Arrange
      final doctor = Doctor(
        'D-001',
        'Dr. Dara',
        Sex.Male,
        DateTime(1995, 5, 10),
        Position.Doctor,
        'Cardiology',
        3000,
        'Heart Specialist',
        0,
      );

      final patient = Patient(
        id: 'P-003',
        name: 'Sokha',
        status: 'Waiting',
        medicalHistory: [],
      );

      // Act
      doctor.performCheckup(patient);

      // Assert
      expect(doctor.patientsCount, equals(1));
      expect(patient.status, equals('Checked'));
      expect(patient.medicalHistory.isNotEmpty, isTrue);
      expect(patient.medicalHistory.first.contains('Dr. Dara'), isTrue);
    });
  });

  // Nurse Tests
  group('Nurse.updatePatientStatus()', () {
    test('updates patient status and adds history entry', () {
      // Arrange
      final nurse = Nurse(
        'N-001',
        'Layeang',
        Sex.Female,
        DateTime(1998, 6, 25),
        Position.Nurse,
        'Ward A',
        1800,
        'Night',
        'Ward 5',
      );

      final patient = Patient(
        id: 'P-002',
        name: 'Tola',
        status: 'Checked',
        medicalHistory: [],
      );

      // Act
      nurse.updatePatientStatus(patient, 'Recovering');

      // Assert
      expect(patient.status, equals('Recovering'));
      expect(patient.medicalHistory.isNotEmpty, isTrue);
      expect(patient.medicalHistory.last.contains('Recovering'), isTrue);
    });
  });

}