abstract class Staff {
  int id;
  String name;
  String department;
  double salary;

  Staff(this.id, this.name, this.department, this.salary);

  void displayInfo();

  double getSalary() => salary;
  void setSalary(double value) {
    if (value > 0) salary = value;
  }
}