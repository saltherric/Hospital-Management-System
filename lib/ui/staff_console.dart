import 'dart:io';
import '../data/staff_repository.dart';
import '../data/appointment_repository.dart';
import '../domain/staff.dart';
import '../domain/doctor.dart';
import '../domain/nurse.dart';
import '../domain/admin_staff.dart';
// import '../domain/appointment.dart';
// import '../domain/patient.dart';
import '../data/patient_repository.dart';

class StaffConsole {
  final repo = StaffRepository();

  void start() {
    repo.loadData();

    while (true) {
      print('╔════════════════════════════════════════════════════════════════════╗');
      print('║                        HOSPITAL STAFF SYSTEM                       ║');
      print('╠════════════════════════════════════════════════════════════════════╣');
      print('║  1. Add Staff                                                      ║');
      print('║  2. View All Staff                                                 ║');
      print('║  3. Search Staff                                                   ║');
      print('║  4. Remove Staff                                                   ║');
      print('║  5. Update Staff Info                                              ║');
      print('║  6. Perform Staff Action                                           ║');
      print('║  7. Exit                                                           ║');
      print('╚════════════════════════════════════════════════════════════════════╝');
      stdout.write('Choose an option (1-7): ');
      final choice = stdin.readLineSync();

      if (choice == '1') addStaff(repo);
      else if (choice == '2') repo.viewAll();
      else if (choice == '3') searchStaff(repo);
      else if (choice == '4') removeStaff(repo);
      else if (choice == '5') updateStaff(repo);
      else if (choice == '6') performStaffAction(repo);
      else if (choice == '7') break;
      else print('Invalid choice.');
    }
  }
}

// -------Add a new Staff 
void addStaff(StaffRepository repo) {
  stdout.write('Type (doctor/nurse/admin): ');
  final type = stdin.readLineSync()!.trim().toLowerCase();

  // Name
  stdout.write('Name: ');
  final name = stdin.readLineSync()!;

  // Sex
  stdout.write('Sex (Male/Female): ');
  final sexInput = stdin.readLineSync()!;
  final sex = Sex.values.firstWhere(
    (e) => e.name.toLowerCase() == sexInput.toLowerCase(),
  );

  // Date of birth
  stdout.write('DOB (YYYY-MM-DD): ');
  DateTime dob;
  while (true) {
    final input = stdin.readLineSync()!;
    try {
      dob = DateTime.parse(input);
      break;
    } catch (e) {
      print('Invalid date format. Please try again (example: 1999-09-23): ');
      stdout.write('DOB (YYYY-MM-DD): ');
    }
  }

  // Department
  stdout.write('Department: ');
  final dept = stdin.readLineSync()!;

  // Salary
  stdout.write('Salary: ');
  final salary = double.tryParse(stdin.readLineSync()!) ?? 0.0;

  // Type -> Doctor
  if (type == 'doctor') {
    stdout.write('Specialization: ');
    final spec = stdin.readLineSync()!;
    stdout.write('Patients Count: ');
    final count = int.tryParse(stdin.readLineSync()!) ?? 0;

    repo.addStaff(Doctor(null, name, sex, dob, Position.Doctor, dept, salary, spec, count));
  } 

  // Type -> Nurse
  else if (type == 'nurse') {
    stdout.write('Shift (Day/Night): ');
    final shift = stdin.readLineSync()!;
    stdout.write('Assigned Ward: ');
    final ward = stdin.readLineSync()!;

    repo.addStaff(Nurse(null, name, sex, dob, Position.Nurse, dept, salary, shift, ward));
  } 

  // Type -> Admin
  else if (type == 'admin') {
    stdout.write('Role (HROfficer/Accountant): ');
    final roleInput = stdin.readLineSync()!;
    final role = Role.values.firstWhere(
      (e) => e.name.toLowerCase() == roleInput.toLowerCase(),
    );
    stdout.write('Office Number: ');
    final office = stdin.readLineSync()!;
    repo.addStaff(AdminStaff(null, name, sex, dob, Position.AdminStaff, dept, salary, role, office));
  } 
  else {
    print('Invalid staff type.');
    return;
  }

  print('===>Staff added successfully!');
}

// -------Search Staff by id
void searchStaff(StaffRepository repo) {
  stdout.write('Enter ID: ');
  final id = stdin.readLineSync()!;
  final s = repo.findById(id);

  if (s == null) {
    print('----------------------------------');
    print(' Staff not found with ID: $id');
    print('----------------------------------');
  } else {
    print('\n==================================');
    print('         STAFF INFORMATION         ');
    print('==================================');
    print('Type: ${s.runtimeType}');
    print('----------------------------------');
    s.displayInfo();
    print('==================================');
  }
}

// -------Remove Staff by id
void removeStaff(StaffRepository repo) {
  stdout.write('Enter ID to remove: ');
  final id = stdin.readLineSync()!;
  repo.removeStaff(id);
  print('===>Staff has been removed!');
}

