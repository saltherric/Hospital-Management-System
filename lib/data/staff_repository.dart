import '../domain/staff.dart';
import '../domain/doctor.dart';
import '../domain/nurse.dart';
import '../domain/admin_staff.dart';
import 'dart:io';
import 'dart:convert';

// JSON save/load logic here
class StaffRepository {
  List<Staff> staffList = [];

  final String doctorFile = 'data/doctor.json';
  final String nurseFile = 'data/nurse.json';
  final String adminFile = 'data/admin.json';

  // Load data from JSON
  void loadData() {
    staffList.clear();
    staffList.addAll(_load(doctorFile, 'doctor'));
    staffList.addAll(_load(nurseFile, 'nurse')); // Added for Nurse
    staffList.addAll(_load(adminFile, 'admin')); // Added for Admin
  }

  // Add a new Staff 
  void addStaff(Staff s) {
    staffList.add(s);
    _save(s);
  }

  // View all staff
  void viewAll() {
    if (staffList.isEmpty) {
      print('No staff found!');
      return;
    }
    for (var s in staffList) {
      print('-----------------------------');
      s.displayInfo();
    }
  }

  // Search by ID (String)
  Staff? findById(String id) {
    try {
      return staffList.firstWhere((s) => s.id == id);
    } catch (e) {
      return null;
    }
  }

  // Remove staff by ID
  void removeStaff(String id) {
    staffList.removeWhere((s) => s.id == id);
    _saveAll();
  }

  // Save one Staff
  void _save(Staff s) {
    late String file;
    if (s is Doctor) file = doctorFile;
    else if (s is Nurse) file = nurseFile; // Added for Nurse
    else if (s is AdminStaff) file = adminFile; // Added for Admin
    else return;

    final f = File(file);
    List data = [];
    if (f.existsSync()) {
      final content = f.readAsStringSync();
      if (content.isNotEmpty) {
        data = jsonDecode(content);
      }
    }

    data.add(s.toJson());
    f.writeAsStringSync(JsonEncoder.withIndent('  ').convert(data));
  }

  // Save all Staff again (used after deletion)
  void _saveAll() {
    // Doctor
    File(doctorFile).writeAsStringSync(
      JsonEncoder.withIndent('  ').convert(
        staffList
            .where((s) => s is Doctor)
            .map((s) => s.toJson())
            .toList(),
      ),
    );

    // Nurse
    File(nurseFile).writeAsStringSync(
      JsonEncoder.withIndent('  ').convert(
        staffList
            .where((s) => s is Nurse)
            .map((s) => s.toJson())
            .toList(),
      ),
    );

    // Admin
    File(adminFile).writeAsStringSync(
      JsonEncoder.withIndent('  ').convert(
        staffList
            .where((s) => s is AdminStaff)
            .map((s) => s.toJson())
            .toList(),
      ),
    );
  }

  // Load all Staff from JSON
  List<Staff> _load(String path, String type) {
    final f = File(path);
    if (!f.existsSync()) return [];

    final content = f.readAsStringSync();
    if (content.isEmpty) return [];

    final List data = jsonDecode(content);
    switch (type) {
      case 'doctor':
        return data.map((e) => Doctor.fromJson(e)).toList();
      case 'nurse': // Added for Nurse
        return data.map((e) => Nurse.fromJson(e)).toList();
      case 'admin': // Added for Admin
        return data.map((e) => AdminStaff.fromJson(e)).toList();
      default:
        return [];
    }
  }
}
