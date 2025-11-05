import '../domain/staff.dart';
import '../domain/doctor.dart';
// import '../domain/nurse.dart';
import 'dart:io';
import 'dart:convert';

// JSON save/load logic here

class StaffRepository {
  List<Staff> staffList = [];

  final String doctorFile = 'data/doctor.json';
  // ..........nurseFile..=.......nurse.json..;

  // Load data from JSON
  void loadData() {
    staffList.clear();
    staffList.addAll(_load(doctorFile, 'doctor'));
    // ....................nurseFile....nurse....;
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
    // else if (s is Nurse)

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

  // Save all Doctors again (used after deletion)
  void _saveAll() {
    File(doctorFile).writeAsStringSync(
      JsonEncoder.withIndent('  ').convert(
        staffList
            .where((s) => s is Doctor)
            .map((s) => s.toJson())
            .toList(),
      ),
    );
  }

  // Load all Doctors from JSON
  List<Staff> _load(String path, String type) {
    final f = File(path);
    if (!f.existsSync()) return [];

    final content = f.readAsStringSync();
    if (content.isEmpty) return [];

    final List data = jsonDecode(content);
    switch (type) {
      case 'doctor':
        return data.map((e) => Doctor.fromJson(e)).toList();
      default:
        return [];
    }
  }
}
