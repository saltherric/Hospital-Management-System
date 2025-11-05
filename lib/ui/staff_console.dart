import 'dart:io';
import '../data/staff_repository.dart';
import '../domain/staff.dart';
import '../domain/doctor.dart';
import '../domain/nurse.dart';
import '../domain/admin_staff.dart';

// Handles user input/output
class StaffConsole {
  final repo = StaffRepository();

  void start() {
    repo.loadData();
    print('=====>Data loaded successfully<=====');

    while (true) {
      print('\n HOSPITAL STAFF SYSTEM');
      print('1. Add Staff');
      print('2. View All Staff');
      print('3. Search Staff by ID');
      print('4. Remove Staff');
      print('5. Exit');
      stdout.write('Choose: ');
      final choice = stdin.readLineSync();

      if (choice == '1') addStaff(repo);
      else if (choice == '2') repo.viewAll();
      else if (choice == '3') searchStaff(repo);
      else if (choice == '4') removeStaff(repo);
      else if (choice == '5') break;
      else print('Invalid choice.');
    }
  }
}

void addStaff(StaffRepository repo) {
  stdout.write('Type (doctor/nurse/admin): ');
  final type = stdin.readLineSync()!.toLowerCase();

  stdout.write('ID: ');
  final id = stdin.readLineSync()!;

  stdout.write('Name: ');
  final name = stdin.readLineSync()!;

  stdout.write('Sex (Male/Female): ');
  final sex = Sex.values.firstWhere(
    (e) => e.name.toLowerCase() == stdin.readLineSync()!.toLowerCase(),
    orElse: () => Sex.Male,
  );

  stdout.write('DOB (YYYY-MM-DD): ');
  DateTime dob;
  try {
    dob = DateTime.parse(stdin.readLineSync()!);
  } catch (e) {
    print('Invalid date format. Defaulting to 2000-01-01.');
    dob = DateTime(2000, 1, 1);
  }

  stdout.write('Department: ');
  final dept = stdin.readLineSync()!;

  stdout.write('Salary: ');
  final salary = double.tryParse(stdin.readLineSync()!) ?? 0.0;

  if (type == 'doctor') {
    stdout.write('Specialization: ');
    final spec = stdin.readLineSync()!;
    stdout.write('Patients Count: ');
    final count = int.tryParse(stdin.readLineSync()!) ?? 0;
    repo.addStaff(Doctor(id, name, sex, dob, Position.Doctor, dept, salary, spec, count));
  } 
  else if (type == 'nurse') {
    stdout.write('Shift (Day/Night): ');
    final shift = stdin.readLineSync()!;
    stdout.write('Assigned Ward: ');
    final ward = stdin.readLineSync()!;
    repo.addStaff(Nurse(id, name, sex, dob, Position.Nurse, dept, salary, shift, ward));
  } 
  else if (type == 'admin') {
    stdout.write('Role (HROfficer/Accountant/ITManager): ');
    final roleInput = stdin.readLineSync()!;
    final role = Role.values.firstWhere(
      (e) => e.name.toLowerCase() == roleInput.toLowerCase(),
      orElse: () => Role.HROfficer,
    );
    stdout.write('Office Number: ');
    final office = stdin.readLineSync()!;
    repo.addStaff(AdminStaff(id, name, sex, dob, Position.AdminStaff, dept, salary, role, office));
  } 
  else {
    print('Invalid staff type.');
    return;
  }

  print('=====>Staff added successfully<=====');
}

void searchStaff(StaffRepository repo) {
  stdout.write('Enter ID: ');
  final id = stdin.readLineSync()!;
  final s = repo.findById(id);
  if (s == null) print('Staff not found.');
  else s.displayInfo();
}

void removeStaff(StaffRepository repo) {
  stdout.write('Enter ID to remove: ');
  final id = stdin.readLineSync()!;
  repo.removeStaff(id);
  print('=====>Staff has been removed<=====');
}