// -------Update existing Staff 
void updateStaff(StaffRepository repo) {
  stdout.write('Enter Staff ID to update: ');
  final id = stdin.readLineSync()!;
  final staff = repo.findById(id);

  if (staff == null) {
    print('No staff found with ID $id');
    return;
  }

  print('\n===> Updating Staff Information <===');
  staff.displayInfo();

  stdout.write('Enter new name (leave blank to keep current): ');
  final newName = stdin.readLineSync()!;
  if (newName.isNotEmpty) staff.updateName(newName);

  stdout.write('Enter new department (leave blank to keep current): ');
  final newDept = stdin.readLineSync()!;
  if (newDept.isNotEmpty) staff.updateDepartment(newDept);

  stdout.write('Enter new salary (leave blank to keep current): ');
  final newSalaryInput = stdin.readLineSync()!;
  if (newSalaryInput.isNotEmpty) {
    final newSalary = double.tryParse(newSalaryInput);
    if (newSalary != null) staff.updateSalary(newSalary);
  }

  repo.saveAll(); 
  print('===> Staff info updated successfully! <===');
}

//  Perform Staff Action
void performStaffAction(StaffRepository repo) {
  stdout.write('Enter Staff ID to perform action: ');
  final id = stdin.readLineSync()!;
  final staff = repo.findById(id);

  if (staff == null) {
    print('No staff found with ID $id');
    return;
  }

  bool inActionMenu = true;

  while (inActionMenu) {
    print('\n===> Performing Action for ${staff.runtimeType} <===');

  //--------------Doctor--------------
    if (staff is Doctor) {
      print('1. Perform Checkup');
      print('2. Back to Main Menu');
      stdout.write('Choose: ');
      final choice = stdin.readLineSync()!;

      switch (choice) {
        case '1':
          // Display all assigned appointments for this doctor
          final appointmentRepo = AppointmentRepository();
          final list = appointmentRepo.getAppointmentsForDoctor(staff.id);

          if (list.isEmpty) {
            print('\n No appointments assigned for Dr. ${staff.name}.\n');
            break;
          } else {
            print('\n Assigned Appointments for Dr. ${staff.name}');
            print('--------------------------------------------');
            for (var a in list) {
              print('- Patient: ${a.patientId} on ${a.startTime}');
            }
            print('--------------------------------------------\n');
          }

          // Perform checkup on a patient
          stdout.write('Enter Patient ID to perform checkup: ');
          final patientId = stdin.readLineSync()!;

          // Verify the appointment
          final hasAppointment = appointmentRepo.hasAppointment(staff.id, patientId);

          if (!hasAppointment) {
            print('\nDoctor ${staff.name} has no appointment assigned with patient "$patientId".');
            print('Please ask AdminStaff to schedule one first.\n');
            break;
          }

          // Load patient record
          final patientRepo = PatientRepository();
          var patient = patientRepo.findById(patientId);

          // Perform checkup
          staff.performCheckup(patient!);

          // Save patient record after checkup
          patientRepo.saveOrUpdate(patient);

          print('Patient record saved successfully!\n');
          break;

        case '2':
          inActionMenu = false;
          break;

        default:
          print('Invalid choice.');
      }
    }

    else if (staff is Nurse) {
      print('1. Update Patient Status');
      print('2. Back to Main Menu');
      stdout.write('Choose: ');
      final choice = stdin.readLineSync()!;

      switch (choice) {
        case '1':
          stdout.write('Enter Patient Name: ');
          final patientName = stdin.readLineSync()!;
          stdout.write('Enter New Status (Recovering/Discharged/Critical): ');
          final newStatus = stdin.readLineSync()!;

          final patientRepo = PatientRepository();
          final patient = patientRepo.findById(patientName);

          if (patient == null) {
            print('\n Patient not found.');
            break;
          }

          staff.updatePatientStatus(patient, newStatus);
          break;

        case '2':
          inActionMenu = false;
          break;

        default:
          print('Invalid choice.');
      }
    }


  //--------------AdminStaff--------------
    else if (staff is AdminStaff) {
      final appointmentRepo = AppointmentRepository();

      print('1. Manage Appointments');
      print('2. Back to Main Menu');
      stdout.write('Choose: ');
      final choice = stdin.readLineSync()!;
      switch (choice) {
        case '1':
          stdout.write('Enter Doctor ID: ');
          final doctorId = stdin.readLineSync()!;
          stdout.write('Enter patient ID: ');
          final patientId = stdin.readLineSync()!;
          stdout.write('Enter Appointment Date (YYYY-MM-DD HH:MM): ');
          final startTime = stdin.readLineSync()!;

          final appointment = staff.scheduleAppointment(doctorId, patientId, startTime);
          appointmentRepo.addAppointment(appointment);

          print('\n Appointment scheduled successfully!');
          print('----------------------------------');
          appointment.displayAppointment();
          print('----------------------------------');
          break;      
        case '2':
          inActionMenu = false;
          break;
        default:
          print('Invalid choice.');
      }
    } 

    else {
      print('No actions available for this staff type.');
      inActionMenu = false;
    }
  }
}
