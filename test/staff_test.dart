import 'package:test/test.dart';
import 'package:hospital_management_system/domain/doctor.dart';
import 'package:hospital_management_system/domain/nurse.dart';
import 'package:hospital_management_system/domain/admin_staff.dart';
import 'package:hospital_management_system/domain/staff.dart';

void main() {
  group('Doctor Class Tests', () {
    test('Doctor can perform a checkup', () {
      final doctor = Doctor('D-101', 'Dr. Visal', Sex.Male, DateTime(2000, 3, 12),
          Position.Doctor, 'Cardiology', 2500, 'Heart Specialist', 12);
      expect(() => doctor.performCheckup(), returnsNormally);
    });

    test('Doctor salary should be positive', () {
      final doctor = Doctor('D-102', 'Dr. Dara', Sex.Male, DateTime(1999, 5, 20),
          Position.Doctor, 'Neuro', 3000, 'Brain Specialist', 8);
      expect(doctor.salary, greaterThan(0));
    });
  });

  group('Nurse Class Tests', () {
    test('Nurse can assist doctor', () {
      final nurse = Nurse('N-201', 'Nurse Layeang', Sex.Female, DateTime(1998, 6, 25),
          Position.Nurse, 'ICU', 1800, 'Night', 'Ward 5');
      expect(() => nurse.assistDoctor(), returnsNormally);
    });
  });

  group('Admin Staff Tests', () {
    test('Admin staff has valid role', () {
      final admin = AdminStaff('A-301', 'Sopheak', Sex.Female, DateTime(1997, 9, 10),
          Position.AdminStaff, 'HR', 2200, Role.HROfficer, 'A203');
      expect(admin.role, equals(Role.HROfficer));
    });
  });
}
