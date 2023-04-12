import 'dart:convert';

class Student {
  String name;
  String regdNo;
  String dob;
  String branch;
  String sec;
  String email;
  String mname;
  String phone;
  String cstatename;
  String? bloodgroup;
  Student({
    required this.name,
    required this.regdNo,
    required this.dob,
    required this.branch,
    required this.sec,
    required this.email,
    required this.mname,
    required this.phone,
    required this.cstatename,
    this.bloodgroup,
  });
}
